//============================================================================
// Native types. All native functions take extended handle types when
// possible to help prevent passing bad values to native functions
//
type agent			    extends     handle  // all reference counted objects
type event              extends     agent  // a reference to an event registration
type player             extends     agent  // a single player reference
type widget             extends     agent  // an interactive game object with life
type unit               extends     widget  // a single unit reference
type destructable       extends     widget
type item               extends     widget
type ability            extends     agent
type buff               extends     ability
type force              extends     agent
type group              extends     agent
type trigger            extends     agent
type triggercondition   extends     agent
type triggeraction      extends     handle
type timer              extends     agent
type location           extends     agent
type region             extends     agent
type rect               extends     agent
type boolexpr           extends     agent
type sound              extends     agent
type conditionfunc      extends     boolexpr
type filterfunc         extends     boolexpr
type unitpool           extends     handle
type itempool           extends     handle
type race               extends     handle
type alliancetype       extends     handle
type racepreference     extends     handle
type gamestate          extends     handle
type igamestate         extends     gamestate
type fgamestate         extends     gamestate
type playerstate        extends     handle
type playerscore        extends     handle
type playergameresult   extends     handle
type unitstate          extends     handle
type aidifficulty       extends     handle

type eventid            extends     handle
type gameevent          extends     eventid
type playerevent        extends     eventid
type playerunitevent    extends     eventid
type unitevent          extends     eventid
type limitop            extends     eventid
type widgetevent        extends     eventid
type dialogevent        extends     eventid
type unittype           extends     handle

type gamespeed          extends     handle
type gamedifficulty     extends     handle
type gametype           extends     handle
type mapflag            extends     handle
type mapvisibility      extends     handle
type mapsetting         extends     handle
type mapdensity         extends     handle
type mapcontrol         extends     handle
type minimapicon        extends     handle
type playerslotstate    extends     handle
type volumegroup        extends     handle
type camerafield        extends     handle
type camerasetup        extends     handle
type playercolor        extends     handle
type placement          extends     handle
type startlocprio       extends     handle
type raritycontrol      extends     handle
type blendmode          extends     handle
type texmapflags        extends     handle
type effect             extends     agent
type effecttype         extends     handle
type weathereffect      extends     handle
type terraindeformation extends     handle
type fogstate           extends     handle
type fogmodifier        extends     agent
type dialog             extends     agent
type button             extends     agent
type quest              extends     agent
type questitem          extends     agent
type defeatcondition    extends     agent
type timerdialog        extends     agent
type leaderboard        extends     agent
type multiboard         extends     agent
type multiboarditem     extends     agent
type trackable          extends     agent
type gamecache          extends     agent
type version            extends     handle
type itemtype           extends     handle
type texttag            extends     handle
type attacktype         extends     handle
type damagetype         extends     handle
type weapontype         extends     handle
type soundtype          extends     handle
type lightning          extends     handle
type pathingtype        extends     handle
type mousebuttontype    extends     handle
type animtype           extends     handle
type subanimtype        extends     handle
type image              extends     handle
type ubersplat          extends     handle
type hashtable          extends     agent
type framehandle        extends     handle
type originframetype    extends     handle
type framepointtype     extends     handle
type textaligntype      extends     handle
type frameeventtype     extends     handle
type oskeytype          extends     handle
type abilityintegerfield            extends handle
type abilityrealfield               extends handle
type abilitybooleanfield            extends handle
type abilitystringfield             extends handle
type abilityintegerlevelfield       extends handle
type abilityreallevelfield          extends handle
type abilitybooleanlevelfield       extends handle
type abilitystringlevelfield        extends handle
type abilityintegerlevelarrayfield  extends handle
type abilityreallevelarrayfield     extends handle
type abilitybooleanlevelarrayfield  extends handle
type abilitystringlevelarrayfield   extends handle
type unitintegerfield               extends handle
type unitrealfield                  extends handle
type unitbooleanfield               extends handle
type unitstringfield                extends handle
type unitweaponintegerfield         extends handle
type unitweaponrealfield            extends handle
type unitweaponbooleanfield         extends handle
type unitweaponstringfield          extends handle
type itemintegerfield               extends handle
type itemrealfield                  extends handle
type itembooleanfield               extends handle
type itemstringfield                extends handle
type movetype                       extends handle
type targetflag                     extends handle
type armortype                      extends handle
type heroattribute                  extends handle
type defensetype                    extends handle
type regentype                      extends handle
type unitcategory                   extends handle
type pathingflag                    extends handle
type commandbuttoneffect            extends handle


constant native ConvertRace                 takes integer i returns race
constant native ConvertAllianceType         takes integer i returns alliancetype
constant native ConvertRacePref             takes integer i returns racepreference
constant native ConvertIGameState           takes integer i returns igamestate
constant native ConvertFGameState           takes integer i returns fgamestate
constant native ConvertPlayerState          takes integer i returns playerstate
constant native ConvertPlayerScore          takes integer i returns playerscore
constant native ConvertPlayerGameResult     takes integer i returns playergameresult
constant native ConvertUnitState            takes integer i returns unitstate
constant native ConvertAIDifficulty         takes integer i returns aidifficulty
constant native ConvertGameEvent            takes integer i returns gameevent
constant native ConvertPlayerEvent          takes integer i returns playerevent
constant native ConvertPlayerUnitEvent      takes integer i returns playerunitevent
constant native ConvertWidgetEvent          takes integer i returns widgetevent
constant native ConvertDialogEvent          takes integer i returns dialogevent
constant native ConvertUnitEvent            takes integer i returns unitevent
constant native ConvertLimitOp              takes integer i returns limitop
constant native ConvertUnitType             takes integer i returns unittype
constant native ConvertGameSpeed            takes integer i returns gamespeed
constant native ConvertPlacement            takes integer i returns placement
constant native ConvertStartLocPrio         takes integer i returns startlocprio
constant native ConvertGameDifficulty       takes integer i returns gamedifficulty
constant native ConvertGameType             takes integer i returns gametype
constant native ConvertMapFlag              takes integer i returns mapflag
constant native ConvertMapVisibility        takes integer i returns mapvisibility
constant native ConvertMapSetting           takes integer i returns mapsetting
constant native ConvertMapDensity           takes integer i returns mapdensity
constant native ConvertMapControl           takes integer i returns mapcontrol
constant native ConvertPlayerColor          takes integer i returns playercolor
constant native ConvertPlayerSlotState      takes integer i returns playerslotstate
constant native ConvertVolumeGroup          takes integer i returns volumegroup
constant native ConvertCameraField          takes integer i returns camerafield
constant native ConvertBlendMode            takes integer i returns blendmode
constant native ConvertRarityControl        takes integer i returns raritycontrol
constant native ConvertTexMapFlags          takes integer i returns texmapflags
constant native ConvertFogState             takes integer i returns fogstate
constant native ConvertEffectType           takes integer i returns effecttype
constant native ConvertVersion              takes integer i returns version
constant native ConvertItemType             takes integer i returns itemtype
constant native ConvertAttackType           takes integer i returns attacktype
constant native ConvertDamageType           takes integer i returns damagetype
constant native ConvertWeaponType           takes integer i returns weapontype
constant native ConvertSoundType            takes integer i returns soundtype
constant native ConvertPathingType          takes integer i returns pathingtype
constant native ConvertMouseButtonType      takes integer i returns mousebuttontype
constant native ConvertAnimType             takes integer i returns animtype
constant native ConvertSubAnimType          takes integer i returns subanimtype
constant native ConvertOriginFrameType      takes integer i returns originframetype
constant native ConvertFramePointType       takes integer i returns framepointtype
constant native ConvertTextAlignType        takes integer i returns textaligntype
constant native ConvertFrameEventType       takes integer i returns frameeventtype
constant native ConvertOsKeyType            takes integer i returns oskeytype
constant native ConvertAbilityIntegerField              takes integer i returns abilityintegerfield
constant native ConvertAbilityRealField                 takes integer i returns abilityrealfield
constant native ConvertAbilityBooleanField              takes integer i returns abilitybooleanfield
constant native ConvertAbilityStringField               takes integer i returns abilitystringfield
constant native ConvertAbilityIntegerLevelField         takes integer i returns abilityintegerlevelfield
constant native ConvertAbilityRealLevelField            takes integer i returns abilityreallevelfield
constant native ConvertAbilityBooleanLevelField         takes integer i returns abilitybooleanlevelfield
constant native ConvertAbilityStringLevelField          takes integer i returns abilitystringlevelfield
constant native ConvertAbilityIntegerLevelArrayField    takes integer i returns abilityintegerlevelarrayfield
constant native ConvertAbilityRealLevelArrayField       takes integer i returns abilityreallevelarrayfield
constant native ConvertAbilityBooleanLevelArrayField    takes integer i returns abilitybooleanlevelarrayfield
constant native ConvertAbilityStringLevelArrayField     takes integer i returns abilitystringlevelarrayfield
constant native ConvertUnitIntegerField                 takes integer i returns unitintegerfield
constant native ConvertUnitRealField                    takes integer i returns unitrealfield
constant native ConvertUnitBooleanField                 takes integer i returns unitbooleanfield
constant native ConvertUnitStringField                  takes integer i returns unitstringfield
constant native ConvertUnitWeaponIntegerField           takes integer i returns unitweaponintegerfield
constant native ConvertUnitWeaponRealField              takes integer i returns unitweaponrealfield
constant native ConvertUnitWeaponBooleanField           takes integer i returns unitweaponbooleanfield
constant native ConvertUnitWeaponStringField            takes integer i returns unitweaponstringfield
constant native ConvertItemIntegerField                 takes integer i returns itemintegerfield
constant native ConvertItemRealField                    takes integer i returns itemrealfield
constant native ConvertItemBooleanField                 takes integer i returns itembooleanfield
constant native ConvertItemStringField                  takes integer i returns itemstringfield
constant native ConvertMoveType                         takes integer i returns movetype
constant native ConvertTargetFlag                       takes integer i returns targetflag
constant native ConvertArmorType                        takes integer i returns armortype
constant native ConvertHeroAttribute                    takes integer i returns heroattribute
constant native ConvertDefenseType                      takes integer i returns defensetype
constant native ConvertRegenType                        takes integer i returns regentype
constant native ConvertUnitCategory                     takes integer i returns unitcategory
constant native ConvertPathingFlag                      takes integer i returns pathingflag

constant native OrderId                     takes string  orderIdString     returns integer
constant native OrderId2String              takes integer orderId           returns string
constant native UnitId                      takes string  unitIdString      returns integer
constant native UnitId2String               takes integer unitId            returns string

// Not currently working correctly...
constant native AbilityId                   takes string  abilityIdString   returns integer
constant native AbilityId2String            takes integer abilityId         returns string

// Looks up the "name" field for any object (unit, item, ability)
constant native GetObjectName               takes integer objectId          returns string

constant native GetBJMaxPlayers             takes nothing returns integer
constant native GetBJPlayerNeutralVictim    takes nothing returns integer
constant native GetBJPlayerNeutralExtra     takes nothing returns integer
constant native GetBJMaxPlayerSlots         takes nothing returns integer
constant native GetPlayerNeutralPassive     takes nothing returns integer
constant native GetPlayerNeutralAggressive  takes nothing returns integer

globals

//===================================================
// Game Constants
//===================================================

    // pfff
    constant boolean            FALSE                           = false
    constant boolean            TRUE                            = true
    constant integer            JASS_MAX_ARRAY_SIZE             = 32768

    constant integer            PLAYER_NEUTRAL_PASSIVE          = GetPlayerNeutralPassive()
    constant integer            PLAYER_NEUTRAL_AGGRESSIVE       = GetPlayerNeutralAggressive()

    constant playercolor        PLAYER_COLOR_RED                = ConvertPlayerColor(0)
    constant playercolor        PLAYER_COLOR_BLUE               = ConvertPlayerColor(1)
    constant playercolor        PLAYER_COLOR_CYAN               = ConvertPlayerColor(2)
    constant playercolor        PLAYER_COLOR_PURPLE             = ConvertPlayerColor(3)
    constant playercolor        PLAYER_COLOR_YELLOW             = ConvertPlayerColor(4)
    constant playercolor        PLAYER_COLOR_ORANGE             = ConvertPlayerColor(5)
    constant playercolor        PLAYER_COLOR_GREEN              = ConvertPlayerColor(6)
    constant playercolor        PLAYER_COLOR_PINK               = ConvertPlayerColor(7)
    constant playercolor        PLAYER_COLOR_LIGHT_GRAY         = ConvertPlayerColor(8)
    constant playercolor        PLAYER_COLOR_LIGHT_BLUE         = ConvertPlayerColor(9)
    constant playercolor        PLAYER_COLOR_AQUA               = ConvertPlayerColor(10)
    constant playercolor        PLAYER_COLOR_BROWN              = ConvertPlayerColor(11)
    constant playercolor        PLAYER_COLOR_MAROON             = ConvertPlayerColor(12)
    constant playercolor        PLAYER_COLOR_NAVY               = ConvertPlayerColor(13)
    constant playercolor        PLAYER_COLOR_TURQUOISE          = ConvertPlayerColor(14)
    constant playercolor        PLAYER_COLOR_VIOLET             = ConvertPlayerColor(15)
    constant playercolor        PLAYER_COLOR_WHEAT              = ConvertPlayerColor(16)
    constant playercolor        PLAYER_COLOR_PEACH              = ConvertPlayerColor(17)
    constant playercolor        PLAYER_COLOR_MINT               = ConvertPlayerColor(18)
    constant playercolor        PLAYER_COLOR_LAVENDER           = ConvertPlayerColor(19)
    constant playercolor        PLAYER_COLOR_COAL               = ConvertPlayerColor(20)
    constant playercolor        PLAYER_COLOR_SNOW               = ConvertPlayerColor(21)
    constant playercolor        PLAYER_COLOR_EMERALD            = ConvertPlayerColor(22)
    constant playercolor        PLAYER_COLOR_PEANUT             = ConvertPlayerColor(23)

    constant race               RACE_HUMAN                      = ConvertRace(1)
    constant race               RACE_ORC                        = ConvertRace(2)
    constant race               RACE_UNDEAD                     = ConvertRace(3)
    constant race               RACE_NIGHTELF                   = ConvertRace(4)
    constant race               RACE_DEMON                      = ConvertRace(5)
    constant race               RACE_OTHER                      = ConvertRace(7)

    constant playergameresult   PLAYER_GAME_RESULT_VICTORY      = ConvertPlayerGameResult(0)
    constant playergameresult   PLAYER_GAME_RESULT_DEFEAT       = ConvertPlayerGameResult(1)
    constant playergameresult   PLAYER_GAME_RESULT_TIE          = ConvertPlayerGameResult(2)
    constant playergameresult   PLAYER_GAME_RESULT_NEUTRAL      = ConvertPlayerGameResult(3)

    constant alliancetype       ALLIANCE_PASSIVE                = ConvertAllianceType(0)
    constant alliancetype       ALLIANCE_HELP_REQUEST           = ConvertAllianceType(1)
    constant alliancetype       ALLIANCE_HELP_RESPONSE          = ConvertAllianceType(2)
    constant alliancetype       ALLIANCE_SHARED_XP              = ConvertAllianceType(3)
    constant alliancetype       ALLIANCE_SHARED_SPELLS          = ConvertAllianceType(4)
    constant alliancetype       ALLIANCE_SHARED_VISION          = ConvertAllianceType(5)
    constant alliancetype       ALLIANCE_SHARED_CONTROL         = ConvertAllianceType(6)
    constant alliancetype       ALLIANCE_SHARED_ADVANCED_CONTROL= ConvertAllianceType(7)
    constant alliancetype       ALLIANCE_RESCUABLE              = ConvertAllianceType(8)
    constant alliancetype       ALLIANCE_SHARED_VISION_FORCED   = ConvertAllianceType(9)

    constant version            VERSION_REIGN_OF_CHAOS          = ConvertVersion(0)
    constant version            VERSION_FROZEN_THRONE           = ConvertVersion(1)

    constant attacktype         ATTACK_TYPE_NORMAL              = ConvertAttackType(0)
    constant attacktype         ATTACK_TYPE_MELEE               = ConvertAttackType(1)
    constant attacktype         ATTACK_TYPE_PIERCE              = ConvertAttackType(2)
    constant attacktype         ATTACK_TYPE_SIEGE               = ConvertAttackType(3)
    constant attacktype         ATTACK_TYPE_MAGIC               = ConvertAttackType(4)
    constant attacktype         ATTACK_TYPE_CHAOS               = ConvertAttackType(5)
    constant attacktype         ATTACK_TYPE_HERO                = ConvertAttackType(6)

    constant damagetype         DAMAGE_TYPE_UNKNOWN             = ConvertDamageType(0)
    constant damagetype         DAMAGE_TYPE_NORMAL              = ConvertDamageType(4)
    constant damagetype         DAMAGE_TYPE_ENHANCED            = ConvertDamageType(5)
    constant damagetype         DAMAGE_TYPE_FIRE                = ConvertDamageType(8)
    constant damagetype         DAMAGE_TYPE_COLD                = ConvertDamageType(9)
    constant damagetype         DAMAGE_TYPE_LIGHTNING           = ConvertDamageType(10)
    constant damagetype         DAMAGE_TYPE_POISON              = ConvertDamageType(11)
    constant damagetype         DAMAGE_TYPE_DISEASE             = ConvertDamageType(12)
    constant damagetype         DAMAGE_TYPE_DIVINE              = ConvertDamageType(13)
    constant damagetype         DAMAGE_TYPE_MAGIC               = ConvertDamageType(14)
    constant damagetype         DAMAGE_TYPE_SONIC               = ConvertDamageType(15)
    constant damagetype         DAMAGE_TYPE_ACID                = ConvertDamageType(16)
    constant damagetype         DAMAGE_TYPE_FORCE               = ConvertDamageType(17)
    constant damagetype         DAMAGE_TYPE_DEATH               = ConvertDamageType(18)
    constant damagetype         DAMAGE_TYPE_MIND                = ConvertDamageType(19)
    constant damagetype         DAMAGE_TYPE_PLANT               = ConvertDamageType(20)
    constant damagetype         DAMAGE_TYPE_DEFENSIVE           = ConvertDamageType(21)
    constant damagetype         DAMAGE_TYPE_DEMOLITION          = ConvertDamageType(22)
    constant damagetype         DAMAGE_TYPE_SLOW_POISON         = ConvertDamageType(23)
    constant damagetype         DAMAGE_TYPE_SPIRIT_LINK         = ConvertDamageType(24)
    constant damagetype         DAMAGE_TYPE_SHADOW_STRIKE       = ConvertDamageType(25)
    constant damagetype         DAMAGE_TYPE_UNIVERSAL           = ConvertDamageType(26)

    constant weapontype         WEAPON_TYPE_WHOKNOWS            = ConvertWeaponType(0)
    constant weapontype         WEAPON_TYPE_METAL_LIGHT_CHOP    = ConvertWeaponType(1)
    constant weapontype         WEAPON_TYPE_METAL_MEDIUM_CHOP   = ConvertWeaponType(2)
    constant weapontype         WEAPON_TYPE_METAL_HEAVY_CHOP    = ConvertWeaponType(3)
    constant weapontype         WEAPON_TYPE_METAL_LIGHT_SLICE   = ConvertWeaponType(4)
    constant weapontype         WEAPON_TYPE_METAL_MEDIUM_SLICE  = ConvertWeaponType(5)
    constant weapontype         WEAPON_TYPE_METAL_HEAVY_SLICE   = ConvertWeaponType(6)
    constant weapontype         WEAPON_TYPE_METAL_MEDIUM_BASH   = ConvertWeaponType(7)
    constant weapontype         WEAPON_TYPE_METAL_HEAVY_BASH    = ConvertWeaponType(8)
    constant weapontype         WEAPON_TYPE_METAL_MEDIUM_STAB   = ConvertWeaponType(9)
    constant weapontype         WEAPON_TYPE_METAL_HEAVY_STAB    = ConvertWeaponType(10)
    constant weapontype         WEAPON_TYPE_WOOD_LIGHT_SLICE    = ConvertWeaponType(11)
    constant weapontype         WEAPON_TYPE_WOOD_MEDIUM_SLICE   = ConvertWeaponType(12)
    constant weapontype         WEAPON_TYPE_WOOD_HEAVY_SLICE    = ConvertWeaponType(13)
    constant weapontype         WEAPON_TYPE_WOOD_LIGHT_BASH     = ConvertWeaponType(14)
    constant weapontype         WEAPON_TYPE_WOOD_MEDIUM_BASH    = ConvertWeaponType(15)
    constant weapontype         WEAPON_TYPE_WOOD_HEAVY_BASH     = ConvertWeaponType(16)
    constant weapontype         WEAPON_TYPE_WOOD_LIGHT_STAB     = ConvertWeaponType(17)
    constant weapontype         WEAPON_TYPE_WOOD_MEDIUM_STAB    = ConvertWeaponType(18)
    constant weapontype         WEAPON_TYPE_CLAW_LIGHT_SLICE    = ConvertWeaponType(19)
    constant weapontype         WEAPON_TYPE_CLAW_MEDIUM_SLICE   = ConvertWeaponType(20)
    constant weapontype         WEAPON_TYPE_CLAW_HEAVY_SLICE    = ConvertWeaponType(21)
    constant weapontype         WEAPON_TYPE_AXE_MEDIUM_CHOP     = ConvertWeaponType(22)
    constant weapontype         WEAPON_TYPE_ROCK_HEAVY_BASH     = ConvertWeaponType(23)

    constant pathingtype        PATHING_TYPE_ANY                = ConvertPathingType(0)
    constant pathingtype        PATHING_TYPE_WALKABILITY        = ConvertPathingType(1)
    constant pathingtype        PATHING_TYPE_FLYABILITY         = ConvertPathingType(2)
    constant pathingtype        PATHING_TYPE_BUILDABILITY       = ConvertPathingType(3)
    constant pathingtype        PATHING_TYPE_PEONHARVESTPATHING = ConvertPathingType(4)
    constant pathingtype        PATHING_TYPE_BLIGHTPATHING      = ConvertPathingType(5)
    constant pathingtype        PATHING_TYPE_FLOATABILITY       = ConvertPathingType(6)
    constant pathingtype        PATHING_TYPE_AMPHIBIOUSPATHING  = ConvertPathingType(7)

    constant mousebuttontype    MOUSE_BUTTON_TYPE_LEFT          = ConvertMouseButtonType(1)
    constant mousebuttontype    MOUSE_BUTTON_TYPE_MIDDLE        = ConvertMouseButtonType(2)
    constant mousebuttontype    MOUSE_BUTTON_TYPE_RIGHT         = ConvertMouseButtonType(3)

    constant animtype           ANIM_TYPE_BIRTH                 = ConvertAnimType(0)
    constant animtype           ANIM_TYPE_DEATH                 = ConvertAnimType(1)
    constant animtype           ANIM_TYPE_DECAY                 = ConvertAnimType(2)
    constant animtype           ANIM_TYPE_DISSIPATE             = ConvertAnimType(3)
    constant animtype           ANIM_TYPE_STAND                 = ConvertAnimType(4)
    constant animtype           ANIM_TYPE_WALK                  = ConvertAnimType(5)
    constant animtype           ANIM_TYPE_ATTACK                = ConvertAnimType(6)
    constant animtype           ANIM_TYPE_MORPH                 = ConvertAnimType(7)
    constant animtype           ANIM_TYPE_SLEEP                 = ConvertAnimType(8)
    constant animtype           ANIM_TYPE_SPELL                 = ConvertAnimType(9)
    constant animtype           ANIM_TYPE_PORTRAIT              = ConvertAnimType(10)

    constant subanimtype        SUBANIM_TYPE_ROOTED             = ConvertSubAnimType(11)
    constant subanimtype        SUBANIM_TYPE_ALTERNATE_EX       = ConvertSubAnimType(12)
    constant subanimtype        SUBANIM_TYPE_LOOPING            = ConvertSubAnimType(13)
    constant subanimtype        SUBANIM_TYPE_SLAM               = ConvertSubAnimType(14)
    constant subanimtype        SUBANIM_TYPE_THROW              = ConvertSubAnimType(15)
    constant subanimtype        SUBANIM_TYPE_SPIKED             = ConvertSubAnimType(16)
    constant subanimtype        SUBANIM_TYPE_FAST               = ConvertSubAnimType(17)
    constant subanimtype        SUBANIM_TYPE_SPIN               = ConvertSubAnimType(18)
    constant subanimtype        SUBANIM_TYPE_READY              = ConvertSubAnimType(19)
    constant subanimtype        SUBANIM_TYPE_CHANNEL            = ConvertSubAnimType(20)
    constant subanimtype        SUBANIM_TYPE_DEFEND             = ConvertSubAnimType(21)
    constant subanimtype        SUBANIM_TYPE_VICTORY            = ConvertSubAnimType(22)
    constant subanimtype        SUBANIM_TYPE_TURN               = ConvertSubAnimType(23)
    constant subanimtype        SUBANIM_TYPE_LEFT               = ConvertSubAnimType(24)
    constant subanimtype        SUBANIM_TYPE_RIGHT              = ConvertSubAnimType(25)
    constant subanimtype        SUBANIM_TYPE_FIRE               = ConvertSubAnimType(26)
    constant subanimtype        SUBANIM_TYPE_FLESH              = ConvertSubAnimType(27)
    constant subanimtype        SUBANIM_TYPE_HIT                = ConvertSubAnimType(28)
    constant subanimtype        SUBANIM_TYPE_WOUNDED            = ConvertSubAnimType(29)
    constant subanimtype        SUBANIM_TYPE_LIGHT              = ConvertSubAnimType(30)
    constant subanimtype        SUBANIM_TYPE_MODERATE           = ConvertSubAnimType(31)
    constant subanimtype        SUBANIM_TYPE_SEVERE             = ConvertSubAnimType(32)
    constant subanimtype        SUBANIM_TYPE_CRITICAL           = ConvertSubAnimType(33)
    constant subanimtype        SUBANIM_TYPE_COMPLETE           = ConvertSubAnimType(34)
    constant subanimtype        SUBANIM_TYPE_GOLD               = ConvertSubAnimType(35)
    constant subanimtype        SUBANIM_TYPE_LUMBER             = ConvertSubAnimType(36)
    constant subanimtype        SUBANIM_TYPE_WORK               = ConvertSubAnimType(37)
    constant subanimtype        SUBANIM_TYPE_TALK               = ConvertSubAnimType(38)
    constant subanimtype        SUBANIM_TYPE_FIRST              = ConvertSubAnimType(39)
    constant subanimtype        SUBANIM_TYPE_SECOND             = ConvertSubAnimType(40)
    constant subanimtype        SUBANIM_TYPE_THIRD              = ConvertSubAnimType(41)
    constant subanimtype        SUBANIM_TYPE_FOURTH             = ConvertSubAnimType(42)
    constant subanimtype        SUBANIM_TYPE_FIFTH              = ConvertSubAnimType(43)
    constant subanimtype        SUBANIM_TYPE_ONE                = ConvertSubAnimType(44)
    constant subanimtype        SUBANIM_TYPE_TWO                = ConvertSubAnimType(45)
    constant subanimtype        SUBANIM_TYPE_THREE              = ConvertSubAnimType(46)
    constant subanimtype        SUBANIM_TYPE_FOUR               = ConvertSubAnimType(47)
    constant subanimtype        SUBANIM_TYPE_FIVE               = ConvertSubAnimType(48)
    constant subanimtype        SUBANIM_TYPE_SMALL              = ConvertSubAnimType(49)
    constant subanimtype        SUBANIM_TYPE_MEDIUM             = ConvertSubAnimType(50)
    constant subanimtype        SUBANIM_TYPE_LARGE              = ConvertSubAnimType(51)
    constant subanimtype        SUBANIM_TYPE_UPGRADE            = ConvertSubAnimType(52)
    constant subanimtype        SUBANIM_TYPE_DRAIN              = ConvertSubAnimType(53)
    constant subanimtype        SUBANIM_TYPE_FILL               = ConvertSubAnimType(54)
    constant subanimtype        SUBANIM_TYPE_CHAINLIGHTNING     = ConvertSubAnimType(55)
    constant subanimtype        SUBANIM_TYPE_EATTREE            = ConvertSubAnimType(56)
    constant subanimtype        SUBANIM_TYPE_PUKE               = ConvertSubAnimType(57)
    constant subanimtype        SUBANIM_TYPE_FLAIL              = ConvertSubAnimType(58)
    constant subanimtype        SUBANIM_TYPE_OFF                = ConvertSubAnimType(59)
    constant subanimtype        SUBANIM_TYPE_SWIM               = ConvertSubAnimType(60)
    constant subanimtype        SUBANIM_TYPE_ENTANGLE           = ConvertSubAnimType(61)
    constant subanimtype        SUBANIM_TYPE_BERSERK            = ConvertSubAnimType(62)

//===================================================
// Map Setup Constants
//===================================================

    constant racepreference     RACE_PREF_HUMAN                     = ConvertRacePref(1)
    constant racepreference     RACE_PREF_ORC                       = ConvertRacePref(2)
    constant racepreference     RACE_PREF_NIGHTELF                  = ConvertRacePref(4)
    constant racepreference     RACE_PREF_UNDEAD                    = ConvertRacePref(8)
    constant racepreference     RACE_PREF_DEMON                     = ConvertRacePref(16)
    constant racepreference     RACE_PREF_RANDOM                    = ConvertRacePref(32)
    constant racepreference     RACE_PREF_USER_SELECTABLE           = ConvertRacePref(64)

    constant mapcontrol         MAP_CONTROL_USER                    = ConvertMapControl(0)
    constant mapcontrol         MAP_CONTROL_COMPUTER                = ConvertMapControl(1)
    constant mapcontrol         MAP_CONTROL_RESCUABLE               = ConvertMapControl(2)
    constant mapcontrol         MAP_CONTROL_NEUTRAL                 = ConvertMapControl(3)
    constant mapcontrol         MAP_CONTROL_CREEP                   = ConvertMapControl(4)
    constant mapcontrol         MAP_CONTROL_NONE                    = ConvertMapControl(5)

    constant gametype           GAME_TYPE_MELEE                     = ConvertGameType(1)
    constant gametype           GAME_TYPE_FFA                       = ConvertGameType(2)
    constant gametype           GAME_TYPE_USE_MAP_SETTINGS          = ConvertGameType(4)
    constant gametype           GAME_TYPE_BLIZ                      = ConvertGameType(8)
    constant gametype           GAME_TYPE_ONE_ON_ONE                = ConvertGameType(16)
    constant gametype           GAME_TYPE_TWO_TEAM_PLAY             = ConvertGameType(32)
    constant gametype           GAME_TYPE_THREE_TEAM_PLAY           = ConvertGameType(64)
    constant gametype           GAME_TYPE_FOUR_TEAM_PLAY            = ConvertGameType(128)

    constant mapflag            MAP_FOG_HIDE_TERRAIN                = ConvertMapFlag(1)
    constant mapflag            MAP_FOG_MAP_EXPLORED                = ConvertMapFlag(2)
    constant mapflag            MAP_FOG_ALWAYS_VISIBLE              = ConvertMapFlag(4)

    constant mapflag            MAP_USE_HANDICAPS                   = ConvertMapFlag(8)
    constant mapflag            MAP_OBSERVERS                       = ConvertMapFlag(16)
    constant mapflag            MAP_OBSERVERS_ON_DEATH              = ConvertMapFlag(32)

    constant mapflag            MAP_FIXED_COLORS                    = ConvertMapFlag(128)

    constant mapflag            MAP_LOCK_RESOURCE_TRADING           = ConvertMapFlag(256)
    constant mapflag            MAP_RESOURCE_TRADING_ALLIES_ONLY    = ConvertMapFlag(512)

    constant mapflag            MAP_LOCK_ALLIANCE_CHANGES           = ConvertMapFlag(1024)
    constant mapflag            MAP_ALLIANCE_CHANGES_HIDDEN         = ConvertMapFlag(2048)

    constant mapflag            MAP_CHEATS                          = ConvertMapFlag(4096)
    constant mapflag            MAP_CHEATS_HIDDEN                   = ConvertMapFlag(8192)

    constant mapflag            MAP_LOCK_SPEED                      = ConvertMapFlag(8192*2)
    constant mapflag            MAP_LOCK_RANDOM_SEED                = ConvertMapFlag(8192*4)
    constant mapflag            MAP_SHARED_ADVANCED_CONTROL         = ConvertMapFlag(8192*8)
    constant mapflag            MAP_RANDOM_HERO                     = ConvertMapFlag(8192*16)
    constant mapflag            MAP_RANDOM_RACES                    = ConvertMapFlag(8192*32)
    constant mapflag            MAP_RELOADED                        = ConvertMapFlag(8192*64)

    constant placement          MAP_PLACEMENT_RANDOM                = ConvertPlacement(0)   // random among all slots
    constant placement          MAP_PLACEMENT_FIXED                 = ConvertPlacement(1)   // player 0 in start loc 0...
    constant placement          MAP_PLACEMENT_USE_MAP_SETTINGS      = ConvertPlacement(2)   // whatever was specified by the script
    constant placement          MAP_PLACEMENT_TEAMS_TOGETHER        = ConvertPlacement(3)   // random with allies next to each other

    constant startlocprio       MAP_LOC_PRIO_LOW                    = ConvertStartLocPrio(0)
    constant startlocprio       MAP_LOC_PRIO_HIGH                   = ConvertStartLocPrio(1)
    constant startlocprio       MAP_LOC_PRIO_NOT                    = ConvertStartLocPrio(2)

    constant mapdensity         MAP_DENSITY_NONE                    = ConvertMapDensity(0)
    constant mapdensity         MAP_DENSITY_LIGHT                   = ConvertMapDensity(1)
    constant mapdensity         MAP_DENSITY_MEDIUM                  = ConvertMapDensity(2)
    constant mapdensity         MAP_DENSITY_HEAVY                   = ConvertMapDensity(3)

    constant gamedifficulty     MAP_DIFFICULTY_EASY                 = ConvertGameDifficulty(0)
    constant gamedifficulty     MAP_DIFFICULTY_NORMAL               = ConvertGameDifficulty(1)
    constant gamedifficulty     MAP_DIFFICULTY_HARD                 = ConvertGameDifficulty(2)
    constant gamedifficulty     MAP_DIFFICULTY_INSANE               = ConvertGameDifficulty(3)

    constant gamespeed          MAP_SPEED_SLOWEST                   = ConvertGameSpeed(0)
    constant gamespeed          MAP_SPEED_SLOW                      = ConvertGameSpeed(1)
    constant gamespeed          MAP_SPEED_NORMAL                    = ConvertGameSpeed(2)
    constant gamespeed          MAP_SPEED_FAST                      = ConvertGameSpeed(3)
    constant gamespeed          MAP_SPEED_FASTEST                   = ConvertGameSpeed(4)

    constant playerslotstate    PLAYER_SLOT_STATE_EMPTY             = ConvertPlayerSlotState(0)
    constant playerslotstate    PLAYER_SLOT_STATE_PLAYING           = ConvertPlayerSlotState(1)
    constant playerslotstate    PLAYER_SLOT_STATE_LEFT              = ConvertPlayerSlotState(2)

//===================================================
// Sound Constants
//===================================================
    constant volumegroup        SOUND_VOLUMEGROUP_UNITMOVEMENT      = ConvertVolumeGroup(0)
    constant volumegroup        SOUND_VOLUMEGROUP_UNITSOUNDS        = ConvertVolumeGroup(1)
    constant volumegroup        SOUND_VOLUMEGROUP_COMBAT            = ConvertVolumeGroup(2)
    constant volumegroup        SOUND_VOLUMEGROUP_SPELLS            = ConvertVolumeGroup(3)
    constant volumegroup        SOUND_VOLUMEGROUP_UI                = ConvertVolumeGroup(4)
    constant volumegroup        SOUND_VOLUMEGROUP_MUSIC             = ConvertVolumeGroup(5)
    constant volumegroup        SOUND_VOLUMEGROUP_AMBIENTSOUNDS     = ConvertVolumeGroup(6)
    constant volumegroup        SOUND_VOLUMEGROUP_FIRE              = ConvertVolumeGroup(7)
//Cinematic Sound Constants
    constant volumegroup        SOUND_VOLUMEGROUP_CINEMATIC_GENERAL         = ConvertVolumeGroup(8)
    constant volumegroup        SOUND_VOLUMEGROUP_CINEMATIC_AMBIENT         = ConvertVolumeGroup(9)
    constant volumegroup        SOUND_VOLUMEGROUP_CINEMATIC_MUSIC           = ConvertVolumeGroup(10)
    constant volumegroup        SOUND_VOLUMEGROUP_CINEMATIC_DIALOGUE        = ConvertVolumeGroup(11)
    constant volumegroup        SOUND_VOLUMEGROUP_CINEMATIC_SOUND_EFFECTS_1 = ConvertVolumeGroup(12)
    constant volumegroup        SOUND_VOLUMEGROUP_CINEMATIC_SOUND_EFFECTS_2 = ConvertVolumeGroup(13)
    constant volumegroup        SOUND_VOLUMEGROUP_CINEMATIC_SOUND_EFFECTS_3 = ConvertVolumeGroup(14)


//===================================================
// Game, Player, and Unit States
//
// For use with TriggerRegister<X>StateEvent
//
//===================================================

    constant igamestate GAME_STATE_DIVINE_INTERVENTION          = ConvertIGameState(0)
    constant igamestate GAME_STATE_DISCONNECTED                 = ConvertIGameState(1)
    constant fgamestate GAME_STATE_TIME_OF_DAY                  = ConvertFGameState(2)

    constant playerstate PLAYER_STATE_GAME_RESULT               = ConvertPlayerState(0)

    // current resource levels
    //
    constant playerstate PLAYER_STATE_RESOURCE_GOLD             = ConvertPlayerState(1)
    constant playerstate PLAYER_STATE_RESOURCE_LUMBER           = ConvertPlayerState(2)
    constant playerstate PLAYER_STATE_RESOURCE_HERO_TOKENS      = ConvertPlayerState(3)
    constant playerstate PLAYER_STATE_RESOURCE_FOOD_CAP         = ConvertPlayerState(4)
    constant playerstate PLAYER_STATE_RESOURCE_FOOD_USED        = ConvertPlayerState(5)
    constant playerstate PLAYER_STATE_FOOD_CAP_CEILING          = ConvertPlayerState(6)

    constant playerstate PLAYER_STATE_GIVES_BOUNTY              = ConvertPlayerState(7)
    constant playerstate PLAYER_STATE_ALLIED_VICTORY            = ConvertPlayerState(8)
    constant playerstate PLAYER_STATE_PLACED                    = ConvertPlayerState(9)
    constant playerstate PLAYER_STATE_OBSERVER_ON_DEATH         = ConvertPlayerState(10)
    constant playerstate PLAYER_STATE_OBSERVER                  = ConvertPlayerState(11)
    constant playerstate PLAYER_STATE_UNFOLLOWABLE              = ConvertPlayerState(12)

    // taxation rate for each resource
    //
    constant playerstate PLAYER_STATE_GOLD_UPKEEP_RATE          = ConvertPlayerState(13)
    constant playerstate PLAYER_STATE_LUMBER_UPKEEP_RATE        = ConvertPlayerState(14)

    // cumulative resources collected by the player during the mission
    //
    constant playerstate PLAYER_STATE_GOLD_GATHERED             = ConvertPlayerState(15)
    constant playerstate PLAYER_STATE_LUMBER_GATHERED           = ConvertPlayerState(16)

    constant playerstate PLAYER_STATE_NO_CREEP_SLEEP            = ConvertPlayerState(25)

    constant unitstate UNIT_STATE_LIFE                          = ConvertUnitState(0)
    constant unitstate UNIT_STATE_MAX_LIFE                      = ConvertUnitState(1)
    constant unitstate UNIT_STATE_MANA                          = ConvertUnitState(2)
    constant unitstate UNIT_STATE_MAX_MANA                      = ConvertUnitState(3)

    constant aidifficulty AI_DIFFICULTY_NEWBIE                  = ConvertAIDifficulty(0)
    constant aidifficulty AI_DIFFICULTY_NORMAL                  = ConvertAIDifficulty(1)
    constant aidifficulty AI_DIFFICULTY_INSANE                  = ConvertAIDifficulty(2)

    // player score values
    constant playerscore PLAYER_SCORE_UNITS_TRAINED             = ConvertPlayerScore(0)
    constant playerscore PLAYER_SCORE_UNITS_KILLED              = ConvertPlayerScore(1)
    constant playerscore PLAYER_SCORE_STRUCT_BUILT              = ConvertPlayerScore(2)
    constant playerscore PLAYER_SCORE_STRUCT_RAZED              = ConvertPlayerScore(3)
    constant playerscore PLAYER_SCORE_TECH_PERCENT              = ConvertPlayerScore(4)
    constant playerscore PLAYER_SCORE_FOOD_MAXPROD              = ConvertPlayerScore(5)
    constant playerscore PLAYER_SCORE_FOOD_MAXUSED              = ConvertPlayerScore(6)
    constant playerscore PLAYER_SCORE_HEROES_KILLED             = ConvertPlayerScore(7)
    constant playerscore PLAYER_SCORE_ITEMS_GAINED              = ConvertPlayerScore(8)
    constant playerscore PLAYER_SCORE_MERCS_HIRED               = ConvertPlayerScore(9)
    constant playerscore PLAYER_SCORE_GOLD_MINED_TOTAL          = ConvertPlayerScore(10)
    constant playerscore PLAYER_SCORE_GOLD_MINED_UPKEEP         = ConvertPlayerScore(11)
    constant playerscore PLAYER_SCORE_GOLD_LOST_UPKEEP          = ConvertPlayerScore(12)
    constant playerscore PLAYER_SCORE_GOLD_LOST_TAX             = ConvertPlayerScore(13)
    constant playerscore PLAYER_SCORE_GOLD_GIVEN                = ConvertPlayerScore(14)
    constant playerscore PLAYER_SCORE_GOLD_RECEIVED             = ConvertPlayerScore(15)
    constant playerscore PLAYER_SCORE_LUMBER_TOTAL              = ConvertPlayerScore(16)
    constant playerscore PLAYER_SCORE_LUMBER_LOST_UPKEEP        = ConvertPlayerScore(17)
    constant playerscore PLAYER_SCORE_LUMBER_LOST_TAX           = ConvertPlayerScore(18)
    constant playerscore PLAYER_SCORE_LUMBER_GIVEN              = ConvertPlayerScore(19)
    constant playerscore PLAYER_SCORE_LUMBER_RECEIVED           = ConvertPlayerScore(20)
    constant playerscore PLAYER_SCORE_UNIT_TOTAL                = ConvertPlayerScore(21)
    constant playerscore PLAYER_SCORE_HERO_TOTAL                = ConvertPlayerScore(22)
    constant playerscore PLAYER_SCORE_RESOURCE_TOTAL            = ConvertPlayerScore(23)
    constant playerscore PLAYER_SCORE_TOTAL                     = ConvertPlayerScore(24)

//===================================================
// Game, Player and Unit Events
//
//  When an event causes a trigger to fire these
//  values allow the action code to determine which
//  event was dispatched and therefore which set of
//  native functions should be used to get information
//  about the event.
//
// Do NOT change the order or value of these constants
// without insuring that the JASS_GAME_EVENTS_WAR3 enum
// is changed to match.
//
//===================================================

    //===================================================
    // For use with TriggerRegisterGameEvent
    //===================================================

    constant gameevent EVENT_GAME_VICTORY                       = ConvertGameEvent(0)
    constant gameevent EVENT_GAME_END_LEVEL                     = ConvertGameEvent(1)

    constant gameevent EVENT_GAME_VARIABLE_LIMIT                = ConvertGameEvent(2)
    constant gameevent EVENT_GAME_STATE_LIMIT                   = ConvertGameEvent(3)

    constant gameevent EVENT_GAME_TIMER_EXPIRED                 = ConvertGameEvent(4)

    constant gameevent EVENT_GAME_ENTER_REGION                  = ConvertGameEvent(5)
    constant gameevent EVENT_GAME_LEAVE_REGION                  = ConvertGameEvent(6)

    constant gameevent EVENT_GAME_TRACKABLE_HIT                 = ConvertGameEvent(7)
    constant gameevent EVENT_GAME_TRACKABLE_TRACK               = ConvertGameEvent(8)

    constant gameevent EVENT_GAME_SHOW_SKILL                    = ConvertGameEvent(9)
    constant gameevent EVENT_GAME_BUILD_SUBMENU                 = ConvertGameEvent(10)

    //===================================================
    // For use with TriggerRegisterPlayerEvent
    //===================================================
    constant playerevent EVENT_PLAYER_STATE_LIMIT               = ConvertPlayerEvent(11)
    constant playerevent EVENT_PLAYER_ALLIANCE_CHANGED          = ConvertPlayerEvent(12)

    constant playerevent EVENT_PLAYER_DEFEAT                    = ConvertPlayerEvent(13)
    constant playerevent EVENT_PLAYER_VICTORY                   = ConvertPlayerEvent(14)
    constant playerevent EVENT_PLAYER_LEAVE                     = ConvertPlayerEvent(15)
    constant playerevent EVENT_PLAYER_CHAT                      = ConvertPlayerEvent(16)
    constant playerevent EVENT_PLAYER_END_CINEMATIC             = ConvertPlayerEvent(17)

    //===================================================
    // For use with TriggerRegisterPlayerUnitEvent
    //===================================================

    constant playerunitevent EVENT_PLAYER_UNIT_ATTACKED                 = ConvertPlayerUnitEvent(18)
    constant playerunitevent EVENT_PLAYER_UNIT_RESCUED                  = ConvertPlayerUnitEvent(19)

    constant playerunitevent EVENT_PLAYER_UNIT_DEATH                    = ConvertPlayerUnitEvent(20)
    constant playerunitevent EVENT_PLAYER_UNIT_DECAY                    = ConvertPlayerUnitEvent(21)

    constant playerunitevent EVENT_PLAYER_UNIT_DETECTED                 = ConvertPlayerUnitEvent(22)
    constant playerunitevent EVENT_PLAYER_UNIT_HIDDEN                   = ConvertPlayerUnitEvent(23)

    constant playerunitevent EVENT_PLAYER_UNIT_SELECTED                 = ConvertPlayerUnitEvent(24)
    constant playerunitevent EVENT_PLAYER_UNIT_DESELECTED               = ConvertPlayerUnitEvent(25)

    constant playerunitevent EVENT_PLAYER_UNIT_CONSTRUCT_START          = ConvertPlayerUnitEvent(26)
    constant playerunitevent EVENT_PLAYER_UNIT_CONSTRUCT_CANCEL         = ConvertPlayerUnitEvent(27)
    constant playerunitevent EVENT_PLAYER_UNIT_CONSTRUCT_FINISH         = ConvertPlayerUnitEvent(28)

    constant playerunitevent EVENT_PLAYER_UNIT_UPGRADE_START            = ConvertPlayerUnitEvent(29)
    constant playerunitevent EVENT_PLAYER_UNIT_UPGRADE_CANCEL           = ConvertPlayerUnitEvent(30)
    constant playerunitevent EVENT_PLAYER_UNIT_UPGRADE_FINISH           = ConvertPlayerUnitEvent(31)

    constant playerunitevent EVENT_PLAYER_UNIT_TRAIN_START              = ConvertPlayerUnitEvent(32)
    constant playerunitevent EVENT_PLAYER_UNIT_TRAIN_CANCEL             = ConvertPlayerUnitEvent(33)
    constant playerunitevent EVENT_PLAYER_UNIT_TRAIN_FINISH             = ConvertPlayerUnitEvent(34)

    constant playerunitevent EVENT_PLAYER_UNIT_RESEARCH_START           = ConvertPlayerUnitEvent(35)
    constant playerunitevent EVENT_PLAYER_UNIT_RESEARCH_CANCEL          = ConvertPlayerUnitEvent(36)
    constant playerunitevent EVENT_PLAYER_UNIT_RESEARCH_FINISH          = ConvertPlayerUnitEvent(37)
    constant playerunitevent EVENT_PLAYER_UNIT_ISSUED_ORDER             = ConvertPlayerUnitEvent(38)
    constant playerunitevent EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER       = ConvertPlayerUnitEvent(39)
    constant playerunitevent EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER      = ConvertPlayerUnitEvent(40)
    constant playerunitevent EVENT_PLAYER_UNIT_ISSUED_UNIT_ORDER        = ConvertPlayerUnitEvent(40)    // for compat

    constant playerunitevent EVENT_PLAYER_HERO_LEVEL                    = ConvertPlayerUnitEvent(41)
    constant playerunitevent EVENT_PLAYER_HERO_SKILL                    = ConvertPlayerUnitEvent(42)

    constant playerunitevent EVENT_PLAYER_HERO_REVIVABLE                = ConvertPlayerUnitEvent(43)

    constant playerunitevent EVENT_PLAYER_HERO_REVIVE_START             = ConvertPlayerUnitEvent(44)
    constant playerunitevent EVENT_PLAYER_HERO_REVIVE_CANCEL            = ConvertPlayerUnitEvent(45)
    constant playerunitevent EVENT_PLAYER_HERO_REVIVE_FINISH            = ConvertPlayerUnitEvent(46)
    constant playerunitevent EVENT_PLAYER_UNIT_SUMMON                   = ConvertPlayerUnitEvent(47)
    constant playerunitevent EVENT_PLAYER_UNIT_DROP_ITEM                = ConvertPlayerUnitEvent(48)
    constant playerunitevent EVENT_PLAYER_UNIT_PICKUP_ITEM              = ConvertPlayerUnitEvent(49)
    constant playerunitevent EVENT_PLAYER_UNIT_USE_ITEM                 = ConvertPlayerUnitEvent(50)

    constant playerunitevent EVENT_PLAYER_UNIT_LOADED                   = ConvertPlayerUnitEvent(51)
    constant playerunitevent EVENT_PLAYER_UNIT_DAMAGED                  = ConvertPlayerUnitEvent(308)
    constant playerunitevent EVENT_PLAYER_UNIT_DAMAGING                 = ConvertPlayerUnitEvent(315)

    //===================================================
    // For use with TriggerRegisterUnitEvent
    //===================================================

    constant unitevent EVENT_UNIT_DAMAGED                               = ConvertUnitEvent(52)
    constant unitevent EVENT_UNIT_DAMAGING                              = ConvertUnitEvent(314)
    constant unitevent EVENT_UNIT_DEATH                                 = ConvertUnitEvent(53)
    constant unitevent EVENT_UNIT_DECAY                                 = ConvertUnitEvent(54)
    constant unitevent EVENT_UNIT_DETECTED                              = ConvertUnitEvent(55)
    constant unitevent EVENT_UNIT_HIDDEN                                = ConvertUnitEvent(56)
    constant unitevent EVENT_UNIT_SELECTED                              = ConvertUnitEvent(57)
    constant unitevent EVENT_UNIT_DESELECTED                            = ConvertUnitEvent(58)

    constant unitevent EVENT_UNIT_STATE_LIMIT                           = ConvertUnitEvent(59)

    // Events which may have a filter for the "other unit"
    //
    constant unitevent EVENT_UNIT_ACQUIRED_TARGET                       = ConvertUnitEvent(60)
    constant unitevent EVENT_UNIT_TARGET_IN_RANGE                       = ConvertUnitEvent(61)
    constant unitevent EVENT_UNIT_ATTACKED                              = ConvertUnitEvent(62)
    constant unitevent EVENT_UNIT_RESCUED                               = ConvertUnitEvent(63)

    constant unitevent EVENT_UNIT_CONSTRUCT_CANCEL                      = ConvertUnitEvent(64)
    constant unitevent EVENT_UNIT_CONSTRUCT_FINISH                      = ConvertUnitEvent(65)

    constant unitevent EVENT_UNIT_UPGRADE_START                         = ConvertUnitEvent(66)
    constant unitevent EVENT_UNIT_UPGRADE_CANCEL                        = ConvertUnitEvent(67)
    constant unitevent EVENT_UNIT_UPGRADE_FINISH                        = ConvertUnitEvent(68)

    // Events which involve the specified unit performing
    // training of other units
    //
    constant unitevent EVENT_UNIT_TRAIN_START                           = ConvertUnitEvent(69)
    constant unitevent EVENT_UNIT_TRAIN_CANCEL                          = ConvertUnitEvent(70)
    constant unitevent EVENT_UNIT_TRAIN_FINISH                          = ConvertUnitEvent(71)

    constant unitevent EVENT_UNIT_RESEARCH_START                        = ConvertUnitEvent(72)
    constant unitevent EVENT_UNIT_RESEARCH_CANCEL                       = ConvertUnitEvent(73)
    constant unitevent EVENT_UNIT_RESEARCH_FINISH                       = ConvertUnitEvent(74)

    constant unitevent EVENT_UNIT_ISSUED_ORDER                          = ConvertUnitEvent(75)
    constant unitevent EVENT_UNIT_ISSUED_POINT_ORDER                    = ConvertUnitEvent(76)
    constant unitevent EVENT_UNIT_ISSUED_TARGET_ORDER                   = ConvertUnitEvent(77)

    constant unitevent EVENT_UNIT_HERO_LEVEL                            = ConvertUnitEvent(78)
    constant unitevent EVENT_UNIT_HERO_SKILL                            = ConvertUnitEvent(79)

    constant unitevent EVENT_UNIT_HERO_REVIVABLE                        = ConvertUnitEvent(80)
    constant unitevent EVENT_UNIT_HERO_REVIVE_START                     = ConvertUnitEvent(81)
    constant unitevent EVENT_UNIT_HERO_REVIVE_CANCEL                    = ConvertUnitEvent(82)
    constant unitevent EVENT_UNIT_HERO_REVIVE_FINISH                    = ConvertUnitEvent(83)

    constant unitevent EVENT_UNIT_SUMMON                                = ConvertUnitEvent(84)

    constant unitevent EVENT_UNIT_DROP_ITEM                             = ConvertUnitEvent(85)
    constant unitevent EVENT_UNIT_PICKUP_ITEM                           = ConvertUnitEvent(86)
    constant unitevent EVENT_UNIT_USE_ITEM                              = ConvertUnitEvent(87)

    constant unitevent EVENT_UNIT_LOADED                                = ConvertUnitEvent(88)

    constant widgetevent EVENT_WIDGET_DEATH                             = ConvertWidgetEvent(89)

    constant dialogevent EVENT_DIALOG_BUTTON_CLICK                      = ConvertDialogEvent(90)
    constant dialogevent EVENT_DIALOG_CLICK                             = ConvertDialogEvent(91)

    //===================================================
    // Frozen Throne Expansion Events
    // Need to be added here to preserve compat
    //===================================================

    //===================================================
    // For use with TriggerRegisterGameEvent
    //===================================================

    constant gameevent          EVENT_GAME_LOADED                       = ConvertGameEvent(256)
    constant gameevent          EVENT_GAME_TOURNAMENT_FINISH_SOON       = ConvertGameEvent(257)
    constant gameevent          EVENT_GAME_TOURNAMENT_FINISH_NOW        = ConvertGameEvent(258)
    constant gameevent          EVENT_GAME_SAVE                         = ConvertGameEvent(259)
    constant gameevent          EVENT_GAME_CUSTOM_UI_FRAME              = ConvertGameEvent(310)

    //===================================================
    // For use with TriggerRegisterPlayerEvent
    //===================================================

    constant playerevent        EVENT_PLAYER_ARROW_LEFT_DOWN            = ConvertPlayerEvent(261)
    constant playerevent        EVENT_PLAYER_ARROW_LEFT_UP              = ConvertPlayerEvent(262)
    constant playerevent        EVENT_PLAYER_ARROW_RIGHT_DOWN           = ConvertPlayerEvent(263)
    constant playerevent        EVENT_PLAYER_ARROW_RIGHT_UP             = ConvertPlayerEvent(264)
    constant playerevent        EVENT_PLAYER_ARROW_DOWN_DOWN            = ConvertPlayerEvent(265)
    constant playerevent        EVENT_PLAYER_ARROW_DOWN_UP              = ConvertPlayerEvent(266)
    constant playerevent        EVENT_PLAYER_ARROW_UP_DOWN              = ConvertPlayerEvent(267)
    constant playerevent        EVENT_PLAYER_ARROW_UP_UP                = ConvertPlayerEvent(268)
    constant playerevent        EVENT_PLAYER_MOUSE_DOWN                 = ConvertPlayerEvent(305)
    constant playerevent        EVENT_PLAYER_MOUSE_UP                   = ConvertPlayerEvent(306)
    constant playerevent        EVENT_PLAYER_MOUSE_MOVE                 = ConvertPlayerEvent(307)
    constant playerevent        EVENT_PLAYER_SYNC_DATA                  = ConvertPlayerEvent(309)
    constant playerevent        EVENT_PLAYER_KEY                        = ConvertPlayerEvent(311)
    constant playerevent        EVENT_PLAYER_KEY_DOWN                   = ConvertPlayerEvent(312)
    constant playerevent        EVENT_PLAYER_KEY_UP                     = ConvertPlayerEvent(313)

    //===================================================
    // For use with TriggerRegisterPlayerUnitEvent
    //===================================================

    constant playerunitevent    EVENT_PLAYER_UNIT_SELL                  = ConvertPlayerUnitEvent(269)
    constant playerunitevent    EVENT_PLAYER_UNIT_CHANGE_OWNER          = ConvertPlayerUnitEvent(270)
    constant playerunitevent    EVENT_PLAYER_UNIT_SELL_ITEM             = ConvertPlayerUnitEvent(271)
    constant playerunitevent    EVENT_PLAYER_UNIT_SPELL_CHANNEL         = ConvertPlayerUnitEvent(272)
    constant playerunitevent    EVENT_PLAYER_UNIT_SPELL_CAST            = ConvertPlayerUnitEvent(273)
    constant playerunitevent    EVENT_PLAYER_UNIT_SPELL_EFFECT          = ConvertPlayerUnitEvent(274)
    constant playerunitevent    EVENT_PLAYER_UNIT_SPELL_FINISH          = ConvertPlayerUnitEvent(275)
    constant playerunitevent    EVENT_PLAYER_UNIT_SPELL_ENDCAST         = ConvertPlayerUnitEvent(276)
    constant playerunitevent    EVENT_PLAYER_UNIT_PAWN_ITEM             = ConvertPlayerUnitEvent(277)
    constant playerunitevent    EVENT_PLAYER_UNIT_STACK_ITEM            = ConvertPlayerUnitEvent(319)

    //===================================================
    // For use with TriggerRegisterUnitEvent
    //===================================================

    constant unitevent          EVENT_UNIT_SELL                         = ConvertUnitEvent(286)
    constant unitevent          EVENT_UNIT_CHANGE_OWNER                 = ConvertUnitEvent(287)
    constant unitevent          EVENT_UNIT_SELL_ITEM                    = ConvertUnitEvent(288)
    constant unitevent          EVENT_UNIT_SPELL_CHANNEL                = ConvertUnitEvent(289)
    constant unitevent          EVENT_UNIT_SPELL_CAST                   = ConvertUnitEvent(290)
    constant unitevent          EVENT_UNIT_SPELL_EFFECT                 = ConvertUnitEvent(291)
    constant unitevent          EVENT_UNIT_SPELL_FINISH                 = ConvertUnitEvent(292)
    constant unitevent          EVENT_UNIT_SPELL_ENDCAST                = ConvertUnitEvent(293)
    constant unitevent          EVENT_UNIT_PAWN_ITEM                    = ConvertUnitEvent(294)
    constant unitevent          EVENT_UNIT_STACK_ITEM                   = ConvertUnitEvent(318)

    //===================================================
    // Limit Event API constants
    // variable, player state, game state, and unit state events
    // ( do NOT change the order of these... )
    //===================================================
    constant limitop LESS_THAN                              = ConvertLimitOp(0)
    constant limitop LESS_THAN_OR_EQUAL                     = ConvertLimitOp(1)
    constant limitop EQUAL                                  = ConvertLimitOp(2)
    constant limitop GREATER_THAN_OR_EQUAL                  = ConvertLimitOp(3)
    constant limitop GREATER_THAN                           = ConvertLimitOp(4)
    constant limitop NOT_EQUAL                              = ConvertLimitOp(5)

//===================================================
// Unit Type Constants for use with IsUnitType()
//===================================================

    constant unittype UNIT_TYPE_HERO                        = ConvertUnitType(0)
    constant unittype UNIT_TYPE_DEAD                        = ConvertUnitType(1)
    constant unittype UNIT_TYPE_STRUCTURE                   = ConvertUnitType(2)

    constant unittype UNIT_TYPE_FLYING                      = ConvertUnitType(3)
    constant unittype UNIT_TYPE_GROUND                      = ConvertUnitType(4)

    constant unittype UNIT_TYPE_ATTACKS_FLYING              = ConvertUnitType(5)
    constant unittype UNIT_TYPE_ATTACKS_GROUND              = ConvertUnitType(6)

    constant unittype UNIT_TYPE_MELEE_ATTACKER              = ConvertUnitType(7)
    constant unittype UNIT_TYPE_RANGED_ATTACKER             = ConvertUnitType(8)

    constant unittype UNIT_TYPE_GIANT                       = ConvertUnitType(9)
    constant unittype UNIT_TYPE_SUMMONED                    = ConvertUnitType(10)
    constant unittype UNIT_TYPE_STUNNED                     = ConvertUnitType(11)
    constant unittype UNIT_TYPE_PLAGUED                     = ConvertUnitType(12)
    constant unittype UNIT_TYPE_SNARED                      = ConvertUnitType(13)

    constant unittype UNIT_TYPE_UNDEAD                      = ConvertUnitType(14)
    constant unittype UNIT_TYPE_MECHANICAL                  = ConvertUnitType(15)
    constant unittype UNIT_TYPE_PEON                        = ConvertUnitType(16)
    constant unittype UNIT_TYPE_SAPPER                      = ConvertUnitType(17)
    constant unittype UNIT_TYPE_TOWNHALL                    = ConvertUnitType(18)
    constant unittype UNIT_TYPE_ANCIENT                     = ConvertUnitType(19)

    constant unittype UNIT_TYPE_TAUREN                      = ConvertUnitType(20)
    constant unittype UNIT_TYPE_POISONED                    = ConvertUnitType(21)
    constant unittype UNIT_TYPE_POLYMORPHED                 = ConvertUnitType(22)
    constant unittype UNIT_TYPE_SLEEPING                    = ConvertUnitType(23)
    constant unittype UNIT_TYPE_RESISTANT                   = ConvertUnitType(24)
    constant unittype UNIT_TYPE_ETHEREAL                    = ConvertUnitType(25)
    constant unittype UNIT_TYPE_MAGIC_IMMUNE                = ConvertUnitType(26)

//===================================================
// Unit Type Constants for use with ChooseRandomItemEx()
//===================================================

    constant itemtype ITEM_TYPE_PERMANENT                   = ConvertItemType(0)
    constant itemtype ITEM_TYPE_CHARGED                     = ConvertItemType(1)
    constant itemtype ITEM_TYPE_POWERUP                     = ConvertItemType(2)
    constant itemtype ITEM_TYPE_ARTIFACT                    = ConvertItemType(3)
    constant itemtype ITEM_TYPE_PURCHASABLE                 = ConvertItemType(4)
    constant itemtype ITEM_TYPE_CAMPAIGN                    = ConvertItemType(5)
    constant itemtype ITEM_TYPE_MISCELLANEOUS               = ConvertItemType(6)
    constant itemtype ITEM_TYPE_UNKNOWN                     = ConvertItemType(7)
    constant itemtype ITEM_TYPE_ANY                         = ConvertItemType(8)

    // Deprecated, should use ITEM_TYPE_POWERUP
    constant itemtype ITEM_TYPE_TOME                        = ConvertItemType(2)

//===================================================
// Animatable Camera Fields
//===================================================

    constant camerafield CAMERA_FIELD_TARGET_DISTANCE       = ConvertCameraField(0)
    constant camerafield CAMERA_FIELD_FARZ                  = ConvertCameraField(1)
    constant camerafield CAMERA_FIELD_ANGLE_OF_ATTACK       = ConvertCameraField(2)
    constant camerafield CAMERA_FIELD_FIELD_OF_VIEW         = ConvertCameraField(3)
    constant camerafield CAMERA_FIELD_ROLL                  = ConvertCameraField(4)
    constant camerafield CAMERA_FIELD_ROTATION              = ConvertCameraField(5)
    constant camerafield CAMERA_FIELD_ZOFFSET               = ConvertCameraField(6)
    constant camerafield CAMERA_FIELD_NEARZ                 = ConvertCameraField(7)
    constant camerafield CAMERA_FIELD_LOCAL_PITCH           = ConvertCameraField(8)
    constant camerafield CAMERA_FIELD_LOCAL_YAW             = ConvertCameraField(9)
    constant camerafield CAMERA_FIELD_LOCAL_ROLL            = ConvertCameraField(10)

    constant blendmode   BLEND_MODE_NONE                    = ConvertBlendMode(0)
    constant blendmode   BLEND_MODE_DONT_CARE               = ConvertBlendMode(0)
    constant blendmode   BLEND_MODE_KEYALPHA                = ConvertBlendMode(1)
    constant blendmode   BLEND_MODE_BLEND                   = ConvertBlendMode(2)
    constant blendmode   BLEND_MODE_ADDITIVE                = ConvertBlendMode(3)
    constant blendmode   BLEND_MODE_MODULATE                = ConvertBlendMode(4)
    constant blendmode   BLEND_MODE_MODULATE_2X             = ConvertBlendMode(5)

    constant raritycontrol  RARITY_FREQUENT                 = ConvertRarityControl(0)
    constant raritycontrol  RARITY_RARE                     = ConvertRarityControl(1)

    constant texmapflags    TEXMAP_FLAG_NONE                = ConvertTexMapFlags(0)
    constant texmapflags    TEXMAP_FLAG_WRAP_U              = ConvertTexMapFlags(1)
    constant texmapflags    TEXMAP_FLAG_WRAP_V              = ConvertTexMapFlags(2)
    constant texmapflags    TEXMAP_FLAG_WRAP_UV             = ConvertTexMapFlags(3)

    constant fogstate       FOG_OF_WAR_MASKED               = ConvertFogState(1)
    constant fogstate       FOG_OF_WAR_FOGGED               = ConvertFogState(2)
    constant fogstate       FOG_OF_WAR_VISIBLE              = ConvertFogState(4)

//===================================================
// Camera Margin constants for use with GetCameraMargin
//===================================================

    constant integer        CAMERA_MARGIN_LEFT              = 0
    constant integer        CAMERA_MARGIN_RIGHT             = 1
    constant integer        CAMERA_MARGIN_TOP               = 2
    constant integer        CAMERA_MARGIN_BOTTOM            = 3

//===================================================
// Effect API constants
//===================================================

    constant effecttype     EFFECT_TYPE_EFFECT              = ConvertEffectType(0)
    constant effecttype     EFFECT_TYPE_TARGET              = ConvertEffectType(1)
    constant effecttype     EFFECT_TYPE_CASTER              = ConvertEffectType(2)
    constant effecttype     EFFECT_TYPE_SPECIAL             = ConvertEffectType(3)
    constant effecttype     EFFECT_TYPE_AREA_EFFECT         = ConvertEffectType(4)
    constant effecttype     EFFECT_TYPE_MISSILE             = ConvertEffectType(5)
    constant effecttype     EFFECT_TYPE_LIGHTNING           = ConvertEffectType(6)

    constant soundtype      SOUND_TYPE_EFFECT               = ConvertSoundType(0)
    constant soundtype      SOUND_TYPE_EFFECT_LOOPED        = ConvertSoundType(1)

//===================================================
// Custom UI API constants
//===================================================

    constant originframetype        ORIGIN_FRAME_GAME_UI                    = ConvertOriginFrameType(0)
    constant originframetype        ORIGIN_FRAME_COMMAND_BUTTON             = ConvertOriginFrameType(1)
    constant originframetype        ORIGIN_FRAME_HERO_BAR                   = ConvertOriginFrameType(2)
    constant originframetype        ORIGIN_FRAME_HERO_BUTTON                = ConvertOriginFrameType(3)
    constant originframetype        ORIGIN_FRAME_HERO_HP_BAR                = ConvertOriginFrameType(4)
    constant originframetype        ORIGIN_FRAME_HERO_MANA_BAR              = ConvertOriginFrameType(5)
    constant originframetype        ORIGIN_FRAME_HERO_BUTTON_INDICATOR      = ConvertOriginFrameType(6)
    constant originframetype        ORIGIN_FRAME_ITEM_BUTTON                = ConvertOriginFrameType(7)
    constant originframetype        ORIGIN_FRAME_MINIMAP                    = ConvertOriginFrameType(8)
    constant originframetype        ORIGIN_FRAME_MINIMAP_BUTTON             = ConvertOriginFrameType(9)
    constant originframetype        ORIGIN_FRAME_SYSTEM_BUTTON              = ConvertOriginFrameType(10)
    constant originframetype        ORIGIN_FRAME_TOOLTIP                    = ConvertOriginFrameType(11)
    constant originframetype        ORIGIN_FRAME_UBERTOOLTIP                = ConvertOriginFrameType(12)
    constant originframetype        ORIGIN_FRAME_CHAT_MSG                   = ConvertOriginFrameType(13)
    constant originframetype        ORIGIN_FRAME_UNIT_MSG                   = ConvertOriginFrameType(14)
    constant originframetype        ORIGIN_FRAME_TOP_MSG                    = ConvertOriginFrameType(15)
    constant originframetype        ORIGIN_FRAME_PORTRAIT                   = ConvertOriginFrameType(16)
    constant originframetype        ORIGIN_FRAME_WORLD_FRAME                = ConvertOriginFrameType(17)
    constant originframetype        ORIGIN_FRAME_SIMPLE_UI_PARENT           = ConvertOriginFrameType(18)
    constant originframetype        ORIGIN_FRAME_PORTRAIT_HP_TEXT           = ConvertOriginFrameType(19)
    constant originframetype        ORIGIN_FRAME_PORTRAIT_MANA_TEXT         = ConvertOriginFrameType(20)
    constant originframetype        ORIGIN_FRAME_UNIT_PANEL_BUFF_BAR        = ConvertOriginFrameType(21)
    constant originframetype        ORIGIN_FRAME_UNIT_PANEL_BUFF_BAR_LABEL  = ConvertOriginFrameType(22)

    constant framepointtype         FRAMEPOINT_TOPLEFT                   = ConvertFramePointType(0)
    constant framepointtype         FRAMEPOINT_TOP                       = ConvertFramePointType(1)
    constant framepointtype         FRAMEPOINT_TOPRIGHT                  = ConvertFramePointType(2)
    constant framepointtype         FRAMEPOINT_LEFT                      = ConvertFramePointType(3)
    constant framepointtype         FRAMEPOINT_CENTER                    = ConvertFramePointType(4)
    constant framepointtype         FRAMEPOINT_RIGHT                     = ConvertFramePointType(5)
    constant framepointtype         FRAMEPOINT_BOTTOMLEFT                = ConvertFramePointType(6)
    constant framepointtype         FRAMEPOINT_BOTTOM                    = ConvertFramePointType(7)
    constant framepointtype         FRAMEPOINT_BOTTOMRIGHT               = ConvertFramePointType(8)

    constant textaligntype          TEXT_JUSTIFY_TOP                     = ConvertTextAlignType(0)
    constant textaligntype          TEXT_JUSTIFY_MIDDLE                  = ConvertTextAlignType(1)
    constant textaligntype          TEXT_JUSTIFY_BOTTOM                  = ConvertTextAlignType(2)
    constant textaligntype          TEXT_JUSTIFY_LEFT                    = ConvertTextAlignType(3)
    constant textaligntype          TEXT_JUSTIFY_CENTER                  = ConvertTextAlignType(4)
    constant textaligntype          TEXT_JUSTIFY_RIGHT                   = ConvertTextAlignType(5)

    constant frameeventtype         FRAMEEVENT_CONTROL_CLICK             = ConvertFrameEventType(1)
    constant frameeventtype         FRAMEEVENT_MOUSE_ENTER               = ConvertFrameEventType(2)
    constant frameeventtype         FRAMEEVENT_MOUSE_LEAVE               = ConvertFrameEventType(3)
    constant frameeventtype         FRAMEEVENT_MOUSE_UP                  = ConvertFrameEventType(4)
    constant frameeventtype         FRAMEEVENT_MOUSE_DOWN                = ConvertFrameEventType(5)
    constant frameeventtype         FRAMEEVENT_MOUSE_WHEEL               = ConvertFrameEventType(6)
    constant frameeventtype         FRAMEEVENT_CHECKBOX_CHECKED          = ConvertFrameEventType(7)
    constant frameeventtype         FRAMEEVENT_CHECKBOX_UNCHECKED        = ConvertFrameEventType(8)
    constant frameeventtype         FRAMEEVENT_EDITBOX_TEXT_CHANGED      = ConvertFrameEventType(9)
    constant frameeventtype         FRAMEEVENT_POPUPMENU_ITEM_CHANGED    = ConvertFrameEventType(10)
    constant frameeventtype         FRAMEEVENT_MOUSE_DOUBLECLICK         = ConvertFrameEventType(11)
    constant frameeventtype         FRAMEEVENT_SPRITE_ANIM_UPDATE        = ConvertFrameEventType(12)
    constant frameeventtype         FRAMEEVENT_SLIDER_VALUE_CHANGED      = ConvertFrameEventType(13)
    constant frameeventtype         FRAMEEVENT_DIALOG_CANCEL             = ConvertFrameEventType(14)
    constant frameeventtype         FRAMEEVENT_DIALOG_ACCEPT             = ConvertFrameEventType(15)
    constant frameeventtype         FRAMEEVENT_EDITBOX_ENTER             = ConvertFrameEventType(16)

//===================================================
// OS Key constants
//===================================================

    constant oskeytype              OSKEY_BACKSPACE                      = ConvertOsKeyType($08)
    constant oskeytype              OSKEY_TAB                            = ConvertOsKeyType($09)
    constant oskeytype              OSKEY_CLEAR                          = ConvertOsKeyType($0C)
    constant oskeytype              OSKEY_RETURN                         = ConvertOsKeyType($0D)
    constant oskeytype              OSKEY_SHIFT                          = ConvertOsKeyType($10)
    constant oskeytype              OSKEY_CONTROL                        = ConvertOsKeyType($11)
    constant oskeytype              OSKEY_ALT                            = ConvertOsKeyType($12)
    constant oskeytype              OSKEY_PAUSE                          = ConvertOsKeyType($13)
    constant oskeytype              OSKEY_CAPSLOCK                       = ConvertOsKeyType($14)
    constant oskeytype              OSKEY_KANA                           = ConvertOsKeyType($15)
    constant oskeytype              OSKEY_HANGUL                         = ConvertOsKeyType($15)
    constant oskeytype              OSKEY_JUNJA                          = ConvertOsKeyType($17)
    constant oskeytype              OSKEY_FINAL                          = ConvertOsKeyType($18)
    constant oskeytype              OSKEY_HANJA                          = ConvertOsKeyType($19)
    constant oskeytype              OSKEY_KANJI                          = ConvertOsKeyType($19)
    constant oskeytype              OSKEY_ESCAPE                         = ConvertOsKeyType($1B)
    constant oskeytype              OSKEY_CONVERT                        = ConvertOsKeyType($1C)
    constant oskeytype              OSKEY_NONCONVERT                     = ConvertOsKeyType($1D)
    constant oskeytype              OSKEY_ACCEPT                         = ConvertOsKeyType($1E)
    constant oskeytype              OSKEY_MODECHANGE                     = ConvertOsKeyType($1F)
    constant oskeytype              OSKEY_SPACE                          = ConvertOsKeyType($20)
    constant oskeytype              OSKEY_PAGEUP                         = ConvertOsKeyType($21)
    constant oskeytype              OSKEY_PAGEDOWN                       = ConvertOsKeyType($22)
    constant oskeytype              OSKEY_END                            = ConvertOsKeyType($23)
    constant oskeytype              OSKEY_HOME                           = ConvertOsKeyType($24)
    constant oskeytype              OSKEY_LEFT                           = ConvertOsKeyType($25)
    constant oskeytype              OSKEY_UP                             = ConvertOsKeyType($26)
    constant oskeytype              OSKEY_RIGHT                          = ConvertOsKeyType($27)
    constant oskeytype              OSKEY_DOWN                           = ConvertOsKeyType($28)
    constant oskeytype              OSKEY_SELECT                         = ConvertOsKeyType($29)
    constant oskeytype              OSKEY_PRINT                          = ConvertOsKeyType($2A)
    constant oskeytype              OSKEY_EXECUTE                        = ConvertOsKeyType($2B)
    constant oskeytype              OSKEY_PRINTSCREEN                    = ConvertOsKeyType($2C)
    constant oskeytype              OSKEY_INSERT                         = ConvertOsKeyType($2D)
    constant oskeytype              OSKEY_DELETE                         = ConvertOsKeyType($2E)
    constant oskeytype              OSKEY_HELP                           = ConvertOsKeyType($2F)
    constant oskeytype              OSKEY_0                              = ConvertOsKeyType($30)
    constant oskeytype              OSKEY_1                              = ConvertOsKeyType($31)
    constant oskeytype              OSKEY_2                              = ConvertOsKeyType($32)
    constant oskeytype              OSKEY_3                              = ConvertOsKeyType($33)
    constant oskeytype              OSKEY_4                              = ConvertOsKeyType($34)
    constant oskeytype              OSKEY_5                              = ConvertOsKeyType($35)
    constant oskeytype              OSKEY_6                              = ConvertOsKeyType($36)
    constant oskeytype              OSKEY_7                              = ConvertOsKeyType($37)
    constant oskeytype              OSKEY_8                              = ConvertOsKeyType($38)
    constant oskeytype              OSKEY_9                              = ConvertOsKeyType($39)
    constant oskeytype              OSKEY_A                              = ConvertOsKeyType($41)
    constant oskeytype              OSKEY_B                              = ConvertOsKeyType($42)
    constant oskeytype              OSKEY_C                              = ConvertOsKeyType($43)
    constant oskeytype              OSKEY_D                              = ConvertOsKeyType($44)
    constant oskeytype              OSKEY_E                              = ConvertOsKeyType($45)
    constant oskeytype              OSKEY_F                              = ConvertOsKeyType($46)
    constant oskeytype              OSKEY_G                              = ConvertOsKeyType($47)
    constant oskeytype              OSKEY_H                              = ConvertOsKeyType($48)
    constant oskeytype              OSKEY_I                              = ConvertOsKeyType($49)
    constant oskeytype              OSKEY_J                              = ConvertOsKeyType($4A)
    constant oskeytype              OSKEY_K                              = ConvertOsKeyType($4B)
    constant oskeytype              OSKEY_L                              = ConvertOsKeyType($4C)
    constant oskeytype              OSKEY_M                              = ConvertOsKeyType($4D)
    constant oskeytype              OSKEY_N                              = ConvertOsKeyType($4E)
    constant oskeytype              OSKEY_O                              = ConvertOsKeyType($4F)
    constant oskeytype              OSKEY_P                              = ConvertOsKeyType($50)
    constant oskeytype              OSKEY_Q                              = ConvertOsKeyType($51)
    constant oskeytype              OSKEY_R                              = ConvertOsKeyType($52)
    constant oskeytype              OSKEY_S                              = ConvertOsKeyType($53)
    constant oskeytype              OSKEY_T                              = ConvertOsKeyType($54)
    constant oskeytype              OSKEY_U                              = ConvertOsKeyType($55)
    constant oskeytype              OSKEY_V                              = ConvertOsKeyType($56)
    constant oskeytype              OSKEY_W                              = ConvertOsKeyType($57)
    constant oskeytype              OSKEY_X                              = ConvertOsKeyType($58)
    constant oskeytype              OSKEY_Y                              = ConvertOsKeyType($59)
    constant oskeytype              OSKEY_Z                              = ConvertOsKeyType($5A)
    constant oskeytype              OSKEY_LMETA                          = ConvertOsKeyType($5B)
    constant oskeytype              OSKEY_RMETA                          = ConvertOsKeyType($5C)
    constant oskeytype              OSKEY_APPS                           = ConvertOsKeyType($5D)
    constant oskeytype              OSKEY_SLEEP                          = ConvertOsKeyType($5F)
    constant oskeytype              OSKEY_NUMPAD0                        = ConvertOsKeyType($60)
    constant oskeytype              OSKEY_NUMPAD1                        = ConvertOsKeyType($61)
    constant oskeytype              OSKEY_NUMPAD2                        = ConvertOsKeyType($62)
    constant oskeytype              OSKEY_NUMPAD3                        = ConvertOsKeyType($63)
    constant oskeytype              OSKEY_NUMPAD4                        = ConvertOsKeyType($64)
    constant oskeytype              OSKEY_NUMPAD5                        = ConvertOsKeyType($65)
    constant oskeytype              OSKEY_NUMPAD6                        = ConvertOsKeyType($66)
    constant oskeytype              OSKEY_NUMPAD7                        = ConvertOsKeyType($67)
    constant oskeytype              OSKEY_NUMPAD8                        = ConvertOsKeyType($68)
    constant oskeytype              OSKEY_NUMPAD9                        = ConvertOsKeyType($69)
    constant oskeytype              OSKEY_MULTIPLY                       = ConvertOsKeyType($6A)
    constant oskeytype              OSKEY_ADD                            = ConvertOsKeyType($6B)
    constant oskeytype              OSKEY_SEPARATOR                      = ConvertOsKeyType($6C)
    constant oskeytype              OSKEY_SUBTRACT                       = ConvertOsKeyType($6D)
    constant oskeytype              OSKEY_DECIMAL                        = ConvertOsKeyType($6E)
    constant oskeytype              OSKEY_DIVIDE                         = ConvertOsKeyType($6F)
    constant oskeytype              OSKEY_F1                             = ConvertOsKeyType($70)
    constant oskeytype              OSKEY_F2                             = ConvertOsKeyType($71)
    constant oskeytype              OSKEY_F3                             = ConvertOsKeyType($72)
    constant oskeytype              OSKEY_F4                             = ConvertOsKeyType($73)
    constant oskeytype              OSKEY_F5                             = ConvertOsKeyType($74)
    constant oskeytype              OSKEY_F6                             = ConvertOsKeyType($75)
    constant oskeytype              OSKEY_F7                             = ConvertOsKeyType($76)
    constant oskeytype              OSKEY_F8                             = ConvertOsKeyType($77)
    constant oskeytype              OSKEY_F9                             = ConvertOsKeyType($78)
    constant oskeytype              OSKEY_F10                            = ConvertOsKeyType($79)
    constant oskeytype              OSKEY_F11                            = ConvertOsKeyType($7A)
    constant oskeytype              OSKEY_F12                            = ConvertOsKeyType($7B)
    constant oskeytype              OSKEY_F13                            = ConvertOsKeyType($7C)
    constant oskeytype              OSKEY_F14                            = ConvertOsKeyType($7D)
    constant oskeytype              OSKEY_F15                            = ConvertOsKeyType($7E)
    constant oskeytype              OSKEY_F16                            = ConvertOsKeyType($7F)
    constant oskeytype              OSKEY_F17                            = ConvertOsKeyType($80)
    constant oskeytype              OSKEY_F18                            = ConvertOsKeyType($81)
    constant oskeytype              OSKEY_F19                            = ConvertOsKeyType($82)
    constant oskeytype              OSKEY_F20                            = ConvertOsKeyType($83)
    constant oskeytype              OSKEY_F21                            = ConvertOsKeyType($84)
    constant oskeytype              OSKEY_F22                            = ConvertOsKeyType($85)
    constant oskeytype              OSKEY_F23                            = ConvertOsKeyType($86)
    constant oskeytype              OSKEY_F24                            = ConvertOsKeyType($87)
    constant oskeytype              OSKEY_NUMLOCK                        = ConvertOsKeyType($90)
    constant oskeytype              OSKEY_SCROLLLOCK                     = ConvertOsKeyType($91)
    constant oskeytype              OSKEY_OEM_NEC_EQUAL                  = ConvertOsKeyType($92)
    constant oskeytype              OSKEY_OEM_FJ_JISHO                   = ConvertOsKeyType($92)
    constant oskeytype              OSKEY_OEM_FJ_MASSHOU                 = ConvertOsKeyType($93)
    constant oskeytype              OSKEY_OEM_FJ_TOUROKU                 = ConvertOsKeyType($94)
    constant oskeytype              OSKEY_OEM_FJ_LOYA                    = ConvertOsKeyType($95)
    constant oskeytype              OSKEY_OEM_FJ_ROYA                    = ConvertOsKeyType($96)
    constant oskeytype              OSKEY_LSHIFT                         = ConvertOsKeyType($A0)
    constant oskeytype              OSKEY_RSHIFT                         = ConvertOsKeyType($A1)
    constant oskeytype              OSKEY_LCONTROL                       = ConvertOsKeyType($A2)
    constant oskeytype              OSKEY_RCONTROL                       = ConvertOsKeyType($A3)
    constant oskeytype              OSKEY_LALT                           = ConvertOsKeyType($A4)
    constant oskeytype              OSKEY_RALT                           = ConvertOsKeyType($A5)
    constant oskeytype              OSKEY_BROWSER_BACK                   = ConvertOsKeyType($A6)
    constant oskeytype              OSKEY_BROWSER_FORWARD                = ConvertOsKeyType($A7)
    constant oskeytype              OSKEY_BROWSER_REFRESH                = ConvertOsKeyType($A8)
    constant oskeytype              OSKEY_BROWSER_STOP                   = ConvertOsKeyType($A9)
    constant oskeytype              OSKEY_BROWSER_SEARCH                 = ConvertOsKeyType($AA)
    constant oskeytype              OSKEY_BROWSER_FAVORITES              = ConvertOsKeyType($AB)
    constant oskeytype              OSKEY_BROWSER_HOME                   = ConvertOsKeyType($AC)
    constant oskeytype              OSKEY_VOLUME_MUTE                    = ConvertOsKeyType($AD)
    constant oskeytype              OSKEY_VOLUME_DOWN                    = ConvertOsKeyType($AE)
    constant oskeytype              OSKEY_VOLUME_UP                      = ConvertOsKeyType($AF)
    constant oskeytype              OSKEY_MEDIA_NEXT_TRACK               = ConvertOsKeyType($B0)
    constant oskeytype              OSKEY_MEDIA_PREV_TRACK               = ConvertOsKeyType($B1)
    constant oskeytype              OSKEY_MEDIA_STOP                     = ConvertOsKeyType($B2)
    constant oskeytype              OSKEY_MEDIA_PLAY_PAUSE               = ConvertOsKeyType($B3)
    constant oskeytype              OSKEY_LAUNCH_MAIL                    = ConvertOsKeyType($B4)
    constant oskeytype              OSKEY_LAUNCH_MEDIA_SELECT            = ConvertOsKeyType($B5)
    constant oskeytype              OSKEY_LAUNCH_APP1                    = ConvertOsKeyType($B6)
    constant oskeytype              OSKEY_LAUNCH_APP2                    = ConvertOsKeyType($B7)
    constant oskeytype              OSKEY_OEM_1                          = ConvertOsKeyType($BA)
    constant oskeytype              OSKEY_OEM_PLUS                       = ConvertOsKeyType($BB)
    constant oskeytype              OSKEY_OEM_COMMA                      = ConvertOsKeyType($BC)
    constant oskeytype              OSKEY_OEM_MINUS                      = ConvertOsKeyType($BD)
    constant oskeytype              OSKEY_OEM_PERIOD                     = ConvertOsKeyType($BE)
    constant oskeytype              OSKEY_OEM_2                          = ConvertOsKeyType($BF)
    constant oskeytype              OSKEY_OEM_3                          = ConvertOsKeyType($C0)
    constant oskeytype              OSKEY_OEM_4                          = ConvertOsKeyType($DB)
    constant oskeytype              OSKEY_OEM_5                          = ConvertOsKeyType($DC)
    constant oskeytype              OSKEY_OEM_6                          = ConvertOsKeyType($DD)
    constant oskeytype              OSKEY_OEM_7                          = ConvertOsKeyType($DE)
    constant oskeytype              OSKEY_OEM_8                          = ConvertOsKeyType($DF)
    constant oskeytype              OSKEY_OEM_AX                         = ConvertOsKeyType($E1)
    constant oskeytype              OSKEY_OEM_102                        = ConvertOsKeyType($E2)
    constant oskeytype              OSKEY_ICO_HELP                       = ConvertOsKeyType($E3)
    constant oskeytype              OSKEY_ICO_00                         = ConvertOsKeyType($E4)
    constant oskeytype              OSKEY_PROCESSKEY                     = ConvertOsKeyType($E5)
    constant oskeytype              OSKEY_ICO_CLEAR                      = ConvertOsKeyType($E6)
    constant oskeytype              OSKEY_PACKET                         = ConvertOsKeyType($E7)
    constant oskeytype              OSKEY_OEM_RESET                      = ConvertOsKeyType($E9)
    constant oskeytype              OSKEY_OEM_JUMP                       = ConvertOsKeyType($EA)
    constant oskeytype              OSKEY_OEM_PA1                        = ConvertOsKeyType($EB)
    constant oskeytype              OSKEY_OEM_PA2                        = ConvertOsKeyType($EC)
    constant oskeytype              OSKEY_OEM_PA3                        = ConvertOsKeyType($ED)
    constant oskeytype              OSKEY_OEM_WSCTRL                     = ConvertOsKeyType($EE)
    constant oskeytype              OSKEY_OEM_CUSEL                      = ConvertOsKeyType($EF)
    constant oskeytype              OSKEY_OEM_ATTN                       = ConvertOsKeyType($F0)
    constant oskeytype              OSKEY_OEM_FINISH                     = ConvertOsKeyType($F1)
    constant oskeytype              OSKEY_OEM_COPY                       = ConvertOsKeyType($F2)
    constant oskeytype              OSKEY_OEM_AUTO                       = ConvertOsKeyType($F3)
    constant oskeytype              OSKEY_OEM_ENLW                       = ConvertOsKeyType($F4)
    constant oskeytype              OSKEY_OEM_BACKTAB                    = ConvertOsKeyType($F5)
    constant oskeytype              OSKEY_ATTN                           = ConvertOsKeyType($F6)
    constant oskeytype              OSKEY_CRSEL                          = ConvertOsKeyType($F7)
    constant oskeytype              OSKEY_EXSEL                          = ConvertOsKeyType($F8)
    constant oskeytype              OSKEY_EREOF                          = ConvertOsKeyType($F9)
    constant oskeytype              OSKEY_PLAY                           = ConvertOsKeyType($FA)
    constant oskeytype              OSKEY_ZOOM                           = ConvertOsKeyType($FB)
    constant oskeytype              OSKEY_NONAME                         = ConvertOsKeyType($FC)
    constant oskeytype              OSKEY_PA1                            = ConvertOsKeyType($FD)
    constant oskeytype              OSKEY_OEM_CLEAR                      = ConvertOsKeyType($FE)

//===================================================
// Instanced Object Operation API constants
//===================================================

    // Ability
    constant abilityintegerfield ABILITY_IF_BUTTON_POSITION_NORMAL_X        = ConvertAbilityIntegerField('abpx')
    constant abilityintegerfield ABILITY_IF_BUTTON_POSITION_NORMAL_Y        = ConvertAbilityIntegerField('abpy')
    constant abilityintegerfield ABILITY_IF_BUTTON_POSITION_ACTIVATED_X     = ConvertAbilityIntegerField('aubx')
    constant abilityintegerfield ABILITY_IF_BUTTON_POSITION_ACTIVATED_Y     = ConvertAbilityIntegerField('auby')
    constant abilityintegerfield ABILITY_IF_BUTTON_POSITION_RESEARCH_X      = ConvertAbilityIntegerField('arpx')
    constant abilityintegerfield ABILITY_IF_BUTTON_POSITION_RESEARCH_Y      = ConvertAbilityIntegerField('arpy')
    constant abilityintegerfield ABILITY_IF_MISSILE_SPEED                   = ConvertAbilityIntegerField('amsp')
    constant abilityintegerfield ABILITY_IF_TARGET_ATTACHMENTS              = ConvertAbilityIntegerField('atac')
    constant abilityintegerfield ABILITY_IF_CASTER_ATTACHMENTS              = ConvertAbilityIntegerField('acac')
    constant abilityintegerfield ABILITY_IF_PRIORITY                        = ConvertAbilityIntegerField('apri')
    constant abilityintegerfield ABILITY_IF_LEVELS                          = ConvertAbilityIntegerField('alev')
    constant abilityintegerfield ABILITY_IF_REQUIRED_LEVEL                  = ConvertAbilityIntegerField('arlv')
    constant abilityintegerfield ABILITY_IF_LEVEL_SKIP_REQUIREMENT          = ConvertAbilityIntegerField('alsk')

    constant abilitybooleanfield ABILITY_BF_HERO_ABILITY                    = ConvertAbilityBooleanField('aher') // Get only
    constant abilitybooleanfield ABILITY_BF_ITEM_ABILITY                    = ConvertAbilityBooleanField('aite')
    constant abilitybooleanfield ABILITY_BF_CHECK_DEPENDENCIES              = ConvertAbilityBooleanField('achd')

    constant abilityrealfield ABILITY_RF_ARF_MISSILE_ARC                    = ConvertAbilityRealField('amac')

    constant abilitystringfield ABILITY_SF_NAME                             = ConvertAbilityStringField('anam') // Get Only
    constant abilitystringfield ABILITY_SF_ICON_ACTIVATED                   = ConvertAbilityStringField('auar')
    constant abilitystringfield ABILITY_SF_ICON_RESEARCH                    = ConvertAbilityStringField('arar')
    constant abilitystringfield ABILITY_SF_EFFECT_SOUND                     = ConvertAbilityStringField('aefs')
    constant abilitystringfield ABILITY_SF_EFFECT_SOUND_LOOPING             = ConvertAbilityStringField('aefl')

    constant abilityintegerlevelfield ABILITY_ILF_MANA_COST                         = ConvertAbilityIntegerLevelField('amcs')
    constant abilityintegerlevelfield ABILITY_ILF_NUMBER_OF_WAVES                   = ConvertAbilityIntegerLevelField('Hbz1')
    constant abilityintegerlevelfield ABILITY_ILF_NUMBER_OF_SHARDS                  = ConvertAbilityIntegerLevelField('Hbz3')
    constant abilityintegerlevelfield ABILITY_ILF_NUMBER_OF_UNITS_TELEPORTED        = ConvertAbilityIntegerLevelField('Hmt1')
    constant abilityintegerlevelfield ABILITY_ILF_SUMMONED_UNIT_COUNT_HWE2          = ConvertAbilityIntegerLevelField('Hwe2')
    constant abilityintegerlevelfield ABILITY_ILF_NUMBER_OF_IMAGES                  = ConvertAbilityIntegerLevelField('Omi1')
    constant abilityintegerlevelfield ABILITY_ILF_NUMBER_OF_CORPSES_RAISED_UAN1     = ConvertAbilityIntegerLevelField('Uan1')
    constant abilityintegerlevelfield ABILITY_ILF_MORPHING_FLAGS                    = ConvertAbilityIntegerLevelField('Eme2')
    constant abilityintegerlevelfield ABILITY_ILF_STRENGTH_BONUS_NRG5               = ConvertAbilityIntegerLevelField('Nrg5')
    constant abilityintegerlevelfield ABILITY_ILF_DEFENSE_BONUS_NRG6                = ConvertAbilityIntegerLevelField('Nrg6')
    constant abilityintegerlevelfield ABILITY_ILF_NUMBER_OF_TARGETS_HIT             = ConvertAbilityIntegerLevelField('Ocl2')
    constant abilityintegerlevelfield ABILITY_ILF_DETECTION_TYPE_OFS1               = ConvertAbilityIntegerLevelField('Ofs1')
    constant abilityintegerlevelfield ABILITY_ILF_NUMBER_OF_SUMMONED_UNITS_OSF2     = ConvertAbilityIntegerLevelField('Osf2')
    constant abilityintegerlevelfield ABILITY_ILF_NUMBER_OF_SUMMONED_UNITS_EFN1     = ConvertAbilityIntegerLevelField('Efn1')
    constant abilityintegerlevelfield ABILITY_ILF_NUMBER_OF_CORPSES_RAISED_HRE1     = ConvertAbilityIntegerLevelField('Hre1')
    constant abilityintegerlevelfield ABILITY_ILF_STACK_FLAGS                       = ConvertAbilityIntegerLevelField('Hca4')
    constant abilityintegerlevelfield ABILITY_ILF_MINIMUM_NUMBER_OF_UNITS           = ConvertAbilityIntegerLevelField('Ndp2')
    constant abilityintegerlevelfield ABILITY_ILF_MAXIMUM_NUMBER_OF_UNITS_NDP3      = ConvertAbilityIntegerLevelField('Ndp3')
    constant abilityintegerlevelfield ABILITY_ILF_NUMBER_OF_UNITS_CREATED_NRC2      = ConvertAbilityIntegerLevelField('Nrc2')
    constant abilityintegerlevelfield ABILITY_ILF_SHIELD_LIFE                       = ConvertAbilityIntegerLevelField('Ams3')
    constant abilityintegerlevelfield ABILITY_ILF_MANA_LOSS_AMS4                    = ConvertAbilityIntegerLevelField('Ams4')
    constant abilityintegerlevelfield ABILITY_ILF_GOLD_PER_INTERVAL_BGM1            = ConvertAbilityIntegerLevelField('Bgm1')
    constant abilityintegerlevelfield ABILITY_ILF_MAX_NUMBER_OF_MINERS              = ConvertAbilityIntegerLevelField('Bgm3')
    constant abilityintegerlevelfield ABILITY_ILF_CARGO_CAPACITY                    = ConvertAbilityIntegerLevelField('Car1')
    constant abilityintegerlevelfield ABILITY_ILF_MAXIMUM_CREEP_LEVEL_DEV3          = ConvertAbilityIntegerLevelField('Dev3')
    constant abilityintegerlevelfield ABILITY_ILF_MAX_CREEP_LEVEL_DEV1              = ConvertAbilityIntegerLevelField('Dev1')
    constant abilityintegerlevelfield ABILITY_ILF_GOLD_PER_INTERVAL_EGM1            = ConvertAbilityIntegerLevelField('Egm1')
    constant abilityintegerlevelfield ABILITY_ILF_DEFENSE_REDUCTION                 = ConvertAbilityIntegerLevelField('Fae1')
    constant abilityintegerlevelfield ABILITY_ILF_DETECTION_TYPE_FLA1               = ConvertAbilityIntegerLevelField('Fla1')
    constant abilityintegerlevelfield ABILITY_ILF_FLARE_COUNT                       = ConvertAbilityIntegerLevelField('Fla3')
    constant abilityintegerlevelfield ABILITY_ILF_MAX_GOLD                          = ConvertAbilityIntegerLevelField('Gld1')
    constant abilityintegerlevelfield ABILITY_ILF_MINING_CAPACITY                   = ConvertAbilityIntegerLevelField('Gld3')
    constant abilityintegerlevelfield ABILITY_ILF_MAXIMUM_NUMBER_OF_CORPSES_GYD1    = ConvertAbilityIntegerLevelField('Gyd1')
    constant abilityintegerlevelfield ABILITY_ILF_DAMAGE_TO_TREE                    = ConvertAbilityIntegerLevelField('Har1')
    constant abilityintegerlevelfield ABILITY_ILF_LUMBER_CAPACITY                   = ConvertAbilityIntegerLevelField('Har2')
    constant abilityintegerlevelfield ABILITY_ILF_GOLD_CAPACITY                     = ConvertAbilityIntegerLevelField('Har3')
    constant abilityintegerlevelfield ABILITY_ILF_DEFENSE_INCREASE_INF2             = ConvertAbilityIntegerLevelField('Inf2')
    constant abilityintegerlevelfield ABILITY_ILF_INTERACTION_TYPE                  = ConvertAbilityIntegerLevelField('Neu2')
    constant abilityintegerlevelfield ABILITY_ILF_GOLD_COST_NDT1                    = ConvertAbilityIntegerLevelField('Ndt1')
    constant abilityintegerlevelfield ABILITY_ILF_LUMBER_COST_NDT2                  = ConvertAbilityIntegerLevelField('Ndt2')
    constant abilityintegerlevelfield ABILITY_ILF_DETECTION_TYPE_NDT3               = ConvertAbilityIntegerLevelField('Ndt3')
    constant abilityintegerlevelfield ABILITY_ILF_STACKING_TYPE_POI4                = ConvertAbilityIntegerLevelField('Poi4')
    constant abilityintegerlevelfield ABILITY_ILF_STACKING_TYPE_POA5                = ConvertAbilityIntegerLevelField('Poa5')
    constant abilityintegerlevelfield ABILITY_ILF_MAXIMUM_CREEP_LEVEL_PLY1          = ConvertAbilityIntegerLevelField('Ply1')
    constant abilityintegerlevelfield ABILITY_ILF_MAXIMUM_CREEP_LEVEL_POS1          = ConvertAbilityIntegerLevelField('Pos1')
    constant abilityintegerlevelfield ABILITY_ILF_MOVEMENT_UPDATE_FREQUENCY_PRG1    = ConvertAbilityIntegerLevelField('Prg1')
    constant abilityintegerlevelfield ABILITY_ILF_ATTACK_UPDATE_FREQUENCY_PRG2      = ConvertAbilityIntegerLevelField('Prg2')
    constant abilityintegerlevelfield ABILITY_ILF_MANA_LOSS_PRG6                    = ConvertAbilityIntegerLevelField('Prg6')
    constant abilityintegerlevelfield ABILITY_ILF_UNITS_SUMMONED_TYPE_ONE           = ConvertAbilityIntegerLevelField('Rai1')
    constant abilityintegerlevelfield ABILITY_ILF_UNITS_SUMMONED_TYPE_TWO           = ConvertAbilityIntegerLevelField('Rai2')
    constant abilityintegerlevelfield ABILITY_ILF_MAX_UNITS_SUMMONED                = ConvertAbilityIntegerLevelField('Ucb5')
    constant abilityintegerlevelfield ABILITY_ILF_ALLOW_WHEN_FULL_REJ3              = ConvertAbilityIntegerLevelField('Rej3')
    constant abilityintegerlevelfield ABILITY_ILF_MAXIMUM_UNITS_CHARGED_TO_CASTER   = ConvertAbilityIntegerLevelField('Rpb5')
    constant abilityintegerlevelfield ABILITY_ILF_MAXIMUM_UNITS_AFFECTED            = ConvertAbilityIntegerLevelField('Rpb6')
    constant abilityintegerlevelfield ABILITY_ILF_DEFENSE_INCREASE_ROA2             = ConvertAbilityIntegerLevelField('Roa2')
    constant abilityintegerlevelfield ABILITY_ILF_MAX_UNITS_ROA7                    = ConvertAbilityIntegerLevelField('Roa7')
    constant abilityintegerlevelfield ABILITY_ILF_ROOTED_WEAPONS                    = ConvertAbilityIntegerLevelField('Roo1')
    constant abilityintegerlevelfield ABILITY_ILF_UPROOTED_WEAPONS                  = ConvertAbilityIntegerLevelField('Roo2')
    constant abilityintegerlevelfield ABILITY_ILF_UPROOTED_DEFENSE_TYPE             = ConvertAbilityIntegerLevelField('Roo4')
    constant abilityintegerlevelfield ABILITY_ILF_ACCUMULATION_STEP                 = ConvertAbilityIntegerLevelField('Sal2')
    constant abilityintegerlevelfield ABILITY_ILF_NUMBER_OF_OWLS                    = ConvertAbilityIntegerLevelField('Esn4')
    constant abilityintegerlevelfield ABILITY_ILF_STACKING_TYPE_SPO4                = ConvertAbilityIntegerLevelField('Spo4')
    constant abilityintegerlevelfield ABILITY_ILF_NUMBER_OF_UNITS                   = ConvertAbilityIntegerLevelField('Sod1')
    constant abilityintegerlevelfield ABILITY_ILF_SPIDER_CAPACITY                   = ConvertAbilityIntegerLevelField('Spa1')
    constant abilityintegerlevelfield ABILITY_ILF_INTERVALS_BEFORE_CHANGING_TREES   = ConvertAbilityIntegerLevelField('Wha2')
    constant abilityintegerlevelfield ABILITY_ILF_AGILITY_BONUS                     = ConvertAbilityIntegerLevelField('Iagi')
    constant abilityintegerlevelfield ABILITY_ILF_INTELLIGENCE_BONUS                = ConvertAbilityIntegerLevelField('Iint')
    constant abilityintegerlevelfield ABILITY_ILF_STRENGTH_BONUS_ISTR               = ConvertAbilityIntegerLevelField('Istr')
    constant abilityintegerlevelfield ABILITY_ILF_ATTACK_BONUS                      = ConvertAbilityIntegerLevelField('Iatt')
    constant abilityintegerlevelfield ABILITY_ILF_DEFENSE_BONUS_IDEF                = ConvertAbilityIntegerLevelField('Idef')
    constant abilityintegerlevelfield ABILITY_ILF_SUMMON_1_AMOUNT                   = ConvertAbilityIntegerLevelField('Isn1')
    constant abilityintegerlevelfield ABILITY_ILF_SUMMON_2_AMOUNT                   = ConvertAbilityIntegerLevelField('Isn2')
    constant abilityintegerlevelfield ABILITY_ILF_EXPERIENCE_GAINED                 = ConvertAbilityIntegerLevelField('Ixpg')
    constant abilityintegerlevelfield ABILITY_ILF_HIT_POINTS_GAINED_IHPG            = ConvertAbilityIntegerLevelField('Ihpg')
    constant abilityintegerlevelfield ABILITY_ILF_MANA_POINTS_GAINED_IMPG           = ConvertAbilityIntegerLevelField('Impg')
    constant abilityintegerlevelfield ABILITY_ILF_HIT_POINTS_GAINED_IHP2            = ConvertAbilityIntegerLevelField('Ihp2')
    constant abilityintegerlevelfield ABILITY_ILF_MANA_POINTS_GAINED_IMP2           = ConvertAbilityIntegerLevelField('Imp2')
    constant abilityintegerlevelfield ABILITY_ILF_DAMAGE_BONUS_DICE                 = ConvertAbilityIntegerLevelField('Idic')
    constant abilityintegerlevelfield ABILITY_ILF_ARMOR_PENALTY_IARP                = ConvertAbilityIntegerLevelField('Iarp')
    constant abilityintegerlevelfield ABILITY_ILF_ENABLED_ATTACK_INDEX_IOB5         = ConvertAbilityIntegerLevelField('Iob5')
    constant abilityintegerlevelfield ABILITY_ILF_LEVELS_GAINED                     = ConvertAbilityIntegerLevelField('Ilev')
    constant abilityintegerlevelfield ABILITY_ILF_MAX_LIFE_GAINED                   = ConvertAbilityIntegerLevelField('Ilif')
    constant abilityintegerlevelfield ABILITY_ILF_MAX_MANA_GAINED                   = ConvertAbilityIntegerLevelField('Iman')
    constant abilityintegerlevelfield ABILITY_ILF_GOLD_GIVEN                        = ConvertAbilityIntegerLevelField('Igol')
    constant abilityintegerlevelfield ABILITY_ILF_LUMBER_GIVEN                      = ConvertAbilityIntegerLevelField('Ilum')
    constant abilityintegerlevelfield ABILITY_ILF_DETECTION_TYPE_IFA1               = ConvertAbilityIntegerLevelField('Ifa1')
    constant abilityintegerlevelfield ABILITY_ILF_MAXIMUM_CREEP_LEVEL_ICRE          = ConvertAbilityIntegerLevelField('Icre')
    constant abilityintegerlevelfield ABILITY_ILF_MOVEMENT_SPEED_BONUS              = ConvertAbilityIntegerLevelField('Imvb')
    constant abilityintegerlevelfield ABILITY_ILF_HIT_POINTS_REGENERATED_PER_SECOND = ConvertAbilityIntegerLevelField('Ihpr')
    constant abilityintegerlevelfield ABILITY_ILF_SIGHT_RANGE_BONUS                 = ConvertAbilityIntegerLevelField('Isib')
    constant abilityintegerlevelfield ABILITY_ILF_DAMAGE_PER_DURATION               = ConvertAbilityIntegerLevelField('Icfd')
    constant abilityintegerlevelfield ABILITY_ILF_MANA_USED_PER_SECOND              = ConvertAbilityIntegerLevelField('Icfm')
    constant abilityintegerlevelfield ABILITY_ILF_EXTRA_MANA_REQUIRED               = ConvertAbilityIntegerLevelField('Icfx')
    constant abilityintegerlevelfield ABILITY_ILF_DETECTION_RADIUS_IDET             = ConvertAbilityIntegerLevelField('Idet')
    constant abilityintegerlevelfield ABILITY_ILF_MANA_LOSS_PER_UNIT_IDIM           = ConvertAbilityIntegerLevelField('Idim')
    constant abilityintegerlevelfield ABILITY_ILF_DAMAGE_TO_SUMMONED_UNITS_IDID     = ConvertAbilityIntegerLevelField('Idid')
    constant abilityintegerlevelfield ABILITY_ILF_MAXIMUM_NUMBER_OF_UNITS_IREC      = ConvertAbilityIntegerLevelField('Irec')
    constant abilityintegerlevelfield ABILITY_ILF_DELAY_AFTER_DEATH_SECONDS         = ConvertAbilityIntegerLevelField('Ircd')
    constant abilityintegerlevelfield ABILITY_ILF_RESTORED_LIFE                     = ConvertAbilityIntegerLevelField('irc2')
    constant abilityintegerlevelfield ABILITY_ILF_RESTORED_MANA__1_FOR_CURRENT      = ConvertAbilityIntegerLevelField('irc3')
    constant abilityintegerlevelfield ABILITY_ILF_HIT_POINTS_RESTORED               = ConvertAbilityIntegerLevelField('Ihps')
    constant abilityintegerlevelfield ABILITY_ILF_MANA_POINTS_RESTORED              = ConvertAbilityIntegerLevelField('Imps')
    constant abilityintegerlevelfield ABILITY_ILF_MAXIMUM_NUMBER_OF_UNITS_ITPM      = ConvertAbilityIntegerLevelField('Itpm')
    constant abilityintegerlevelfield ABILITY_ILF_NUMBER_OF_CORPSES_RAISED_CAD1     = ConvertAbilityIntegerLevelField('Cad1')
    constant abilityintegerlevelfield ABILITY_ILF_TERRAIN_DEFORMATION_DURATION_MS   = ConvertAbilityIntegerLevelField('Wrs3')
    constant abilityintegerlevelfield ABILITY_ILF_MAXIMUM_UNITS                     = ConvertAbilityIntegerLevelField('Uds1')
    constant abilityintegerlevelfield ABILITY_ILF_DETECTION_TYPE_DET1               = ConvertAbilityIntegerLevelField('Det1')
    constant abilityintegerlevelfield ABILITY_ILF_GOLD_COST_PER_STRUCTURE           = ConvertAbilityIntegerLevelField('Nsp1')
    constant abilityintegerlevelfield ABILITY_ILF_LUMBER_COST_PER_USE               = ConvertAbilityIntegerLevelField('Nsp2')
    constant abilityintegerlevelfield ABILITY_ILF_DETECTION_TYPE_NSP3               = ConvertAbilityIntegerLevelField('Nsp3')
    constant abilityintegerlevelfield ABILITY_ILF_NUMBER_OF_SWARM_UNITS             = ConvertAbilityIntegerLevelField('Uls1')
    constant abilityintegerlevelfield ABILITY_ILF_MAX_SWARM_UNITS_PER_TARGET        = ConvertAbilityIntegerLevelField('Uls3')
    constant abilityintegerlevelfield ABILITY_ILF_NUMBER_OF_SUMMONED_UNITS_NBA2     = ConvertAbilityIntegerLevelField('Nba2')
    constant abilityintegerlevelfield ABILITY_ILF_MAXIMUM_CREEP_LEVEL_NCH1          = ConvertAbilityIntegerLevelField('Nch1')
    constant abilityintegerlevelfield ABILITY_ILF_ATTACKS_PREVENTED                 = ConvertAbilityIntegerLevelField('Nsi1')
    constant abilityintegerlevelfield ABILITY_ILF_MAXIMUM_NUMBER_OF_TARGETS_EFK3    = ConvertAbilityIntegerLevelField('Efk3')
    constant abilityintegerlevelfield ABILITY_ILF_NUMBER_OF_SUMMONED_UNITS_ESV1     = ConvertAbilityIntegerLevelField('Esv1')
    constant abilityintegerlevelfield ABILITY_ILF_MAXIMUM_NUMBER_OF_CORPSES_EXH1    = ConvertAbilityIntegerLevelField('exh1')
    constant abilityintegerlevelfield ABILITY_ILF_ITEM_CAPACITY                     = ConvertAbilityIntegerLevelField('inv1')
    constant abilityintegerlevelfield ABILITY_ILF_MAXIMUM_NUMBER_OF_TARGETS_SPL2    = ConvertAbilityIntegerLevelField('spl2')
    constant abilityintegerlevelfield ABILITY_ILF_ALLOW_WHEN_FULL_IRL3              = ConvertAbilityIntegerLevelField('irl3')
    constant abilityintegerlevelfield ABILITY_ILF_MAXIMUM_DISPELLED_UNITS           = ConvertAbilityIntegerLevelField('idc3')
    constant abilityintegerlevelfield ABILITY_ILF_NUMBER_OF_LURES                   = ConvertAbilityIntegerLevelField('imo1')
    constant abilityintegerlevelfield ABILITY_ILF_NEW_TIME_OF_DAY_HOUR              = ConvertAbilityIntegerLevelField('ict1')
    constant abilityintegerlevelfield ABILITY_ILF_NEW_TIME_OF_DAY_MINUTE            = ConvertAbilityIntegerLevelField('ict2')
    constant abilityintegerlevelfield ABILITY_ILF_NUMBER_OF_UNITS_CREATED_MEC1      = ConvertAbilityIntegerLevelField('mec1')
    constant abilityintegerlevelfield ABILITY_ILF_MINIMUM_SPELLS                    = ConvertAbilityIntegerLevelField('spb3')
    constant abilityintegerlevelfield ABILITY_ILF_MAXIMUM_SPELLS                    = ConvertAbilityIntegerLevelField('spb4')
    constant abilityintegerlevelfield ABILITY_ILF_DISABLED_ATTACK_INDEX             = ConvertAbilityIntegerLevelField('gra3')
    constant abilityintegerlevelfield ABILITY_ILF_ENABLED_ATTACK_INDEX_GRA4         = ConvertAbilityIntegerLevelField('gra4')
    constant abilityintegerlevelfield ABILITY_ILF_MAXIMUM_ATTACKS                   = ConvertAbilityIntegerLevelField('gra5')
    constant abilityintegerlevelfield ABILITY_ILF_BUILDING_TYPES_ALLOWED_NPR1       = ConvertAbilityIntegerLevelField('Npr1')
    constant abilityintegerlevelfield ABILITY_ILF_BUILDING_TYPES_ALLOWED_NSA1       = ConvertAbilityIntegerLevelField('Nsa1')
    constant abilityintegerlevelfield ABILITY_ILF_ATTACK_MODIFICATION               = ConvertAbilityIntegerLevelField('Iaa1')
    constant abilityintegerlevelfield ABILITY_ILF_SUMMONED_UNIT_COUNT_NPA5          = ConvertAbilityIntegerLevelField('Npa5')
    constant abilityintegerlevelfield ABILITY_ILF_UPGRADE_LEVELS                    = ConvertAbilityIntegerLevelField('Igl1')
    constant abilityintegerlevelfield ABILITY_ILF_NUMBER_OF_SUMMONED_UNITS_NDO2     = ConvertAbilityIntegerLevelField('Ndo2')
    constant abilityintegerlevelfield ABILITY_ILF_BEASTS_PER_SECOND                 = ConvertAbilityIntegerLevelField('Nst1')
    constant abilityintegerlevelfield ABILITY_ILF_TARGET_TYPE                       = ConvertAbilityIntegerLevelField('Ncl2')
    constant abilityintegerlevelfield ABILITY_ILF_OPTIONS                           = ConvertAbilityIntegerLevelField('Ncl3')
    constant abilityintegerlevelfield ABILITY_ILF_ARMOR_PENALTY_NAB3                = ConvertAbilityIntegerLevelField('Nab3')
    constant abilityintegerlevelfield ABILITY_ILF_WAVE_COUNT_NHS6                   = ConvertAbilityIntegerLevelField('Nhs6')
    constant abilityintegerlevelfield ABILITY_ILF_MAX_CREEP_LEVEL_NTM3              = ConvertAbilityIntegerLevelField('Ntm3')
    constant abilityintegerlevelfield ABILITY_ILF_MISSILE_COUNT                     = ConvertAbilityIntegerLevelField('Ncs3')
    constant abilityintegerlevelfield ABILITY_ILF_SPLIT_ATTACK_COUNT                = ConvertAbilityIntegerLevelField('Nlm3')
    constant abilityintegerlevelfield ABILITY_ILF_GENERATION_COUNT                  = ConvertAbilityIntegerLevelField('Nlm6')
    constant abilityintegerlevelfield ABILITY_ILF_ROCK_RING_COUNT                   = ConvertAbilityIntegerLevelField('Nvc1')
    constant abilityintegerlevelfield ABILITY_ILF_WAVE_COUNT_NVC2                   = ConvertAbilityIntegerLevelField('Nvc2')
    constant abilityintegerlevelfield ABILITY_ILF_PREFER_HOSTILES_TAU1              = ConvertAbilityIntegerLevelField('Tau1')
    constant abilityintegerlevelfield ABILITY_ILF_PREFER_FRIENDLIES_TAU2            = ConvertAbilityIntegerLevelField('Tau2')
    constant abilityintegerlevelfield ABILITY_ILF_MAX_UNITS_TAU3                    = ConvertAbilityIntegerLevelField('Tau3')
    constant abilityintegerlevelfield ABILITY_ILF_NUMBER_OF_PULSES                  = ConvertAbilityIntegerLevelField('Tau4')
    constant abilityintegerlevelfield ABILITY_ILF_SUMMONED_UNIT_TYPE_HWE1           = ConvertAbilityIntegerLevelField('Hwe1')
    constant abilityintegerlevelfield ABILITY_ILF_SUMMONED_UNIT_UIN4                = ConvertAbilityIntegerLevelField('Uin4')
    constant abilityintegerlevelfield ABILITY_ILF_SUMMONED_UNIT_OSF1                = ConvertAbilityIntegerLevelField('Osf1')
    constant abilityintegerlevelfield ABILITY_ILF_SUMMONED_UNIT_TYPE_EFNU           = ConvertAbilityIntegerLevelField('Efnu')
    constant abilityintegerlevelfield ABILITY_ILF_SUMMONED_UNIT_TYPE_NBAU           = ConvertAbilityIntegerLevelField('Nbau')
    constant abilityintegerlevelfield ABILITY_ILF_SUMMONED_UNIT_TYPE_NTOU           = ConvertAbilityIntegerLevelField('Ntou')
    constant abilityintegerlevelfield ABILITY_ILF_SUMMONED_UNIT_TYPE_ESVU           = ConvertAbilityIntegerLevelField('Esvu')
    constant abilityintegerlevelfield ABILITY_ILF_SUMMONED_UNIT_TYPES               = ConvertAbilityIntegerLevelField('Nef1')
    constant abilityintegerlevelfield ABILITY_ILF_SUMMONED_UNIT_TYPE_NDOU           = ConvertAbilityIntegerLevelField('Ndou')
    constant abilityintegerlevelfield ABILITY_ILF_ALTERNATE_FORM_UNIT_EMEU          = ConvertAbilityIntegerLevelField('Emeu')
    constant abilityintegerlevelfield ABILITY_ILF_PLAGUE_WARD_UNIT_TYPE             = ConvertAbilityIntegerLevelField('Aplu')
    constant abilityintegerlevelfield ABILITY_ILF_ALLOWED_UNIT_TYPE_BTL1            = ConvertAbilityIntegerLevelField('Btl1')
    constant abilityintegerlevelfield ABILITY_ILF_NEW_UNIT_TYPE                     = ConvertAbilityIntegerLevelField('Cha1')
    constant abilityintegerlevelfield ABILITY_ILF_RESULTING_UNIT_TYPE_ENT1          = ConvertAbilityIntegerLevelField('ent1')
    constant abilityintegerlevelfield ABILITY_ILF_CORPSE_UNIT_TYPE                  = ConvertAbilityIntegerLevelField('Gydu')
    constant abilityintegerlevelfield ABILITY_ILF_ALLOWED_UNIT_TYPE_LOA1            = ConvertAbilityIntegerLevelField('Loa1')
    constant abilityintegerlevelfield ABILITY_ILF_UNIT_TYPE_FOR_LIMIT_CHECK         = ConvertAbilityIntegerLevelField('Raiu')
    constant abilityintegerlevelfield ABILITY_ILF_WARD_UNIT_TYPE_STAU               = ConvertAbilityIntegerLevelField('Stau')
    constant abilityintegerlevelfield ABILITY_ILF_EFFECT_ABILITY                    = ConvertAbilityIntegerLevelField('Iobu')
    constant abilityintegerlevelfield ABILITY_ILF_CONVERSION_UNIT                   = ConvertAbilityIntegerLevelField('Ndc2')
    constant abilityintegerlevelfield ABILITY_ILF_UNIT_TO_PRESERVE                  = ConvertAbilityIntegerLevelField('Nsl1')
    constant abilityintegerlevelfield ABILITY_ILF_UNIT_TYPE_ALLOWED                 = ConvertAbilityIntegerLevelField('Chl1')
    constant abilityintegerlevelfield ABILITY_ILF_SWARM_UNIT_TYPE                   = ConvertAbilityIntegerLevelField('Ulsu')
    constant abilityintegerlevelfield ABILITY_ILF_RESULTING_UNIT_TYPE_COAU          = ConvertAbilityIntegerLevelField('coau')
    constant abilityintegerlevelfield ABILITY_ILF_UNIT_TYPE_EXHU                    = ConvertAbilityIntegerLevelField('exhu')
    constant abilityintegerlevelfield ABILITY_ILF_WARD_UNIT_TYPE_HWDU               = ConvertAbilityIntegerLevelField('hwdu')
    constant abilityintegerlevelfield ABILITY_ILF_LURE_UNIT_TYPE                    = ConvertAbilityIntegerLevelField('imou')
    constant abilityintegerlevelfield ABILITY_ILF_UNIT_TYPE_IPMU                    = ConvertAbilityIntegerLevelField('ipmu')
    constant abilityintegerlevelfield ABILITY_ILF_FACTORY_UNIT_ID                   = ConvertAbilityIntegerLevelField('Nsyu')
    constant abilityintegerlevelfield ABILITY_ILF_SPAWN_UNIT_ID_NFYU                = ConvertAbilityIntegerLevelField('Nfyu')
    constant abilityintegerlevelfield ABILITY_ILF_DESTRUCTIBLE_ID                   = ConvertAbilityIntegerLevelField('Nvcu')
    constant abilityintegerlevelfield ABILITY_ILF_UPGRADE_TYPE                      = ConvertAbilityIntegerLevelField('Iglu')

    constant abilityreallevelfield ABILITY_RLF_CASTING_TIME                                      = ConvertAbilityRealLevelField('acas')
    constant abilityreallevelfield ABILITY_RLF_DURATION_NORMAL                                   = ConvertAbilityRealLevelField('adur')
    constant abilityreallevelfield ABILITY_RLF_DURATION_HERO                                     = ConvertAbilityRealLevelField('ahdu')
    constant abilityreallevelfield ABILITY_RLF_COOLDOWN                                          = ConvertAbilityRealLevelField('acdn')
    constant abilityreallevelfield ABILITY_RLF_AREA_OF_EFFECT                                    = ConvertAbilityRealLevelField('aare')
    constant abilityreallevelfield ABILITY_RLF_CAST_RANGE                                        = ConvertAbilityRealLevelField('aran')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_HBZ2                                       = ConvertAbilityRealLevelField('Hbz2')
    constant abilityreallevelfield ABILITY_RLF_BUILDING_REDUCTION_HBZ4                           = ConvertAbilityRealLevelField('Hbz4')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_PER_SECOND_HBZ5                            = ConvertAbilityRealLevelField('Hbz5')
    constant abilityreallevelfield ABILITY_RLF_MAXIMUM_DAMAGE_PER_WAVE                           = ConvertAbilityRealLevelField('Hbz6')
    constant abilityreallevelfield ABILITY_RLF_MANA_REGENERATION_INCREASE                        = ConvertAbilityRealLevelField('Hab1')
    constant abilityreallevelfield ABILITY_RLF_CASTING_DELAY                                     = ConvertAbilityRealLevelField('Hmt2')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_PER_SECOND_OWW1                            = ConvertAbilityRealLevelField('Oww1')
    constant abilityreallevelfield ABILITY_RLF_MAGIC_DAMAGE_REDUCTION_OWW2                       = ConvertAbilityRealLevelField('Oww2')
    constant abilityreallevelfield ABILITY_RLF_CHANCE_TO_CRITICAL_STRIKE                         = ConvertAbilityRealLevelField('Ocr1')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_MULTIPLIER_OCR2                            = ConvertAbilityRealLevelField('Ocr2')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_BONUS_OCR3                                 = ConvertAbilityRealLevelField('Ocr3')
    constant abilityreallevelfield ABILITY_RLF_CHANCE_TO_EVADE_OCR4                              = ConvertAbilityRealLevelField('Ocr4')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_DEALT_PERCENT_OMI2                         = ConvertAbilityRealLevelField('Omi2')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_TAKEN_PERCENT_OMI3                         = ConvertAbilityRealLevelField('Omi3')
    constant abilityreallevelfield ABILITY_RLF_ANIMATION_DELAY                                   = ConvertAbilityRealLevelField('Omi4')
    constant abilityreallevelfield ABILITY_RLF_TRANSITION_TIME                                   = ConvertAbilityRealLevelField('Owk1')
    constant abilityreallevelfield ABILITY_RLF_MOVEMENT_SPEED_INCREASE_PERCENT_OWK2              = ConvertAbilityRealLevelField('Owk2')
    constant abilityreallevelfield ABILITY_RLF_BACKSTAB_DAMAGE                                   = ConvertAbilityRealLevelField('Owk3')
    constant abilityreallevelfield ABILITY_RLF_AMOUNT_HEALED_DAMAGED_UDC1                        = ConvertAbilityRealLevelField('Udc1')
    constant abilityreallevelfield ABILITY_RLF_LIFE_CONVERTED_TO_MANA                            = ConvertAbilityRealLevelField('Udp1')
    constant abilityreallevelfield ABILITY_RLF_LIFE_CONVERTED_TO_LIFE                            = ConvertAbilityRealLevelField('Udp2')
    constant abilityreallevelfield ABILITY_RLF_MOVEMENT_SPEED_INCREASE_PERCENT_UAU1              = ConvertAbilityRealLevelField('Uau1')
    constant abilityreallevelfield ABILITY_RLF_LIFE_REGENERATION_INCREASE_PERCENT                = ConvertAbilityRealLevelField('Uau2')
    constant abilityreallevelfield ABILITY_RLF_CHANCE_TO_EVADE_EEV1                              = ConvertAbilityRealLevelField('Eev1')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_PER_INTERVAL                               = ConvertAbilityRealLevelField('Eim1')
    constant abilityreallevelfield ABILITY_RLF_MANA_DRAINED_PER_SECOND_EIM2                      = ConvertAbilityRealLevelField('Eim2')
    constant abilityreallevelfield ABILITY_RLF_BUFFER_MANA_REQUIRED                              = ConvertAbilityRealLevelField('Eim3')
    constant abilityreallevelfield ABILITY_RLF_MAX_MANA_DRAINED                                  = ConvertAbilityRealLevelField('Emb1')
    constant abilityreallevelfield ABILITY_RLF_BOLT_DELAY                                        = ConvertAbilityRealLevelField('Emb2')
    constant abilityreallevelfield ABILITY_RLF_BOLT_LIFETIME                                     = ConvertAbilityRealLevelField('Emb3')
    constant abilityreallevelfield ABILITY_RLF_ALTITUDE_ADJUSTMENT_DURATION                      = ConvertAbilityRealLevelField('Eme3')
    constant abilityreallevelfield ABILITY_RLF_LANDING_DELAY_TIME                                = ConvertAbilityRealLevelField('Eme4')
    constant abilityreallevelfield ABILITY_RLF_ALTERNATE_FORM_HIT_POINT_BONUS                    = ConvertAbilityRealLevelField('Eme5')
    constant abilityreallevelfield ABILITY_RLF_MOVE_SPEED_BONUS_INFO_PANEL_ONLY                  = ConvertAbilityRealLevelField('Ncr5')
    constant abilityreallevelfield ABILITY_RLF_ATTACK_SPEED_BONUS_INFO_PANEL_ONLY                = ConvertAbilityRealLevelField('Ncr6')
    constant abilityreallevelfield ABILITY_RLF_LIFE_REGENERATION_RATE_PER_SECOND                 = ConvertAbilityRealLevelField('ave5')
    constant abilityreallevelfield ABILITY_RLF_STUN_DURATION_USL1                                = ConvertAbilityRealLevelField('Usl1')
    constant abilityreallevelfield ABILITY_RLF_ATTACK_DAMAGE_STOLEN_PERCENT                      = ConvertAbilityRealLevelField('Uav1')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_UCS1                                       = ConvertAbilityRealLevelField('Ucs1')
    constant abilityreallevelfield ABILITY_RLF_MAX_DAMAGE_UCS2                                   = ConvertAbilityRealLevelField('Ucs2')
    constant abilityreallevelfield ABILITY_RLF_DISTANCE_UCS3                                     = ConvertAbilityRealLevelField('Ucs3')
    constant abilityreallevelfield ABILITY_RLF_FINAL_AREA_UCS4                                   = ConvertAbilityRealLevelField('Ucs4')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_UIN1                                       = ConvertAbilityRealLevelField('Uin1')
    constant abilityreallevelfield ABILITY_RLF_DURATION                                          = ConvertAbilityRealLevelField('Uin2')
    constant abilityreallevelfield ABILITY_RLF_IMPACT_DELAY                                      = ConvertAbilityRealLevelField('Uin3')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_PER_TARGET_OCL1                            = ConvertAbilityRealLevelField('Ocl1')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_REDUCTION_PER_TARGET                       = ConvertAbilityRealLevelField('Ocl3')
    constant abilityreallevelfield ABILITY_RLF_EFFECT_DELAY_OEQ1                                 = ConvertAbilityRealLevelField('Oeq1')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_PER_SECOND_TO_BUILDINGS                    = ConvertAbilityRealLevelField('Oeq2')
    constant abilityreallevelfield ABILITY_RLF_UNITS_SLOWED_PERCENT                              = ConvertAbilityRealLevelField('Oeq3')
    constant abilityreallevelfield ABILITY_RLF_FINAL_AREA_OEQ4                                   = ConvertAbilityRealLevelField('Oeq4')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_PER_SECOND_EER1                            = ConvertAbilityRealLevelField('Eer1')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_DEALT_TO_ATTACKERS                         = ConvertAbilityRealLevelField('Eah1')
    constant abilityreallevelfield ABILITY_RLF_LIFE_HEALED                                       = ConvertAbilityRealLevelField('Etq1')
    constant abilityreallevelfield ABILITY_RLF_HEAL_INTERVAL                                     = ConvertAbilityRealLevelField('Etq2')
    constant abilityreallevelfield ABILITY_RLF_BUILDING_REDUCTION_ETQ3                           = ConvertAbilityRealLevelField('Etq3')
    constant abilityreallevelfield ABILITY_RLF_INITIAL_IMMUNITY_DURATION                         = ConvertAbilityRealLevelField('Etq4')
    constant abilityreallevelfield ABILITY_RLF_MAX_LIFE_DRAINED_PER_SECOND_PERCENT               = ConvertAbilityRealLevelField('Udd1')
    constant abilityreallevelfield ABILITY_RLF_BUILDING_REDUCTION_UDD2                           = ConvertAbilityRealLevelField('Udd2')
    constant abilityreallevelfield ABILITY_RLF_ARMOR_DURATION                                    = ConvertAbilityRealLevelField('Ufa1')
    constant abilityreallevelfield ABILITY_RLF_ARMOR_BONUS_UFA2                                  = ConvertAbilityRealLevelField('Ufa2')
    constant abilityreallevelfield ABILITY_RLF_AREA_OF_EFFECT_DAMAGE                             = ConvertAbilityRealLevelField('Ufn1')
    constant abilityreallevelfield ABILITY_RLF_SPECIFIC_TARGET_DAMAGE_UFN2                       = ConvertAbilityRealLevelField('Ufn2')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_BONUS_HFA1                                 = ConvertAbilityRealLevelField('Hfa1')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_DEALT_ESF1                                 = ConvertAbilityRealLevelField('Esf1')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_INTERVAL_ESF2                              = ConvertAbilityRealLevelField('Esf2')
    constant abilityreallevelfield ABILITY_RLF_BUILDING_REDUCTION_ESF3                           = ConvertAbilityRealLevelField('Esf3')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_BONUS_PERCENT                              = ConvertAbilityRealLevelField('Ear1')
    constant abilityreallevelfield ABILITY_RLF_DEFENSE_BONUS_HAV1                                = ConvertAbilityRealLevelField('Hav1')
    constant abilityreallevelfield ABILITY_RLF_HIT_POINT_BONUS                                   = ConvertAbilityRealLevelField('Hav2')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_BONUS_HAV3                                 = ConvertAbilityRealLevelField('Hav3')
    constant abilityreallevelfield ABILITY_RLF_MAGIC_DAMAGE_REDUCTION_HAV4                       = ConvertAbilityRealLevelField('Hav4')
    constant abilityreallevelfield ABILITY_RLF_CHANCE_TO_BASH                                    = ConvertAbilityRealLevelField('Hbh1')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_MULTIPLIER_HBH2                            = ConvertAbilityRealLevelField('Hbh2')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_BONUS_HBH3                                 = ConvertAbilityRealLevelField('Hbh3')
    constant abilityreallevelfield ABILITY_RLF_CHANCE_TO_MISS_HBH4                               = ConvertAbilityRealLevelField('Hbh4')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_HTB1                                       = ConvertAbilityRealLevelField('Htb1')
    constant abilityreallevelfield ABILITY_RLF_AOE_DAMAGE                                        = ConvertAbilityRealLevelField('Htc1')
    constant abilityreallevelfield ABILITY_RLF_SPECIFIC_TARGET_DAMAGE_HTC2                       = ConvertAbilityRealLevelField('Htc2')
    constant abilityreallevelfield ABILITY_RLF_MOVEMENT_SPEED_REDUCTION_PERCENT_HTC3             = ConvertAbilityRealLevelField('Htc3')
    constant abilityreallevelfield ABILITY_RLF_ATTACK_SPEED_REDUCTION_PERCENT_HTC4               = ConvertAbilityRealLevelField('Htc4')
    constant abilityreallevelfield ABILITY_RLF_ARMOR_BONUS_HAD1                                  = ConvertAbilityRealLevelField('Had1')
    constant abilityreallevelfield ABILITY_RLF_AMOUNT_HEALED_DAMAGED_HHB1                        = ConvertAbilityRealLevelField('Hhb1')
    constant abilityreallevelfield ABILITY_RLF_EXTRA_DAMAGE_HCA1                                 = ConvertAbilityRealLevelField('Hca1')
    constant abilityreallevelfield ABILITY_RLF_MOVEMENT_SPEED_FACTOR_HCA2                        = ConvertAbilityRealLevelField('Hca2')
    constant abilityreallevelfield ABILITY_RLF_ATTACK_SPEED_FACTOR_HCA3                          = ConvertAbilityRealLevelField('Hca3')
    constant abilityreallevelfield ABILITY_RLF_MOVEMENT_SPEED_INCREASE_PERCENT_OAE1              = ConvertAbilityRealLevelField('Oae1')
    constant abilityreallevelfield ABILITY_RLF_ATTACK_SPEED_INCREASE_PERCENT_OAE2                = ConvertAbilityRealLevelField('Oae2')
    constant abilityreallevelfield ABILITY_RLF_REINCARNATION_DELAY                               = ConvertAbilityRealLevelField('Ore1')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_OSH1                                       = ConvertAbilityRealLevelField('Osh1')
    constant abilityreallevelfield ABILITY_RLF_MAXIMUM_DAMAGE_OSH2                               = ConvertAbilityRealLevelField('Osh2')
    constant abilityreallevelfield ABILITY_RLF_DISTANCE_OSH3                                     = ConvertAbilityRealLevelField('Osh3')
    constant abilityreallevelfield ABILITY_RLF_FINAL_AREA_OSH4                                   = ConvertAbilityRealLevelField('Osh4')
    constant abilityreallevelfield ABILITY_RLF_GRAPHIC_DELAY_NFD1                                = ConvertAbilityRealLevelField('Nfd1')
    constant abilityreallevelfield ABILITY_RLF_GRAPHIC_DURATION_NFD2                             = ConvertAbilityRealLevelField('Nfd2')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_NFD3                                       = ConvertAbilityRealLevelField('Nfd3')
    constant abilityreallevelfield ABILITY_RLF_SUMMONED_UNIT_DAMAGE_AMS1                         = ConvertAbilityRealLevelField('Ams1')
    constant abilityreallevelfield ABILITY_RLF_MAGIC_DAMAGE_REDUCTION_AMS2                       = ConvertAbilityRealLevelField('Ams2')
    constant abilityreallevelfield ABILITY_RLF_AURA_DURATION                                     = ConvertAbilityRealLevelField('Apl1')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_PER_SECOND_APL2                            = ConvertAbilityRealLevelField('Apl2')
    constant abilityreallevelfield ABILITY_RLF_DURATION_OF_PLAGUE_WARD                           = ConvertAbilityRealLevelField('Apl3')
    constant abilityreallevelfield ABILITY_RLF_AMOUNT_OF_HIT_POINTS_REGENERATED                  = ConvertAbilityRealLevelField('Oar1')
    constant abilityreallevelfield ABILITY_RLF_ATTACK_DAMAGE_INCREASE_AKB1                       = ConvertAbilityRealLevelField('Akb1')
    constant abilityreallevelfield ABILITY_RLF_MANA_LOSS_ADM1                                    = ConvertAbilityRealLevelField('Adm1')
    constant abilityreallevelfield ABILITY_RLF_SUMMONED_UNIT_DAMAGE_ADM2                         = ConvertAbilityRealLevelField('Adm2')
    constant abilityreallevelfield ABILITY_RLF_EXPANSION_AMOUNT                                  = ConvertAbilityRealLevelField('Bli1')
    constant abilityreallevelfield ABILITY_RLF_INTERVAL_DURATION_BGM2                            = ConvertAbilityRealLevelField('Bgm2')
    constant abilityreallevelfield ABILITY_RLF_RADIUS_OF_MINING_RING                             = ConvertAbilityRealLevelField('Bgm4')
    constant abilityreallevelfield ABILITY_RLF_ATTACK_SPEED_INCREASE_PERCENT_BLO1                = ConvertAbilityRealLevelField('Blo1')
    constant abilityreallevelfield ABILITY_RLF_MOVEMENT_SPEED_INCREASE_PERCENT_BLO2              = ConvertAbilityRealLevelField('Blo2')
    constant abilityreallevelfield ABILITY_RLF_SCALING_FACTOR                                    = ConvertAbilityRealLevelField('Blo3')
    constant abilityreallevelfield ABILITY_RLF_HIT_POINTS_PER_SECOND_CAN1                        = ConvertAbilityRealLevelField('Can1')
    constant abilityreallevelfield ABILITY_RLF_MAX_HIT_POINTS                                    = ConvertAbilityRealLevelField('Can2')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_PER_SECOND_DEV2                            = ConvertAbilityRealLevelField('Dev2')
    constant abilityreallevelfield ABILITY_RLF_MOVEMENT_UPDATE_FREQUENCY_CHD1                    = ConvertAbilityRealLevelField('Chd1')
    constant abilityreallevelfield ABILITY_RLF_ATTACK_UPDATE_FREQUENCY_CHD2                      = ConvertAbilityRealLevelField('Chd2')
    constant abilityreallevelfield ABILITY_RLF_SUMMONED_UNIT_DAMAGE_CHD3                         = ConvertAbilityRealLevelField('Chd3')
    constant abilityreallevelfield ABILITY_RLF_MOVEMENT_SPEED_REDUCTION_PERCENT_CRI1             = ConvertAbilityRealLevelField('Cri1')
    constant abilityreallevelfield ABILITY_RLF_ATTACK_SPEED_REDUCTION_PERCENT_CRI2               = ConvertAbilityRealLevelField('Cri2')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_REDUCTION_CRI3                             = ConvertAbilityRealLevelField('Cri3')
    constant abilityreallevelfield ABILITY_RLF_CHANCE_TO_MISS_CRS                                = ConvertAbilityRealLevelField('Crs1')
    constant abilityreallevelfield ABILITY_RLF_FULL_DAMAGE_RADIUS_DDA1                           = ConvertAbilityRealLevelField('Dda1')
    constant abilityreallevelfield ABILITY_RLF_FULL_DAMAGE_AMOUNT_DDA2                           = ConvertAbilityRealLevelField('Dda2')
    constant abilityreallevelfield ABILITY_RLF_PARTIAL_DAMAGE_RADIUS                             = ConvertAbilityRealLevelField('Dda3')
    constant abilityreallevelfield ABILITY_RLF_PARTIAL_DAMAGE_AMOUNT                             = ConvertAbilityRealLevelField('Dda4')
    constant abilityreallevelfield ABILITY_RLF_BUILDING_DAMAGE_FACTOR_SDS1                       = ConvertAbilityRealLevelField('Sds1')
    constant abilityreallevelfield ABILITY_RLF_MAX_DAMAGE_UCO5                                   = ConvertAbilityRealLevelField('Uco5')
    constant abilityreallevelfield ABILITY_RLF_MOVE_SPEED_BONUS_UCO6                             = ConvertAbilityRealLevelField('Uco6')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_TAKEN_PERCENT_DEF1                         = ConvertAbilityRealLevelField('Def1')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_DEALT_PERCENT_DEF2                         = ConvertAbilityRealLevelField('Def2')
    constant abilityreallevelfield ABILITY_RLF_MOVEMENT_SPEED_FACTOR_DEF3                        = ConvertAbilityRealLevelField('Def3')
    constant abilityreallevelfield ABILITY_RLF_ATTACK_SPEED_FACTOR_DEF4                          = ConvertAbilityRealLevelField('Def4')
    constant abilityreallevelfield ABILITY_RLF_MAGIC_DAMAGE_REDUCTION_DEF5                       = ConvertAbilityRealLevelField('Def5')
    constant abilityreallevelfield ABILITY_RLF_CHANCE_TO_DEFLECT                                 = ConvertAbilityRealLevelField('Def6')
    constant abilityreallevelfield ABILITY_RLF_DEFLECT_DAMAGE_TAKEN_PIERCING                     = ConvertAbilityRealLevelField('Def7')
    constant abilityreallevelfield ABILITY_RLF_DEFLECT_DAMAGE_TAKEN_SPELLS                       = ConvertAbilityRealLevelField('Def8')
    constant abilityreallevelfield ABILITY_RLF_RIP_DELAY                                         = ConvertAbilityRealLevelField('Eat1')
    constant abilityreallevelfield ABILITY_RLF_EAT_DELAY                                         = ConvertAbilityRealLevelField('Eat2')
    constant abilityreallevelfield ABILITY_RLF_HIT_POINTS_GAINED_EAT3                            = ConvertAbilityRealLevelField('Eat3')
    constant abilityreallevelfield ABILITY_RLF_AIR_UNIT_LOWER_DURATION                           = ConvertAbilityRealLevelField('Ens1')
    constant abilityreallevelfield ABILITY_RLF_AIR_UNIT_HEIGHT                                   = ConvertAbilityRealLevelField('Ens2')
    constant abilityreallevelfield ABILITY_RLF_MELEE_ATTACK_RANGE                                = ConvertAbilityRealLevelField('Ens3')
    constant abilityreallevelfield ABILITY_RLF_INTERVAL_DURATION_EGM2                            = ConvertAbilityRealLevelField('Egm2')
    constant abilityreallevelfield ABILITY_RLF_EFFECT_DELAY_FLA2                                 = ConvertAbilityRealLevelField('Fla2')
    constant abilityreallevelfield ABILITY_RLF_MINING_DURATION                                   = ConvertAbilityRealLevelField('Gld2')
    constant abilityreallevelfield ABILITY_RLF_RADIUS_OF_GRAVESTONES                             = ConvertAbilityRealLevelField('Gyd2')
    constant abilityreallevelfield ABILITY_RLF_RADIUS_OF_CORPSES                                 = ConvertAbilityRealLevelField('Gyd3')
    constant abilityreallevelfield ABILITY_RLF_HIT_POINTS_GAINED_HEA1                            = ConvertAbilityRealLevelField('Hea1')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_INCREASE_PERCENT_INF1                      = ConvertAbilityRealLevelField('Inf1')
    constant abilityreallevelfield ABILITY_RLF_AUTOCAST_RANGE                                    = ConvertAbilityRealLevelField('Inf3')
    constant abilityreallevelfield ABILITY_RLF_LIFE_REGEN_RATE                                   = ConvertAbilityRealLevelField('Inf4')
    constant abilityreallevelfield ABILITY_RLF_GRAPHIC_DELAY_LIT1                                = ConvertAbilityRealLevelField('Lit1')
    constant abilityreallevelfield ABILITY_RLF_GRAPHIC_DURATION_LIT2                             = ConvertAbilityRealLevelField('Lit2')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_PER_SECOND_LSH1                            = ConvertAbilityRealLevelField('Lsh1')
    constant abilityreallevelfield ABILITY_RLF_MANA_GAINED                                       = ConvertAbilityRealLevelField('Mbt1')
    constant abilityreallevelfield ABILITY_RLF_HIT_POINTS_GAINED_MBT2                            = ConvertAbilityRealLevelField('Mbt2')
    constant abilityreallevelfield ABILITY_RLF_AUTOCAST_REQUIREMENT                              = ConvertAbilityRealLevelField('Mbt3')
    constant abilityreallevelfield ABILITY_RLF_WATER_HEIGHT                                      = ConvertAbilityRealLevelField('Mbt4')
    constant abilityreallevelfield ABILITY_RLF_ACTIVATION_DELAY_MIN1                             = ConvertAbilityRealLevelField('Min1')
    constant abilityreallevelfield ABILITY_RLF_INVISIBILITY_TRANSITION_TIME                      = ConvertAbilityRealLevelField('Min2')
    constant abilityreallevelfield ABILITY_RLF_ACTIVATION_RADIUS                                 = ConvertAbilityRealLevelField('Neu1')
    constant abilityreallevelfield ABILITY_RLF_AMOUNT_REGENERATED                                = ConvertAbilityRealLevelField('Arm1')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_PER_SECOND_POI1                            = ConvertAbilityRealLevelField('Poi1')
    constant abilityreallevelfield ABILITY_RLF_ATTACK_SPEED_FACTOR_POI2                          = ConvertAbilityRealLevelField('Poi2')
    constant abilityreallevelfield ABILITY_RLF_MOVEMENT_SPEED_FACTOR_POI3                        = ConvertAbilityRealLevelField('Poi3')
    constant abilityreallevelfield ABILITY_RLF_EXTRA_DAMAGE_POA1                                 = ConvertAbilityRealLevelField('Poa1')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_PER_SECOND_POA2                            = ConvertAbilityRealLevelField('Poa2')
    constant abilityreallevelfield ABILITY_RLF_ATTACK_SPEED_FACTOR_POA3                          = ConvertAbilityRealLevelField('Poa3')
    constant abilityreallevelfield ABILITY_RLF_MOVEMENT_SPEED_FACTOR_POA4                        = ConvertAbilityRealLevelField('Poa4')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_AMPLIFICATION                              = ConvertAbilityRealLevelField('Pos2')
    constant abilityreallevelfield ABILITY_RLF_CHANCE_TO_STOMP_PERCENT                           = ConvertAbilityRealLevelField('War1')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_DEALT_WAR2                                 = ConvertAbilityRealLevelField('War2')
    constant abilityreallevelfield ABILITY_RLF_FULL_DAMAGE_RADIUS_WAR3                           = ConvertAbilityRealLevelField('War3')
    constant abilityreallevelfield ABILITY_RLF_HALF_DAMAGE_RADIUS_WAR4                           = ConvertAbilityRealLevelField('War4')
    constant abilityreallevelfield ABILITY_RLF_SUMMONED_UNIT_DAMAGE_PRG3                         = ConvertAbilityRealLevelField('Prg3')
    constant abilityreallevelfield ABILITY_RLF_UNIT_PAUSE_DURATION                               = ConvertAbilityRealLevelField('Prg4')
    constant abilityreallevelfield ABILITY_RLF_HERO_PAUSE_DURATION                               = ConvertAbilityRealLevelField('Prg5')
    constant abilityreallevelfield ABILITY_RLF_HIT_POINTS_GAINED_REJ1                            = ConvertAbilityRealLevelField('Rej1')
    constant abilityreallevelfield ABILITY_RLF_MANA_POINTS_GAINED_REJ2                           = ConvertAbilityRealLevelField('Rej2')
    constant abilityreallevelfield ABILITY_RLF_MINIMUM_LIFE_REQUIRED                             = ConvertAbilityRealLevelField('Rpb3')
    constant abilityreallevelfield ABILITY_RLF_MINIMUM_MANA_REQUIRED                             = ConvertAbilityRealLevelField('Rpb4')
    constant abilityreallevelfield ABILITY_RLF_REPAIR_COST_RATIO                                 = ConvertAbilityRealLevelField('Rep1')
    constant abilityreallevelfield ABILITY_RLF_REPAIR_TIME_RATIO                                 = ConvertAbilityRealLevelField('Rep2')
    constant abilityreallevelfield ABILITY_RLF_POWERBUILD_COST                                   = ConvertAbilityRealLevelField('Rep3')
    constant abilityreallevelfield ABILITY_RLF_POWERBUILD_RATE                                   = ConvertAbilityRealLevelField('Rep4')
    constant abilityreallevelfield ABILITY_RLF_NAVAL_RANGE_BONUS                                 = ConvertAbilityRealLevelField('Rep5')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_INCREASE_PERCENT_ROA1                      = ConvertAbilityRealLevelField('Roa1')
    constant abilityreallevelfield ABILITY_RLF_LIFE_REGENERATION_RATE                            = ConvertAbilityRealLevelField('Roa3')
    constant abilityreallevelfield ABILITY_RLF_MANA_REGEN                                        = ConvertAbilityRealLevelField('Roa4')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_INCREASE                                   = ConvertAbilityRealLevelField('Nbr1')
    constant abilityreallevelfield ABILITY_RLF_SALVAGE_COST_RATIO                                = ConvertAbilityRealLevelField('Sal1')
    constant abilityreallevelfield ABILITY_RLF_IN_FLIGHT_SIGHT_RADIUS                            = ConvertAbilityRealLevelField('Esn1')
    constant abilityreallevelfield ABILITY_RLF_HOVERING_SIGHT_RADIUS                             = ConvertAbilityRealLevelField('Esn2')
    constant abilityreallevelfield ABILITY_RLF_HOVERING_HEIGHT                                   = ConvertAbilityRealLevelField('Esn3')
    constant abilityreallevelfield ABILITY_RLF_DURATION_OF_OWLS                                  = ConvertAbilityRealLevelField('Esn5')
    constant abilityreallevelfield ABILITY_RLF_FADE_DURATION                                     = ConvertAbilityRealLevelField('Shm1')
    constant abilityreallevelfield ABILITY_RLF_DAY_NIGHT_DURATION                                = ConvertAbilityRealLevelField('Shm2')
    constant abilityreallevelfield ABILITY_RLF_ACTION_DURATION                                   = ConvertAbilityRealLevelField('Shm3')
    constant abilityreallevelfield ABILITY_RLF_MOVEMENT_SPEED_FACTOR_SLO1                        = ConvertAbilityRealLevelField('Slo1')
    constant abilityreallevelfield ABILITY_RLF_ATTACK_SPEED_FACTOR_SLO2                          = ConvertAbilityRealLevelField('Slo2')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_PER_SECOND_SPO1                            = ConvertAbilityRealLevelField('Spo1')
    constant abilityreallevelfield ABILITY_RLF_MOVEMENT_SPEED_FACTOR_SPO2                        = ConvertAbilityRealLevelField('Spo2')
    constant abilityreallevelfield ABILITY_RLF_ATTACK_SPEED_FACTOR_SPO3                          = ConvertAbilityRealLevelField('Spo3')
    constant abilityreallevelfield ABILITY_RLF_ACTIVATION_DELAY_STA1                             = ConvertAbilityRealLevelField('Sta1')
    constant abilityreallevelfield ABILITY_RLF_DETECTION_RADIUS_STA2                             = ConvertAbilityRealLevelField('Sta2')
    constant abilityreallevelfield ABILITY_RLF_DETONATION_RADIUS                                 = ConvertAbilityRealLevelField('Sta3')
    constant abilityreallevelfield ABILITY_RLF_STUN_DURATION_STA4                                = ConvertAbilityRealLevelField('Sta4')
    constant abilityreallevelfield ABILITY_RLF_ATTACK_SPEED_BONUS_PERCENT                        = ConvertAbilityRealLevelField('Uhf1')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_PER_SECOND_UHF2                            = ConvertAbilityRealLevelField('Uhf2')
    constant abilityreallevelfield ABILITY_RLF_LUMBER_PER_INTERVAL                               = ConvertAbilityRealLevelField('Wha1')
    constant abilityreallevelfield ABILITY_RLF_ART_ATTACHMENT_HEIGHT                             = ConvertAbilityRealLevelField('Wha3')
    constant abilityreallevelfield ABILITY_RLF_TELEPORT_AREA_WIDTH                               = ConvertAbilityRealLevelField('Wrp1')
    constant abilityreallevelfield ABILITY_RLF_TELEPORT_AREA_HEIGHT                              = ConvertAbilityRealLevelField('Wrp2')
    constant abilityreallevelfield ABILITY_RLF_LIFE_STOLEN_PER_ATTACK                            = ConvertAbilityRealLevelField('Ivam')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_BONUS_IDAM                                 = ConvertAbilityRealLevelField('Idam')
    constant abilityreallevelfield ABILITY_RLF_CHANCE_TO_HIT_UNITS_PERCENT                       = ConvertAbilityRealLevelField('Iob2')
    constant abilityreallevelfield ABILITY_RLF_CHANCE_TO_HIT_HEROS_PERCENT                       = ConvertAbilityRealLevelField('Iob3')
    constant abilityreallevelfield ABILITY_RLF_CHANCE_TO_HIT_SUMMONS_PERCENT                     = ConvertAbilityRealLevelField('Iob4')
    constant abilityreallevelfield ABILITY_RLF_DELAY_FOR_TARGET_EFFECT                           = ConvertAbilityRealLevelField('Idel')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_DEALT_PERCENT_OF_NORMAL                    = ConvertAbilityRealLevelField('Iild')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_RECEIVED_MULTIPLIER                        = ConvertAbilityRealLevelField('Iilw')
    constant abilityreallevelfield ABILITY_RLF_MANA_REGENERATION_BONUS_AS_FRACTION_OF_NORMAL     = ConvertAbilityRealLevelField('Imrp')
    constant abilityreallevelfield ABILITY_RLF_MOVEMENT_SPEED_INCREASE_ISPI                      = ConvertAbilityRealLevelField('Ispi')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_PER_SECOND_IDPS                            = ConvertAbilityRealLevelField('Idps')
    constant abilityreallevelfield ABILITY_RLF_ATTACK_DAMAGE_INCREASE_CAC1                       = ConvertAbilityRealLevelField('Cac1')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_PER_SECOND_COR1                            = ConvertAbilityRealLevelField('Cor1')
    constant abilityreallevelfield ABILITY_RLF_ATTACK_SPEED_INCREASE_ISX1                        = ConvertAbilityRealLevelField('Isx1')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_WRS1                                       = ConvertAbilityRealLevelField('Wrs1')
    constant abilityreallevelfield ABILITY_RLF_TERRAIN_DEFORMATION_AMPLITUDE                     = ConvertAbilityRealLevelField('Wrs2')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_CTC1                                       = ConvertAbilityRealLevelField('Ctc1')
    constant abilityreallevelfield ABILITY_RLF_EXTRA_DAMAGE_TO_TARGET                            = ConvertAbilityRealLevelField('Ctc2')
    constant abilityreallevelfield ABILITY_RLF_MOVEMENT_SPEED_REDUCTION_CTC3                     = ConvertAbilityRealLevelField('Ctc3')
    constant abilityreallevelfield ABILITY_RLF_ATTACK_SPEED_REDUCTION_CTC4                       = ConvertAbilityRealLevelField('Ctc4')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_CTB1                                       = ConvertAbilityRealLevelField('Ctb1')
    constant abilityreallevelfield ABILITY_RLF_CASTING_DELAY_SECONDS                             = ConvertAbilityRealLevelField('Uds2')
    constant abilityreallevelfield ABILITY_RLF_MANA_LOSS_PER_UNIT_DTN1                           = ConvertAbilityRealLevelField('Dtn1')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_TO_SUMMONED_UNITS_DTN2                     = ConvertAbilityRealLevelField('Dtn2')
    constant abilityreallevelfield ABILITY_RLF_TRANSITION_TIME_SECONDS                           = ConvertAbilityRealLevelField('Ivs1')
    constant abilityreallevelfield ABILITY_RLF_MANA_DRAINED_PER_SECOND_NMR1                      = ConvertAbilityRealLevelField('Nmr1')
    constant abilityreallevelfield ABILITY_RLF_CHANCE_TO_REDUCE_DAMAGE_PERCENT                   = ConvertAbilityRealLevelField('Ssk1')
    constant abilityreallevelfield ABILITY_RLF_MINIMUM_DAMAGE                                    = ConvertAbilityRealLevelField('Ssk2')
    constant abilityreallevelfield ABILITY_RLF_IGNORED_DAMAGE                                    = ConvertAbilityRealLevelField('Ssk3')
    constant abilityreallevelfield ABILITY_RLF_FULL_DAMAGE_DEALT                                 = ConvertAbilityRealLevelField('Hfs1')
    constant abilityreallevelfield ABILITY_RLF_FULL_DAMAGE_INTERVAL                              = ConvertAbilityRealLevelField('Hfs2')
    constant abilityreallevelfield ABILITY_RLF_HALF_DAMAGE_DEALT                                 = ConvertAbilityRealLevelField('Hfs3')
    constant abilityreallevelfield ABILITY_RLF_HALF_DAMAGE_INTERVAL                              = ConvertAbilityRealLevelField('Hfs4')
    constant abilityreallevelfield ABILITY_RLF_BUILDING_REDUCTION_HFS5                           = ConvertAbilityRealLevelField('Hfs5')
    constant abilityreallevelfield ABILITY_RLF_MAXIMUM_DAMAGE_HFS6                               = ConvertAbilityRealLevelField('Hfs6')
    constant abilityreallevelfield ABILITY_RLF_MANA_PER_HIT_POINT                                = ConvertAbilityRealLevelField('Nms1')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_ABSORBED_PERCENT                           = ConvertAbilityRealLevelField('Nms2')
    constant abilityreallevelfield ABILITY_RLF_WAVE_DISTANCE                                     = ConvertAbilityRealLevelField('Uim1')
    constant abilityreallevelfield ABILITY_RLF_WAVE_TIME_SECONDS                                 = ConvertAbilityRealLevelField('Uim2')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_DEALT_UIM3                                 = ConvertAbilityRealLevelField('Uim3')
    constant abilityreallevelfield ABILITY_RLF_AIR_TIME_SECONDS_UIM4                             = ConvertAbilityRealLevelField('Uim4')
    constant abilityreallevelfield ABILITY_RLF_UNIT_RELEASE_INTERVAL_SECONDS                     = ConvertAbilityRealLevelField('Uls2')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_RETURN_FACTOR                              = ConvertAbilityRealLevelField('Uls4')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_RETURN_THRESHOLD                           = ConvertAbilityRealLevelField('Uls5')
    constant abilityreallevelfield ABILITY_RLF_RETURNED_DAMAGE_FACTOR                            = ConvertAbilityRealLevelField('Uts1')
    constant abilityreallevelfield ABILITY_RLF_RECEIVED_DAMAGE_FACTOR                            = ConvertAbilityRealLevelField('Uts2')
    constant abilityreallevelfield ABILITY_RLF_DEFENSE_BONUS_UTS3                                = ConvertAbilityRealLevelField('Uts3')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_BONUS_NBA1                                 = ConvertAbilityRealLevelField('Nba1')
    constant abilityreallevelfield ABILITY_RLF_SUMMONED_UNIT_DURATION_SECONDS_NBA3               = ConvertAbilityRealLevelField('Nba3')
    constant abilityreallevelfield ABILITY_RLF_MANA_PER_SUMMONED_HITPOINT                        = ConvertAbilityRealLevelField('Cmg2')
    constant abilityreallevelfield ABILITY_RLF_CHARGE_FOR_CURRENT_LIFE                           = ConvertAbilityRealLevelField('Cmg3')
    constant abilityreallevelfield ABILITY_RLF_HIT_POINTS_DRAINED                                = ConvertAbilityRealLevelField('Ndr1')
    constant abilityreallevelfield ABILITY_RLF_MANA_POINTS_DRAINED                               = ConvertAbilityRealLevelField('Ndr2')
    constant abilityreallevelfield ABILITY_RLF_DRAIN_INTERVAL_SECONDS                            = ConvertAbilityRealLevelField('Ndr3')
    constant abilityreallevelfield ABILITY_RLF_LIFE_TRANSFERRED_PER_SECOND                       = ConvertAbilityRealLevelField('Ndr4')
    constant abilityreallevelfield ABILITY_RLF_MANA_TRANSFERRED_PER_SECOND                       = ConvertAbilityRealLevelField('Ndr5')
    constant abilityreallevelfield ABILITY_RLF_BONUS_LIFE_FACTOR                                 = ConvertAbilityRealLevelField('Ndr6')
    constant abilityreallevelfield ABILITY_RLF_BONUS_LIFE_DECAY                                  = ConvertAbilityRealLevelField('Ndr7')
    constant abilityreallevelfield ABILITY_RLF_BONUS_MANA_FACTOR                                 = ConvertAbilityRealLevelField('Ndr8')
    constant abilityreallevelfield ABILITY_RLF_BONUS_MANA_DECAY                                  = ConvertAbilityRealLevelField('Ndr9')
    constant abilityreallevelfield ABILITY_RLF_CHANCE_TO_MISS_PERCENT                            = ConvertAbilityRealLevelField('Nsi2')
    constant abilityreallevelfield ABILITY_RLF_MOVEMENT_SPEED_MODIFIER                           = ConvertAbilityRealLevelField('Nsi3')
    constant abilityreallevelfield ABILITY_RLF_ATTACK_SPEED_MODIFIER                             = ConvertAbilityRealLevelField('Nsi4')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_PER_SECOND_TDG1                            = ConvertAbilityRealLevelField('Tdg1')
    constant abilityreallevelfield ABILITY_RLF_MEDIUM_DAMAGE_RADIUS_TDG2                         = ConvertAbilityRealLevelField('Tdg2')
    constant abilityreallevelfield ABILITY_RLF_MEDIUM_DAMAGE_PER_SECOND                          = ConvertAbilityRealLevelField('Tdg3')
    constant abilityreallevelfield ABILITY_RLF_SMALL_DAMAGE_RADIUS_TDG4                          = ConvertAbilityRealLevelField('Tdg4')
    constant abilityreallevelfield ABILITY_RLF_SMALL_DAMAGE_PER_SECOND                           = ConvertAbilityRealLevelField('Tdg5')
    constant abilityreallevelfield ABILITY_RLF_AIR_TIME_SECONDS_TSP1                             = ConvertAbilityRealLevelField('Tsp1')
    constant abilityreallevelfield ABILITY_RLF_MINIMUM_HIT_INTERVAL_SECONDS                      = ConvertAbilityRealLevelField('Tsp2')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_PER_SECOND_NBF5                            = ConvertAbilityRealLevelField('Nbf5')
    constant abilityreallevelfield ABILITY_RLF_MAXIMUM_RANGE                                     = ConvertAbilityRealLevelField('Ebl1')
    constant abilityreallevelfield ABILITY_RLF_MINIMUM_RANGE                                     = ConvertAbilityRealLevelField('Ebl2')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_PER_TARGET_EFK1                            = ConvertAbilityRealLevelField('Efk1')
    constant abilityreallevelfield ABILITY_RLF_MAXIMUM_TOTAL_DAMAGE                              = ConvertAbilityRealLevelField('Efk2')
    constant abilityreallevelfield ABILITY_RLF_MAXIMUM_SPEED_ADJUSTMENT                          = ConvertAbilityRealLevelField('Efk4')
    constant abilityreallevelfield ABILITY_RLF_DECAYING_DAMAGE                                   = ConvertAbilityRealLevelField('Esh1')
    constant abilityreallevelfield ABILITY_RLF_MOVEMENT_SPEED_FACTOR_ESH2                        = ConvertAbilityRealLevelField('Esh2')
    constant abilityreallevelfield ABILITY_RLF_ATTACK_SPEED_FACTOR_ESH3                          = ConvertAbilityRealLevelField('Esh3')
    constant abilityreallevelfield ABILITY_RLF_DECAY_POWER                                       = ConvertAbilityRealLevelField('Esh4')
    constant abilityreallevelfield ABILITY_RLF_INITIAL_DAMAGE_ESH5                               = ConvertAbilityRealLevelField('Esh5')
    constant abilityreallevelfield ABILITY_RLF_MAXIMUM_LIFE_ABSORBED                             = ConvertAbilityRealLevelField('abs1')
    constant abilityreallevelfield ABILITY_RLF_MAXIMUM_MANA_ABSORBED                             = ConvertAbilityRealLevelField('abs2')
    constant abilityreallevelfield ABILITY_RLF_MOVEMENT_SPEED_INCREASE_BSK1                      = ConvertAbilityRealLevelField('bsk1')
    constant abilityreallevelfield ABILITY_RLF_ATTACK_SPEED_INCREASE_BSK2                        = ConvertAbilityRealLevelField('bsk2')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_TAKEN_INCREASE                             = ConvertAbilityRealLevelField('bsk3')
    constant abilityreallevelfield ABILITY_RLF_LIFE_PER_UNIT                                     = ConvertAbilityRealLevelField('dvm1')
    constant abilityreallevelfield ABILITY_RLF_MANA_PER_UNIT                                     = ConvertAbilityRealLevelField('dvm2')
    constant abilityreallevelfield ABILITY_RLF_LIFE_PER_BUFF                                     = ConvertAbilityRealLevelField('dvm3')
    constant abilityreallevelfield ABILITY_RLF_MANA_PER_BUFF                                     = ConvertAbilityRealLevelField('dvm4')
    constant abilityreallevelfield ABILITY_RLF_SUMMONED_UNIT_DAMAGE_DVM5                         = ConvertAbilityRealLevelField('dvm5')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_BONUS_FAK1                                 = ConvertAbilityRealLevelField('fak1')
    constant abilityreallevelfield ABILITY_RLF_MEDIUM_DAMAGE_FACTOR_FAK2                         = ConvertAbilityRealLevelField('fak2')
    constant abilityreallevelfield ABILITY_RLF_SMALL_DAMAGE_FACTOR_FAK3                          = ConvertAbilityRealLevelField('fak3')
    constant abilityreallevelfield ABILITY_RLF_FULL_DAMAGE_RADIUS_FAK4                           = ConvertAbilityRealLevelField('fak4')
    constant abilityreallevelfield ABILITY_RLF_HALF_DAMAGE_RADIUS_FAK5                           = ConvertAbilityRealLevelField('fak5')
    constant abilityreallevelfield ABILITY_RLF_EXTRA_DAMAGE_PER_SECOND                           = ConvertAbilityRealLevelField('liq1')
    constant abilityreallevelfield ABILITY_RLF_MOVEMENT_SPEED_REDUCTION_LIQ2                     = ConvertAbilityRealLevelField('liq2')
    constant abilityreallevelfield ABILITY_RLF_ATTACK_SPEED_REDUCTION_LIQ3                       = ConvertAbilityRealLevelField('liq3')
    constant abilityreallevelfield ABILITY_RLF_MAGIC_DAMAGE_FACTOR                               = ConvertAbilityRealLevelField('mim1')
    constant abilityreallevelfield ABILITY_RLF_UNIT_DAMAGE_PER_MANA_POINT                        = ConvertAbilityRealLevelField('mfl1')
    constant abilityreallevelfield ABILITY_RLF_HERO_DAMAGE_PER_MANA_POINT                        = ConvertAbilityRealLevelField('mfl2')
    constant abilityreallevelfield ABILITY_RLF_UNIT_MAXIMUM_DAMAGE                               = ConvertAbilityRealLevelField('mfl3')
    constant abilityreallevelfield ABILITY_RLF_HERO_MAXIMUM_DAMAGE                               = ConvertAbilityRealLevelField('mfl4')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_COOLDOWN                                   = ConvertAbilityRealLevelField('mfl5')
    constant abilityreallevelfield ABILITY_RLF_DISTRIBUTED_DAMAGE_FACTOR_SPL1                    = ConvertAbilityRealLevelField('spl1')
    constant abilityreallevelfield ABILITY_RLF_LIFE_REGENERATED                                  = ConvertAbilityRealLevelField('irl1')
    constant abilityreallevelfield ABILITY_RLF_MANA_REGENERATED                                  = ConvertAbilityRealLevelField('irl2')
    constant abilityreallevelfield ABILITY_RLF_MANA_LOSS_PER_UNIT_IDC1                           = ConvertAbilityRealLevelField('idc1')
    constant abilityreallevelfield ABILITY_RLF_SUMMONED_UNIT_DAMAGE_IDC2                         = ConvertAbilityRealLevelField('idc2')
    constant abilityreallevelfield ABILITY_RLF_ACTIVATION_DELAY_IMO2                             = ConvertAbilityRealLevelField('imo2')
    constant abilityreallevelfield ABILITY_RLF_LURE_INTERVAL_SECONDS                             = ConvertAbilityRealLevelField('imo3')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_BONUS_ISR1                                 = ConvertAbilityRealLevelField('isr1')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_REDUCTION_ISR2                             = ConvertAbilityRealLevelField('isr2')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_BONUS_IPV1                                 = ConvertAbilityRealLevelField('ipv1')
    constant abilityreallevelfield ABILITY_RLF_LIFE_STEAL_AMOUNT                                 = ConvertAbilityRealLevelField('ipv2')
    constant abilityreallevelfield ABILITY_RLF_LIFE_RESTORED_FACTOR                              = ConvertAbilityRealLevelField('ast1')
    constant abilityreallevelfield ABILITY_RLF_MANA_RESTORED_FACTOR                              = ConvertAbilityRealLevelField('ast2')
    constant abilityreallevelfield ABILITY_RLF_ATTACH_DELAY                                      = ConvertAbilityRealLevelField('gra1')
    constant abilityreallevelfield ABILITY_RLF_REMOVE_DELAY                                      = ConvertAbilityRealLevelField('gra2')
    constant abilityreallevelfield ABILITY_RLF_HERO_REGENERATION_DELAY                           = ConvertAbilityRealLevelField('Nsa2')
    constant abilityreallevelfield ABILITY_RLF_UNIT_REGENERATION_DELAY                           = ConvertAbilityRealLevelField('Nsa3')
    constant abilityreallevelfield ABILITY_RLF_MAGIC_DAMAGE_REDUCTION_NSA4                       = ConvertAbilityRealLevelField('Nsa4')
    constant abilityreallevelfield ABILITY_RLF_HIT_POINTS_PER_SECOND_NSA5                        = ConvertAbilityRealLevelField('Nsa5')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_TO_SUMMONED_UNITS_IXS1                     = ConvertAbilityRealLevelField('Ixs1')
    constant abilityreallevelfield ABILITY_RLF_MAGIC_DAMAGE_REDUCTION_IXS2                       = ConvertAbilityRealLevelField('Ixs2')
    constant abilityreallevelfield ABILITY_RLF_SUMMONED_UNIT_DURATION                            = ConvertAbilityRealLevelField('Npa6')
    constant abilityreallevelfield ABILITY_RLF_SHIELD_COOLDOWN_TIME                              = ConvertAbilityRealLevelField('Nse1')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_PER_SECOND_NDO1                            = ConvertAbilityRealLevelField('Ndo1')
    constant abilityreallevelfield ABILITY_RLF_SUMMONED_UNIT_DURATION_SECONDS_NDO3               = ConvertAbilityRealLevelField('Ndo3')
    constant abilityreallevelfield ABILITY_RLF_MEDIUM_DAMAGE_RADIUS_FLK1                         = ConvertAbilityRealLevelField('flk1')
    constant abilityreallevelfield ABILITY_RLF_SMALL_DAMAGE_RADIUS_FLK2                          = ConvertAbilityRealLevelField('flk2')
    constant abilityreallevelfield ABILITY_RLF_FULL_DAMAGE_AMOUNT_FLK3                           = ConvertAbilityRealLevelField('flk3')
    constant abilityreallevelfield ABILITY_RLF_MEDIUM_DAMAGE_AMOUNT                              = ConvertAbilityRealLevelField('flk4')
    constant abilityreallevelfield ABILITY_RLF_SMALL_DAMAGE_AMOUNT                               = ConvertAbilityRealLevelField('flk5')
    constant abilityreallevelfield ABILITY_RLF_MOVEMENT_SPEED_REDUCTION_PERCENT_HBN1             = ConvertAbilityRealLevelField('Hbn1')
    constant abilityreallevelfield ABILITY_RLF_ATTACK_SPEED_REDUCTION_PERCENT_HBN2               = ConvertAbilityRealLevelField('Hbn2')
    constant abilityreallevelfield ABILITY_RLF_MAX_MANA_DRAINED_UNITS                            = ConvertAbilityRealLevelField('fbk1')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_RATIO_UNITS_PERCENT                        = ConvertAbilityRealLevelField('fbk2')
    constant abilityreallevelfield ABILITY_RLF_MAX_MANA_DRAINED_HEROS                            = ConvertAbilityRealLevelField('fbk3')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_RATIO_HEROS_PERCENT                        = ConvertAbilityRealLevelField('fbk4')
    constant abilityreallevelfield ABILITY_RLF_SUMMONED_DAMAGE                                   = ConvertAbilityRealLevelField('fbk5')
    constant abilityreallevelfield ABILITY_RLF_DISTRIBUTED_DAMAGE_FACTOR_NCA1                    = ConvertAbilityRealLevelField('nca1')
    constant abilityreallevelfield ABILITY_RLF_INITIAL_DAMAGE_PXF1                               = ConvertAbilityRealLevelField('pxf1')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_PER_SECOND_PXF2                            = ConvertAbilityRealLevelField('pxf2')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_PER_SECOND_MLS1                            = ConvertAbilityRealLevelField('mls1')
    constant abilityreallevelfield ABILITY_RLF_BEAST_COLLISION_RADIUS                            = ConvertAbilityRealLevelField('Nst2')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_AMOUNT_NST3                                = ConvertAbilityRealLevelField('Nst3')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_RADIUS                                     = ConvertAbilityRealLevelField('Nst4')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_DELAY                                      = ConvertAbilityRealLevelField('Nst5')
    constant abilityreallevelfield ABILITY_RLF_FOLLOW_THROUGH_TIME                               = ConvertAbilityRealLevelField('Ncl1')
    constant abilityreallevelfield ABILITY_RLF_ART_DURATION                                      = ConvertAbilityRealLevelField('Ncl4')
    constant abilityreallevelfield ABILITY_RLF_MOVEMENT_SPEED_REDUCTION_PERCENT_NAB1             = ConvertAbilityRealLevelField('Nab1')
    constant abilityreallevelfield ABILITY_RLF_ATTACK_SPEED_REDUCTION_PERCENT_NAB2               = ConvertAbilityRealLevelField('Nab2')
    constant abilityreallevelfield ABILITY_RLF_PRIMARY_DAMAGE                                    = ConvertAbilityRealLevelField('Nab4')
    constant abilityreallevelfield ABILITY_RLF_SECONDARY_DAMAGE                                  = ConvertAbilityRealLevelField('Nab5')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_INTERVAL_NAB6                              = ConvertAbilityRealLevelField('Nab6')
    constant abilityreallevelfield ABILITY_RLF_GOLD_COST_FACTOR                                  = ConvertAbilityRealLevelField('Ntm1')
    constant abilityreallevelfield ABILITY_RLF_LUMBER_COST_FACTOR                                = ConvertAbilityRealLevelField('Ntm2')
    constant abilityreallevelfield ABILITY_RLF_MOVE_SPEED_BONUS_NEG1                             = ConvertAbilityRealLevelField('Neg1')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_BONUS_NEG2                                 = ConvertAbilityRealLevelField('Neg2')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_AMOUNT_NCS1                                = ConvertAbilityRealLevelField('Ncs1')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_INTERVAL_NCS2                              = ConvertAbilityRealLevelField('Ncs2')
    constant abilityreallevelfield ABILITY_RLF_MAX_DAMAGE_NCS4                                   = ConvertAbilityRealLevelField('Ncs4')
    constant abilityreallevelfield ABILITY_RLF_BUILDING_DAMAGE_FACTOR_NCS5                       = ConvertAbilityRealLevelField('Ncs5')
    constant abilityreallevelfield ABILITY_RLF_EFFECT_DURATION                                   = ConvertAbilityRealLevelField('Ncs6')
    constant abilityreallevelfield ABILITY_RLF_SPAWN_INTERVAL_NSY1                               = ConvertAbilityRealLevelField('Nsy1')
    constant abilityreallevelfield ABILITY_RLF_SPAWN_UNIT_DURATION                               = ConvertAbilityRealLevelField('Nsy3')
    constant abilityreallevelfield ABILITY_RLF_SPAWN_UNIT_OFFSET                                 = ConvertAbilityRealLevelField('Nsy4')
    constant abilityreallevelfield ABILITY_RLF_LEASH_RANGE_NSY5                                  = ConvertAbilityRealLevelField('Nsy5')
    constant abilityreallevelfield ABILITY_RLF_SPAWN_INTERVAL_NFY1                               = ConvertAbilityRealLevelField('Nfy1')
    constant abilityreallevelfield ABILITY_RLF_LEASH_RANGE_NFY2                                  = ConvertAbilityRealLevelField('Nfy2')
    constant abilityreallevelfield ABILITY_RLF_CHANCE_TO_DEMOLISH                                = ConvertAbilityRealLevelField('Nde1')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_MULTIPLIER_BUILDINGS                       = ConvertAbilityRealLevelField('Nde2')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_MULTIPLIER_UNITS                           = ConvertAbilityRealLevelField('Nde3')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_MULTIPLIER_HEROES                          = ConvertAbilityRealLevelField('Nde4')
    constant abilityreallevelfield ABILITY_RLF_BONUS_DAMAGE_MULTIPLIER                           = ConvertAbilityRealLevelField('Nic1')
    constant abilityreallevelfield ABILITY_RLF_DEATH_DAMAGE_FULL_AMOUNT                          = ConvertAbilityRealLevelField('Nic2')
    constant abilityreallevelfield ABILITY_RLF_DEATH_DAMAGE_FULL_AREA                            = ConvertAbilityRealLevelField('Nic3')
    constant abilityreallevelfield ABILITY_RLF_DEATH_DAMAGE_HALF_AMOUNT                          = ConvertAbilityRealLevelField('Nic4')
    constant abilityreallevelfield ABILITY_RLF_DEATH_DAMAGE_HALF_AREA                            = ConvertAbilityRealLevelField('Nic5')
    constant abilityreallevelfield ABILITY_RLF_DEATH_DAMAGE_DELAY                                = ConvertAbilityRealLevelField('Nic6')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_AMOUNT_NSO1                                = ConvertAbilityRealLevelField('Nso1')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_PERIOD                                     = ConvertAbilityRealLevelField('Nso2')
    constant abilityreallevelfield ABILITY_RLF_DAMAGE_PENALTY                                    = ConvertAbilityRealLevelField('Nso3')
    constant abilityreallevelfield ABILITY_RLF_MOVEMENT_SPEED_REDUCTION_PERCENT_NSO4             = ConvertAbilityRealLevelField('Nso4')
    constant abilityreallevelfield ABILITY_RLF_ATTACK_SPEED_REDUCTION_PERCENT_NSO5               = ConvertAbilityRealLevelField('Nso5')
    constant abilityreallevelfield ABILITY_RLF_SPLIT_DELAY                                       = ConvertAbilityRealLevelField('Nlm2')
    constant abilityreallevelfield ABILITY_RLF_MAX_HITPOINT_FACTOR                               = ConvertAbilityRealLevelField('Nlm4')
    constant abilityreallevelfield ABILITY_RLF_LIFE_DURATION_SPLIT_BONUS                         = ConvertAbilityRealLevelField('Nlm5')
    constant abilityreallevelfield ABILITY_RLF_WAVE_INTERVAL                                     = ConvertAbilityRealLevelField('Nvc3')
    constant abilityreallevelfield ABILITY_RLF_BUILDING_DAMAGE_FACTOR_NVC4                       = ConvertAbilityRealLevelField('Nvc4')
    constant abilityreallevelfield ABILITY_RLF_FULL_DAMAGE_AMOUNT_NVC5                           = ConvertAbilityRealLevelField('Nvc5')
    constant abilityreallevelfield ABILITY_RLF_HALF_DAMAGE_FACTOR                                = ConvertAbilityRealLevelField('Nvc6')
    constant abilityreallevelfield ABILITY_RLF_INTERVAL_BETWEEN_PULSES                           = ConvertAbilityRealLevelField('Tau5')

    constant abilitybooleanlevelfield ABILITY_BLF_PERCENT_BONUS_HAB2            = ConvertAbilityBooleanLevelField('Hab2')
    constant abilitybooleanlevelfield ABILITY_BLF_USE_TELEPORT_CLUSTERING_HMT3  = ConvertAbilityBooleanLevelField('Hmt3')
    constant abilitybooleanlevelfield ABILITY_BLF_NEVER_MISS_OCR5               = ConvertAbilityBooleanLevelField('Ocr5')
    constant abilitybooleanlevelfield ABILITY_BLF_EXCLUDE_ITEM_DAMAGE           = ConvertAbilityBooleanLevelField('Ocr6')
    constant abilitybooleanlevelfield ABILITY_BLF_BACKSTAB_DAMAGE               = ConvertAbilityBooleanLevelField('Owk4')
    constant abilitybooleanlevelfield ABILITY_BLF_INHERIT_UPGRADES_UAN3         = ConvertAbilityBooleanLevelField('Uan3')
    constant abilitybooleanlevelfield ABILITY_BLF_MANA_CONVERSION_AS_PERCENT    = ConvertAbilityBooleanLevelField('Udp3')
    constant abilitybooleanlevelfield ABILITY_BLF_LIFE_CONVERSION_AS_PERCENT    = ConvertAbilityBooleanLevelField('Udp4')
    constant abilitybooleanlevelfield ABILITY_BLF_LEAVE_TARGET_ALIVE            = ConvertAbilityBooleanLevelField('Udp5')
    constant abilitybooleanlevelfield ABILITY_BLF_PERCENT_BONUS_UAU3            = ConvertAbilityBooleanLevelField('Uau3')
    constant abilitybooleanlevelfield ABILITY_BLF_DAMAGE_IS_PERCENT_RECEIVED    = ConvertAbilityBooleanLevelField('Eah2')
    constant abilitybooleanlevelfield ABILITY_BLF_MELEE_BONUS                   = ConvertAbilityBooleanLevelField('Ear2')
    constant abilitybooleanlevelfield ABILITY_BLF_RANGED_BONUS                  = ConvertAbilityBooleanLevelField('Ear3')
    constant abilitybooleanlevelfield ABILITY_BLF_FLAT_BONUS                    = ConvertAbilityBooleanLevelField('Ear4')
    constant abilitybooleanlevelfield ABILITY_BLF_NEVER_MISS_HBH5               = ConvertAbilityBooleanLevelField('Hbh5')
    constant abilitybooleanlevelfield ABILITY_BLF_PERCENT_BONUS_HAD2            = ConvertAbilityBooleanLevelField('Had2')
    constant abilitybooleanlevelfield ABILITY_BLF_CAN_DEACTIVATE                = ConvertAbilityBooleanLevelField('Hds1')
    constant abilitybooleanlevelfield ABILITY_BLF_RAISED_UNITS_ARE_INVULNERABLE = ConvertAbilityBooleanLevelField('Hre2')
    constant abilitybooleanlevelfield ABILITY_BLF_PERCENTAGE_OAR2               = ConvertAbilityBooleanLevelField('Oar2')
    constant abilitybooleanlevelfield ABILITY_BLF_SUMMON_BUSY_UNITS             = ConvertAbilityBooleanLevelField('Btl2')
    constant abilitybooleanlevelfield ABILITY_BLF_CREATES_BLIGHT                = ConvertAbilityBooleanLevelField('Bli2')
    constant abilitybooleanlevelfield ABILITY_BLF_EXPLODES_ON_DEATH             = ConvertAbilityBooleanLevelField('Sds6')
    constant abilitybooleanlevelfield ABILITY_BLF_ALWAYS_AUTOCAST_FAE2          = ConvertAbilityBooleanLevelField('Fae2')
    constant abilitybooleanlevelfield ABILITY_BLF_REGENERATE_ONLY_AT_NIGHT      = ConvertAbilityBooleanLevelField('Mbt5')
    constant abilitybooleanlevelfield ABILITY_BLF_SHOW_SELECT_UNIT_BUTTON       = ConvertAbilityBooleanLevelField('Neu3')
    constant abilitybooleanlevelfield ABILITY_BLF_SHOW_UNIT_INDICATOR           = ConvertAbilityBooleanLevelField('Neu4')
    constant abilitybooleanlevelfield ABILITY_BLF_CHARGE_OWNING_PLAYER          = ConvertAbilityBooleanLevelField('Ans6')
    constant abilitybooleanlevelfield ABILITY_BLF_PERCENTAGE_ARM2               = ConvertAbilityBooleanLevelField('Arm2')
    constant abilitybooleanlevelfield ABILITY_BLF_TARGET_IS_INVULNERABLE        = ConvertAbilityBooleanLevelField('Pos3')
    constant abilitybooleanlevelfield ABILITY_BLF_TARGET_IS_MAGIC_IMMUNE        = ConvertAbilityBooleanLevelField('Pos4')
    constant abilitybooleanlevelfield ABILITY_BLF_KILL_ON_CASTER_DEATH          = ConvertAbilityBooleanLevelField('Ucb6')
    constant abilitybooleanlevelfield ABILITY_BLF_NO_TARGET_REQUIRED_REJ4       = ConvertAbilityBooleanLevelField('Rej4')
    constant abilitybooleanlevelfield ABILITY_BLF_ACCEPTS_GOLD                  = ConvertAbilityBooleanLevelField('Rtn1')
    constant abilitybooleanlevelfield ABILITY_BLF_ACCEPTS_LUMBER                = ConvertAbilityBooleanLevelField('Rtn2')
    constant abilitybooleanlevelfield ABILITY_BLF_PREFER_HOSTILES_ROA5          = ConvertAbilityBooleanLevelField('Roa5')
    constant abilitybooleanlevelfield ABILITY_BLF_PREFER_FRIENDLIES_ROA6        = ConvertAbilityBooleanLevelField('Roa6')
    constant abilitybooleanlevelfield ABILITY_BLF_ROOTED_TURNING                = ConvertAbilityBooleanLevelField('Roo3')
    constant abilitybooleanlevelfield ABILITY_BLF_ALWAYS_AUTOCAST_SLO3          = ConvertAbilityBooleanLevelField('Slo3')
    constant abilitybooleanlevelfield ABILITY_BLF_HIDE_BUTTON                   = ConvertAbilityBooleanLevelField('Ihid')
    constant abilitybooleanlevelfield ABILITY_BLF_USE_TELEPORT_CLUSTERING_ITP2  = ConvertAbilityBooleanLevelField('Itp2')
    constant abilitybooleanlevelfield ABILITY_BLF_IMMUNE_TO_MORPH_EFFECTS       = ConvertAbilityBooleanLevelField('Eth1')
    constant abilitybooleanlevelfield ABILITY_BLF_DOES_NOT_BLOCK_BUILDINGS      = ConvertAbilityBooleanLevelField('Eth2')
    constant abilitybooleanlevelfield ABILITY_BLF_AUTO_ACQUIRE_ATTACK_TARGETS   = ConvertAbilityBooleanLevelField('Gho1')
    constant abilitybooleanlevelfield ABILITY_BLF_IMMUNE_TO_MORPH_EFFECTS_GHO2  = ConvertAbilityBooleanLevelField('Gho2')
    constant abilitybooleanlevelfield ABILITY_BLF_DO_NOT_BLOCK_BUILDINGS        = ConvertAbilityBooleanLevelField('Gho3')
    constant abilitybooleanlevelfield ABILITY_BLF_INCLUDE_RANGED_DAMAGE         = ConvertAbilityBooleanLevelField('Ssk4')
    constant abilitybooleanlevelfield ABILITY_BLF_INCLUDE_MELEE_DAMAGE          = ConvertAbilityBooleanLevelField('Ssk5')
    constant abilitybooleanlevelfield ABILITY_BLF_MOVE_TO_PARTNER               = ConvertAbilityBooleanLevelField('coa2')
    constant abilitybooleanlevelfield ABILITY_BLF_CAN_BE_DISPELLED              = ConvertAbilityBooleanLevelField('cyc1')
    constant abilitybooleanlevelfield ABILITY_BLF_IGNORE_FRIENDLY_BUFFS         = ConvertAbilityBooleanLevelField('dvm6')
    constant abilitybooleanlevelfield ABILITY_BLF_DROP_ITEMS_ON_DEATH           = ConvertAbilityBooleanLevelField('inv2')
    constant abilitybooleanlevelfield ABILITY_BLF_CAN_USE_ITEMS                 = ConvertAbilityBooleanLevelField('inv3')
    constant abilitybooleanlevelfield ABILITY_BLF_CAN_GET_ITEMS                 = ConvertAbilityBooleanLevelField('inv4')
    constant abilitybooleanlevelfield ABILITY_BLF_CAN_DROP_ITEMS                = ConvertAbilityBooleanLevelField('inv5')
    constant abilitybooleanlevelfield ABILITY_BLF_REPAIRS_ALLOWED               = ConvertAbilityBooleanLevelField('liq4')
    constant abilitybooleanlevelfield ABILITY_BLF_CASTER_ONLY_SPLASH            = ConvertAbilityBooleanLevelField('mfl6')
    constant abilitybooleanlevelfield ABILITY_BLF_NO_TARGET_REQUIRED_IRL4       = ConvertAbilityBooleanLevelField('irl4')
    constant abilitybooleanlevelfield ABILITY_BLF_DISPEL_ON_ATTACK              = ConvertAbilityBooleanLevelField('irl5')
    constant abilitybooleanlevelfield ABILITY_BLF_AMOUNT_IS_RAW_VALUE           = ConvertAbilityBooleanLevelField('ipv3')
    constant abilitybooleanlevelfield ABILITY_BLF_SHARED_SPELL_COOLDOWN         = ConvertAbilityBooleanLevelField('spb2')
    constant abilitybooleanlevelfield ABILITY_BLF_SLEEP_ONCE                    = ConvertAbilityBooleanLevelField('sla1')
    constant abilitybooleanlevelfield ABILITY_BLF_ALLOW_ON_ANY_PLAYER_SLOT      = ConvertAbilityBooleanLevelField('sla2')
    constant abilitybooleanlevelfield ABILITY_BLF_DISABLE_OTHER_ABILITIES       = ConvertAbilityBooleanLevelField('Ncl5')
    constant abilitybooleanlevelfield ABILITY_BLF_ALLOW_BOUNTY                  = ConvertAbilityBooleanLevelField('Ntm4')

    constant abilitystringlevelfield ABILITY_SLF_ICON_NORMAL                    = ConvertAbilityStringLevelField('aart')
    constant abilitystringlevelfield ABILITY_SLF_CASTER                         = ConvertAbilityStringLevelField('acat')
    constant abilitystringlevelfield ABILITY_SLF_TARGET                         = ConvertAbilityStringLevelField('atat')
    constant abilitystringlevelfield ABILITY_SLF_SPECIAL                        = ConvertAbilityStringLevelField('asat')
    constant abilitystringlevelfield ABILITY_SLF_EFFECT                         = ConvertAbilityStringLevelField('aeat')
    constant abilitystringlevelfield ABILITY_SLF_AREA_EFFECT                    = ConvertAbilityStringLevelField('aaea')
    constant abilitystringlevelfield ABILITY_SLF_LIGHTNING_EFFECTS              = ConvertAbilityStringLevelField('alig')
    constant abilitystringlevelfield ABILITY_SLF_MISSILE_ART                    = ConvertAbilityStringLevelField('amat')
    constant abilitystringlevelfield ABILITY_SLF_TOOLTIP_LEARN                  = ConvertAbilityStringLevelField('aret')
    constant abilitystringlevelfield ABILITY_SLF_TOOLTIP_LEARN_EXTENDED         = ConvertAbilityStringLevelField('arut')
    constant abilitystringlevelfield ABILITY_SLF_TOOLTIP_NORMAL                 = ConvertAbilityStringLevelField('atp1')
    constant abilitystringlevelfield ABILITY_SLF_TOOLTIP_TURN_OFF               = ConvertAbilityStringLevelField('aut1')
    constant abilitystringlevelfield ABILITY_SLF_TOOLTIP_NORMAL_EXTENDED        = ConvertAbilityStringLevelField('aub1')
    constant abilitystringlevelfield ABILITY_SLF_TOOLTIP_TURN_OFF_EXTENDED      = ConvertAbilityStringLevelField('auu1')
    constant abilitystringlevelfield ABILITY_SLF_NORMAL_FORM_UNIT_EME1          = ConvertAbilityStringLevelField('Eme1')
    constant abilitystringlevelfield ABILITY_SLF_SPAWNED_UNITS                  = ConvertAbilityStringLevelField('Ndp1')
    constant abilitystringlevelfield ABILITY_SLF_ABILITY_FOR_UNIT_CREATION      = ConvertAbilityStringLevelField('Nrc1')
    constant abilitystringlevelfield ABILITY_SLF_NORMAL_FORM_UNIT_MIL1          = ConvertAbilityStringLevelField('Mil1')
    constant abilitystringlevelfield ABILITY_SLF_ALTERNATE_FORM_UNIT_MIL2       = ConvertAbilityStringLevelField('Mil2')
    constant abilitystringlevelfield ABILITY_SLF_BASE_ORDER_ID_ANS5             = ConvertAbilityStringLevelField('Ans5')
    constant abilitystringlevelfield ABILITY_SLF_MORPH_UNITS_GROUND             = ConvertAbilityStringLevelField('Ply2')
    constant abilitystringlevelfield ABILITY_SLF_MORPH_UNITS_AIR                = ConvertAbilityStringLevelField('Ply3')
    constant abilitystringlevelfield ABILITY_SLF_MORPH_UNITS_AMPHIBIOUS         = ConvertAbilityStringLevelField('Ply4')
    constant abilitystringlevelfield ABILITY_SLF_MORPH_UNITS_WATER              = ConvertAbilityStringLevelField('Ply5')
    constant abilitystringlevelfield ABILITY_SLF_UNIT_TYPE_ONE                  = ConvertAbilityStringLevelField('Rai3')
    constant abilitystringlevelfield ABILITY_SLF_UNIT_TYPE_TWO                  = ConvertAbilityStringLevelField('Rai4')
    constant abilitystringlevelfield ABILITY_SLF_UNIT_TYPE_SOD2                 = ConvertAbilityStringLevelField('Sod2')
    constant abilitystringlevelfield ABILITY_SLF_SUMMON_1_UNIT_TYPE             = ConvertAbilityStringLevelField('Ist1')
    constant abilitystringlevelfield ABILITY_SLF_SUMMON_2_UNIT_TYPE             = ConvertAbilityStringLevelField('Ist2')
    constant abilitystringlevelfield ABILITY_SLF_RACE_TO_CONVERT                = ConvertAbilityStringLevelField('Ndc1')
    constant abilitystringlevelfield ABILITY_SLF_PARTNER_UNIT_TYPE              = ConvertAbilityStringLevelField('coa1')
    constant abilitystringlevelfield ABILITY_SLF_PARTNER_UNIT_TYPE_ONE          = ConvertAbilityStringLevelField('dcp1')
    constant abilitystringlevelfield ABILITY_SLF_PARTNER_UNIT_TYPE_TWO          = ConvertAbilityStringLevelField('dcp2')
    constant abilitystringlevelfield ABILITY_SLF_REQUIRED_UNIT_TYPE             = ConvertAbilityStringLevelField('tpi1')
    constant abilitystringlevelfield ABILITY_SLF_CONVERTED_UNIT_TYPE            = ConvertAbilityStringLevelField('tpi2')
    constant abilitystringlevelfield ABILITY_SLF_SPELL_LIST                     = ConvertAbilityStringLevelField('spb1')
    constant abilitystringlevelfield ABILITY_SLF_BASE_ORDER_ID_SPB5             = ConvertAbilityStringLevelField('spb5')
    constant abilitystringlevelfield ABILITY_SLF_BASE_ORDER_ID_NCL6             = ConvertAbilityStringLevelField('Ncl6')
    constant abilitystringlevelfield ABILITY_SLF_ABILITY_UPGRADE_1              = ConvertAbilityStringLevelField('Neg3')
    constant abilitystringlevelfield ABILITY_SLF_ABILITY_UPGRADE_2              = ConvertAbilityStringLevelField('Neg4')
    constant abilitystringlevelfield ABILITY_SLF_ABILITY_UPGRADE_3              = ConvertAbilityStringLevelField('Neg5')
    constant abilitystringlevelfield ABILITY_SLF_ABILITY_UPGRADE_4              = ConvertAbilityStringLevelField('Neg6')
    constant abilitystringlevelfield ABILITY_SLF_SPAWN_UNIT_ID_NSY2             = ConvertAbilityStringLevelField('Nsy2')

    // Item
    constant itemintegerfield ITEM_IF_LEVEL                 = ConvertItemIntegerField('ilev')
    constant itemintegerfield ITEM_IF_NUMBER_OF_CHARGES     = ConvertItemIntegerField('iuse')
    constant itemintegerfield ITEM_IF_COOLDOWN_GROUP        = ConvertItemIntegerField('icid')
    constant itemintegerfield ITEM_IF_MAX_HIT_POINTS        = ConvertItemIntegerField('ihtp')
    constant itemintegerfield ITEM_IF_HIT_POINTS            = ConvertItemIntegerField('ihpc')
    constant itemintegerfield ITEM_IF_PRIORITY              = ConvertItemIntegerField('ipri')
    constant itemintegerfield ITEM_IF_ARMOR_TYPE            = ConvertItemIntegerField('iarm')
    constant itemintegerfield ITEM_IF_TINTING_COLOR_RED     = ConvertItemIntegerField('iclr')
    constant itemintegerfield ITEM_IF_TINTING_COLOR_GREEN   = ConvertItemIntegerField('iclg')
    constant itemintegerfield ITEM_IF_TINTING_COLOR_BLUE    = ConvertItemIntegerField('iclb')
    constant itemintegerfield ITEM_IF_TINTING_COLOR_ALPHA   = ConvertItemIntegerField('ical')

    constant itemrealfield ITEM_RF_SCALING_VALUE            = ConvertItemRealField('isca')

    constant itembooleanfield ITEM_BF_DROPPED_WHEN_CARRIER_DIES         = ConvertItemBooleanField('idrp')
    constant itembooleanfield ITEM_BF_CAN_BE_DROPPED                    = ConvertItemBooleanField('idro')
    constant itembooleanfield ITEM_BF_PERISHABLE                        = ConvertItemBooleanField('iper')
    constant itembooleanfield ITEM_BF_INCLUDE_AS_RANDOM_CHOICE          = ConvertItemBooleanField('iprn')
    constant itembooleanfield ITEM_BF_USE_AUTOMATICALLY_WHEN_ACQUIRED   = ConvertItemBooleanField('ipow')
    constant itembooleanfield ITEM_BF_CAN_BE_SOLD_TO_MERCHANTS          = ConvertItemBooleanField('ipaw')
    constant itembooleanfield ITEM_BF_ACTIVELY_USED                     = ConvertItemBooleanField('iusa')

    constant itemstringfield ITEM_SF_MODEL_USED                         = ConvertItemStringField('ifil')

    // Unit
    constant unitintegerfield UNIT_IF_DEFENSE_TYPE                          = ConvertUnitIntegerField('udty')
    constant unitintegerfield UNIT_IF_ARMOR_TYPE                            = ConvertUnitIntegerField('uarm')
    constant unitintegerfield UNIT_IF_LOOPING_FADE_IN_RATE                  = ConvertUnitIntegerField('ulfi')
    constant unitintegerfield UNIT_IF_LOOPING_FADE_OUT_RATE                 = ConvertUnitIntegerField('ulfo')
    constant unitintegerfield UNIT_IF_AGILITY                               = ConvertUnitIntegerField('uagc')
    constant unitintegerfield UNIT_IF_INTELLIGENCE                          = ConvertUnitIntegerField('uinc')
    constant unitintegerfield UNIT_IF_STRENGTH                              = ConvertUnitIntegerField('ustc')
    constant unitintegerfield UNIT_IF_AGILITY_PERMANENT                     = ConvertUnitIntegerField('uagm')
    constant unitintegerfield UNIT_IF_INTELLIGENCE_PERMANENT                = ConvertUnitIntegerField('uinm')
    constant unitintegerfield UNIT_IF_STRENGTH_PERMANENT                    = ConvertUnitIntegerField('ustm')
    constant unitintegerfield UNIT_IF_AGILITY_WITH_BONUS                    = ConvertUnitIntegerField('uagb')
    constant unitintegerfield UNIT_IF_INTELLIGENCE_WITH_BONUS               = ConvertUnitIntegerField('uinb')
    constant unitintegerfield UNIT_IF_STRENGTH_WITH_BONUS                   = ConvertUnitIntegerField('ustb')
    constant unitintegerfield UNIT_IF_GOLD_BOUNTY_AWARDED_NUMBER_OF_DICE    = ConvertUnitIntegerField('ubdi')
    constant unitintegerfield UNIT_IF_GOLD_BOUNTY_AWARDED_BASE              = ConvertUnitIntegerField('ubba')
    constant unitintegerfield UNIT_IF_GOLD_BOUNTY_AWARDED_SIDES_PER_DIE     = ConvertUnitIntegerField('ubsi')
    constant unitintegerfield UNIT_IF_LUMBER_BOUNTY_AWARDED_NUMBER_OF_DICE  = ConvertUnitIntegerField('ulbd')
    constant unitintegerfield UNIT_IF_LUMBER_BOUNTY_AWARDED_BASE            = ConvertUnitIntegerField('ulba')
    constant unitintegerfield UNIT_IF_LUMBER_BOUNTY_AWARDED_SIDES_PER_DIE   = ConvertUnitIntegerField('ulbs')
    constant unitintegerfield UNIT_IF_LEVEL                                 = ConvertUnitIntegerField('ulev')
    constant unitintegerfield UNIT_IF_FORMATION_RANK                        = ConvertUnitIntegerField('ufor')
    constant unitintegerfield UNIT_IF_ORIENTATION_INTERPOLATION             = ConvertUnitIntegerField('uori')
    constant unitintegerfield UNIT_IF_ELEVATION_SAMPLE_POINTS               = ConvertUnitIntegerField('uept')
    constant unitintegerfield UNIT_IF_TINTING_COLOR_RED                     = ConvertUnitIntegerField('uclr')
    constant unitintegerfield UNIT_IF_TINTING_COLOR_GREEN                   = ConvertUnitIntegerField('uclg')
    constant unitintegerfield UNIT_IF_TINTING_COLOR_BLUE                    = ConvertUnitIntegerField('uclb')
    constant unitintegerfield UNIT_IF_TINTING_COLOR_ALPHA                   = ConvertUnitIntegerField('ucal')
    constant unitintegerfield UNIT_IF_MOVE_TYPE                             = ConvertUnitIntegerField('umvt')
    constant unitintegerfield UNIT_IF_TARGETED_AS                           = ConvertUnitIntegerField('utar')
    constant unitintegerfield UNIT_IF_UNIT_CLASSIFICATION                   = ConvertUnitIntegerField('utyp')
    constant unitintegerfield UNIT_IF_HIT_POINTS_REGENERATION_TYPE          = ConvertUnitIntegerField('uhrt')
    constant unitintegerfield UNIT_IF_PLACEMENT_PREVENTED_BY                = ConvertUnitIntegerField('upar')
    constant unitintegerfield UNIT_IF_PRIMARY_ATTRIBUTE                     = ConvertUnitIntegerField('upra')

    constant unitrealfield UNIT_RF_STRENGTH_PER_LEVEL                       = ConvertUnitRealField('ustp')
    constant unitrealfield UNIT_RF_AGILITY_PER_LEVEL                        = ConvertUnitRealField('uagp')
    constant unitrealfield UNIT_RF_INTELLIGENCE_PER_LEVEL                   = ConvertUnitRealField('uinp')
    constant unitrealfield UNIT_RF_HIT_POINTS_REGENERATION_RATE             = ConvertUnitRealField('uhpr')
    constant unitrealfield UNIT_RF_MANA_REGENERATION                        = ConvertUnitRealField('umpr')
    constant unitrealfield UNIT_RF_DEATH_TIME                               = ConvertUnitRealField('udtm')
    constant unitrealfield UNIT_RF_FLY_HEIGHT                               = ConvertUnitRealField('ufyh')
    constant unitrealfield UNIT_RF_TURN_RATE                                = ConvertUnitRealField('umvr')
    constant unitrealfield UNIT_RF_ELEVATION_SAMPLE_RADIUS                  = ConvertUnitRealField('uerd')
    constant unitrealfield UNIT_RF_FOG_OF_WAR_SAMPLE_RADIUS                 = ConvertUnitRealField('ufrd')
    constant unitrealfield UNIT_RF_MAXIMUM_PITCH_ANGLE_DEGREES              = ConvertUnitRealField('umxp')
    constant unitrealfield UNIT_RF_MAXIMUM_ROLL_ANGLE_DEGREES               = ConvertUnitRealField('umxr')
    constant unitrealfield UNIT_RF_SCALING_VALUE                            = ConvertUnitRealField('usca')
    constant unitrealfield UNIT_RF_ANIMATION_RUN_SPEED                      = ConvertUnitRealField('urun')
    constant unitrealfield UNIT_RF_SELECTION_SCALE                          = ConvertUnitRealField('ussc')
    constant unitrealfield UNIT_RF_SELECTION_CIRCLE_HEIGHT                  = ConvertUnitRealField('uslz')
    constant unitrealfield UNIT_RF_SHADOW_IMAGE_HEIGHT                      = ConvertUnitRealField('ushh')
    constant unitrealfield UNIT_RF_SHADOW_IMAGE_WIDTH                       = ConvertUnitRealField('ushw')
    constant unitrealfield UNIT_RF_SHADOW_IMAGE_CENTER_X                    = ConvertUnitRealField('ushx')
    constant unitrealfield UNIT_RF_SHADOW_IMAGE_CENTER_Y                    = ConvertUnitRealField('ushy')
    constant unitrealfield UNIT_RF_ANIMATION_WALK_SPEED                     = ConvertUnitRealField('uwal')
    constant unitrealfield UNIT_RF_DEFENSE                                  = ConvertUnitRealField('udfc')
    constant unitrealfield UNIT_RF_SIGHT_RADIUS                             = ConvertUnitRealField('usir')
    constant unitrealfield UNIT_RF_PRIORITY                                 = ConvertUnitRealField('upri')
    constant unitrealfield UNIT_RF_SPEED                                    = ConvertUnitRealField('umvc')
    constant unitrealfield UNIT_RF_OCCLUDER_HEIGHT                          = ConvertUnitRealField('uocc')
    constant unitrealfield UNIT_RF_HP                                       = ConvertUnitRealField('uhpc')
    constant unitrealfield UNIT_RF_MANA                                     = ConvertUnitRealField('umpc')
    constant unitrealfield UNIT_RF_ACQUISITION_RANGE                        = ConvertUnitRealField('uacq')
    constant unitrealfield UNIT_RF_CAST_BACK_SWING                          = ConvertUnitRealField('ucbs')
    constant unitrealfield UNIT_RF_CAST_POINT                               = ConvertUnitRealField('ucpt')
    constant unitrealfield UNIT_RF_MINIMUM_ATTACK_RANGE                     = ConvertUnitRealField('uamn')

    constant unitbooleanfield UNIT_BF_RAISABLE                              = ConvertUnitBooleanField('urai')
    constant unitbooleanfield UNIT_BF_DECAYABLE                             = ConvertUnitBooleanField('udec')
    constant unitbooleanfield UNIT_BF_IS_A_BUILDING                         = ConvertUnitBooleanField('ubdg')
    constant unitbooleanfield UNIT_BF_USE_EXTENDED_LINE_OF_SIGHT            = ConvertUnitBooleanField('ulos')
    constant unitbooleanfield UNIT_BF_NEUTRAL_BUILDING_SHOWS_MINIMAP_ICON   = ConvertUnitBooleanField('unbm')
    constant unitbooleanfield UNIT_BF_HERO_HIDE_HERO_INTERFACE_ICON         = ConvertUnitBooleanField('uhhb')
    constant unitbooleanfield UNIT_BF_HERO_HIDE_HERO_MINIMAP_DISPLAY        = ConvertUnitBooleanField('uhhm')
    constant unitbooleanfield UNIT_BF_HERO_HIDE_HERO_DEATH_MESSAGE          = ConvertUnitBooleanField('uhhd')
    constant unitbooleanfield UNIT_BF_HIDE_MINIMAP_DISPLAY                  = ConvertUnitBooleanField('uhom')
    constant unitbooleanfield UNIT_BF_SCALE_PROJECTILES                     = ConvertUnitBooleanField('uscb')
    constant unitbooleanfield UNIT_BF_SELECTION_CIRCLE_ON_WATER             = ConvertUnitBooleanField('usew')
    constant unitbooleanfield UNIT_BF_HAS_WATER_SHADOW                      = ConvertUnitBooleanField('ushr')

    constant unitstringfield UNIT_SF_NAME                   = ConvertUnitStringField('unam')
    constant unitstringfield UNIT_SF_PROPER_NAMES           = ConvertUnitStringField('upro')
    constant unitstringfield UNIT_SF_GROUND_TEXTURE         = ConvertUnitStringField('uubs')
    constant unitstringfield UNIT_SF_SHADOW_IMAGE_UNIT      = ConvertUnitStringField('ushu')

    // Unit Weapon
    constant unitweaponintegerfield UNIT_WEAPON_IF_ATTACK_DAMAGE_NUMBER_OF_DICE     = ConvertUnitWeaponIntegerField('ua1d')
    constant unitweaponintegerfield UNIT_WEAPON_IF_ATTACK_DAMAGE_BASE               = ConvertUnitWeaponIntegerField('ua1b')
    constant unitweaponintegerfield UNIT_WEAPON_IF_ATTACK_DAMAGE_SIDES_PER_DIE      = ConvertUnitWeaponIntegerField('ua1s')
    constant unitweaponintegerfield UNIT_WEAPON_IF_ATTACK_MAXIMUM_NUMBER_OF_TARGETS = ConvertUnitWeaponIntegerField('utc1')
    constant unitweaponintegerfield UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE               = ConvertUnitWeaponIntegerField('ua1t')
    constant unitweaponintegerfield UNIT_WEAPON_IF_ATTACK_WEAPON_SOUND              = ConvertUnitWeaponIntegerField('ucs1')
    constant unitweaponintegerfield UNIT_WEAPON_IF_ATTACK_AREA_OF_EFFECT_TARGETS    = ConvertUnitWeaponIntegerField('ua1p')
    constant unitweaponintegerfield UNIT_WEAPON_IF_ATTACK_TARGETS_ALLOWED           = ConvertUnitWeaponIntegerField('ua1g')

    constant unitweaponrealfield UNIT_WEAPON_RF_ATTACK_BACKSWING_POINT              = ConvertUnitWeaponRealField('ubs1')
    constant unitweaponrealfield UNIT_WEAPON_RF_ATTACK_DAMAGE_POINT                 = ConvertUnitWeaponRealField('udp1')
    constant unitweaponrealfield UNIT_WEAPON_RF_ATTACK_BASE_COOLDOWN                = ConvertUnitWeaponRealField('ua1c')
    constant unitweaponrealfield UNIT_WEAPON_RF_ATTACK_DAMAGE_LOSS_FACTOR           = ConvertUnitWeaponRealField('udl1')
    constant unitweaponrealfield UNIT_WEAPON_RF_ATTACK_DAMAGE_FACTOR_MEDIUM         = ConvertUnitWeaponRealField('uhd1')
    constant unitweaponrealfield UNIT_WEAPON_RF_ATTACK_DAMAGE_FACTOR_SMALL          = ConvertUnitWeaponRealField('uqd1')
    constant unitweaponrealfield UNIT_WEAPON_RF_ATTACK_DAMAGE_SPILL_DISTANCE        = ConvertUnitWeaponRealField('usd1')
    constant unitweaponrealfield UNIT_WEAPON_RF_ATTACK_DAMAGE_SPILL_RADIUS          = ConvertUnitWeaponRealField('usr1')
    constant unitweaponrealfield UNIT_WEAPON_RF_ATTACK_PROJECTILE_SPEED             = ConvertUnitWeaponRealField('ua1z')
    constant unitweaponrealfield UNIT_WEAPON_RF_ATTACK_PROJECTILE_ARC               = ConvertUnitWeaponRealField('uma1')
    constant unitweaponrealfield UNIT_WEAPON_RF_ATTACK_AREA_OF_EFFECT_FULL_DAMAGE   = ConvertUnitWeaponRealField('ua1f')
    constant unitweaponrealfield UNIT_WEAPON_RF_ATTACK_AREA_OF_EFFECT_MEDIUM_DAMAGE = ConvertUnitWeaponRealField('ua1h')
    constant unitweaponrealfield UNIT_WEAPON_RF_ATTACK_AREA_OF_EFFECT_SMALL_DAMAGE  = ConvertUnitWeaponRealField('ua1q')
    constant unitweaponrealfield UNIT_WEAPON_RF_ATTACK_RANGE                        = ConvertUnitWeaponRealField('ua1r')

    constant unitweaponbooleanfield UNIT_WEAPON_BF_ATTACK_SHOW_UI                   = ConvertUnitWeaponBooleanField('uwu1')
    constant unitweaponbooleanfield UNIT_WEAPON_BF_ATTACKS_ENABLED                  = ConvertUnitWeaponBooleanField('uaen')
    constant unitweaponbooleanfield UNIT_WEAPON_BF_ATTACK_PROJECTILE_HOMING_ENABLED = ConvertUnitWeaponBooleanField('umh1')

    constant unitweaponstringfield UNIT_WEAPON_SF_ATTACK_PROJECTILE_ART             = ConvertUnitWeaponStringField('ua1m')

    // Move Type
    constant movetype       MOVE_TYPE_UNKNOWN               = ConvertMoveType(0)
    constant movetype       MOVE_TYPE_FOOT                  = ConvertMoveType(1)
    constant movetype       MOVE_TYPE_FLY                   = ConvertMoveType(2)
    constant movetype       MOVE_TYPE_HORSE                 = ConvertMoveType(4)
    constant movetype       MOVE_TYPE_HOVER                 = ConvertMoveType(8)
    constant movetype       MOVE_TYPE_FLOAT                 = ConvertMoveType(16)
    constant movetype       MOVE_TYPE_AMPHIBIOUS            = ConvertMoveType(32)
    constant movetype       MOVE_TYPE_UNBUILDABLE           = ConvertMoveType(64)

    // Target Flag
    constant targetflag     TARGET_FLAG_NONE                = ConvertTargetFlag(1)
    constant targetflag     TARGET_FLAG_GROUND              = ConvertTargetFlag(2)
    constant targetflag     TARGET_FLAG_AIR                 = ConvertTargetFlag(4)
    constant targetflag     TARGET_FLAG_STRUCTURE           = ConvertTargetFlag(8)
    constant targetflag     TARGET_FLAG_WARD                = ConvertTargetFlag(16)
    constant targetflag     TARGET_FLAG_ITEM                = ConvertTargetFlag(32)
    constant targetflag     TARGET_FLAG_TREE                = ConvertTargetFlag(64)
    constant targetflag     TARGET_FLAG_WALL                = ConvertTargetFlag(128)
    constant targetflag     TARGET_FLAG_DEBRIS              = ConvertTargetFlag(256)
    constant targetflag     TARGET_FLAG_DECORATION          = ConvertTargetFlag(512)
    constant targetflag     TARGET_FLAG_BRIDGE              = ConvertTargetFlag(1024)

    // defense type
    constant defensetype    DEFENSE_TYPE_LIGHT              = ConvertDefenseType(0)
    constant defensetype    DEFENSE_TYPE_MEDIUM             = ConvertDefenseType(1)
    constant defensetype    DEFENSE_TYPE_LARGE              = ConvertDefenseType(2)
    constant defensetype    DEFENSE_TYPE_FORT               = ConvertDefenseType(3)
    constant defensetype    DEFENSE_TYPE_NORMAL             = ConvertDefenseType(4)
    constant defensetype    DEFENSE_TYPE_HERO               = ConvertDefenseType(5)
    constant defensetype    DEFENSE_TYPE_DIVINE             = ConvertDefenseType(6)
    constant defensetype    DEFENSE_TYPE_NONE               = ConvertDefenseType(7)

    // Hero Attribute
    constant heroattribute  HERO_ATTRIBUTE_STR              = ConvertHeroAttribute(1)
    constant heroattribute  HERO_ATTRIBUTE_INT              = ConvertHeroAttribute(2)
    constant heroattribute  HERO_ATTRIBUTE_AGI              = ConvertHeroAttribute(3)

    // Armor Type
    constant armortype      ARMOR_TYPE_WHOKNOWS             = ConvertArmorType(0)
    constant armortype      ARMOR_TYPE_FLESH                = ConvertArmorType(1)
    constant armortype      ARMOR_TYPE_METAL                = ConvertArmorType(2)
    constant armortype      ARMOR_TYPE_WOOD                 = ConvertArmorType(3)
    constant armortype      ARMOR_TYPE_ETHREAL              = ConvertArmorType(4)
    constant armortype      ARMOR_TYPE_STONE                = ConvertArmorType(5)

    // Regeneration Type
    constant regentype      REGENERATION_TYPE_NONE          = ConvertRegenType(0)
    constant regentype      REGENERATION_TYPE_ALWAYS        = ConvertRegenType(1)
    constant regentype      REGENERATION_TYPE_BLIGHT        = ConvertRegenType(2)
    constant regentype      REGENERATION_TYPE_DAY           = ConvertRegenType(3)
    constant regentype      REGENERATION_TYPE_NIGHT         = ConvertRegenType(4)

    // Unit Category
    constant unitcategory   UNIT_CATEGORY_GIANT             = ConvertUnitCategory(1)
    constant unitcategory   UNIT_CATEGORY_UNDEAD            = ConvertUnitCategory(2)
    constant unitcategory   UNIT_CATEGORY_SUMMONED          = ConvertUnitCategory(4)
    constant unitcategory   UNIT_CATEGORY_MECHANICAL        = ConvertUnitCategory(8)
    constant unitcategory   UNIT_CATEGORY_PEON              = ConvertUnitCategory(16)
    constant unitcategory   UNIT_CATEGORY_SAPPER            = ConvertUnitCategory(32)
    constant unitcategory   UNIT_CATEGORY_TOWNHALL          = ConvertUnitCategory(64)
    constant unitcategory   UNIT_CATEGORY_ANCIENT           = ConvertUnitCategory(128)
    constant unitcategory   UNIT_CATEGORY_NEUTRAL           = ConvertUnitCategory(256)
    constant unitcategory   UNIT_CATEGORY_WARD              = ConvertUnitCategory(512)
    constant unitcategory   UNIT_CATEGORY_STANDON           = ConvertUnitCategory(1024)
    constant unitcategory   UNIT_CATEGORY_TAUREN            = ConvertUnitCategory(2048)

    // Pathing Flag
    constant pathingflag    PATHING_FLAG_UNWALKABLE             = ConvertPathingFlag(2)
    constant pathingflag    PATHING_FLAG_UNFLYABLE              = ConvertPathingFlag(4)
    constant pathingflag    PATHING_FLAG_UNBUILDABLE            = ConvertPathingFlag(8)
    constant pathingflag    PATHING_FLAG_UNPEONHARVEST          = ConvertPathingFlag(16)
    constant pathingflag    PATHING_FLAG_BLIGHTED               = ConvertPathingFlag(32)
    constant pathingflag    PATHING_FLAG_UNFLOATABLE            = ConvertPathingFlag(64)
    constant pathingflag    PATHING_FLAG_UNAMPHIBIOUS           = ConvertPathingFlag(128)
    constant pathingflag    PATHING_FLAG_UNITEMPLACABLE         = ConvertPathingFlag(256)

    // common.ai

    //--------------------------------------------------------------------
    //  HUMANS
    //--------------------------------------------------------------------

    // human heroes
    constant integer ARCHMAGE           = 'Hamg'
    constant integer PALADIN            = 'Hpal'
    constant integer MTN_KING           = 'Hmkg'
    constant integer BLOOD_MAGE         = 'Hblm'

    // human hero abilities
    constant integer AVATAR             = 'AHav'
    constant integer BASH               = 'AHbh'
    constant integer THUNDER_BOLT       = 'AHtb'
    constant integer THUNDER_CLAP       = 'AHtc'

    constant integer DEVOTION_AURA      = 'AHad'
    constant integer DIVINE_SHIELD      = 'AHds'
    constant integer HOLY_BOLT          = 'AHhb'
    constant integer RESURRECTION       = 'AHre'

    constant integer BLIZZARD           = 'AHbz'
    constant integer BRILLIANCE_AURA    = 'AHab'
    constant integer MASS_TELEPORT      = 'AHmt'
    constant integer WATER_ELEMENTAL    = 'AHwe'

    constant integer BANISH             = 'AHbn'
    constant integer FLAME_STRIKE       = 'AHfs'
    constant integer SUMMON_PHOENIX     = 'AHpx'
    constant integer SIPHON_MANA        = 'AHdr'

    // special human heroes
    constant integer JAINA              = 'Hjai'
    constant integer MURADIN            = 'Hmbr'
    constant integer GARITHOS           = 'Hlgr'
    constant integer KAEL               = 'Hkal'

    // human units
    constant integer COPTER             = 'hgyr'
    constant integer GYRO               =  COPTER
    constant integer ELEMENTAL          = 'hwat'
    constant integer FOOTMAN            = 'hfoo'
    constant integer FOOTMEN            =  FOOTMAN
    constant integer GRYPHON            = 'hgry'
    constant integer KNIGHT             = 'hkni'
    constant integer MORTAR             = 'hmtm'
    constant integer PEASANT            = 'hpea'
    constant integer PRIEST             = 'hmpr'
    constant integer RIFLEMAN           = 'hrif'
    constant integer RIFLEMEN           =  RIFLEMAN
    constant integer SORCERESS          = 'hsor'
    constant integer TANK               = 'hmtt'
    constant integer STEAM_TANK         =  TANK
    constant integer ROCKET_TANK        = 'hrtt'
    constant integer MILITIA            = 'hmil'
    constant integer SPELL_BREAKER      = 'hspt'
    constant integer HUMAN_DRAGON_HAWK  = 'hdhw'

    // special human units
    constant integer BLOOD_PRIEST       = 'hbep'
    constant integer BLOOD_SORCERESS    = 'hbes'
    constant integer BLOOD_PEASANT      = 'nhew'

    // human buildings
    constant integer AVIARY             = 'hgra'
    constant integer BARRACKS           = 'hbar'
    constant integer BLACKSMITH         = 'hbla'
    constant integer CANNON_TOWER       = 'hctw'
    constant integer CASTLE             = 'hcas'
    constant integer CHURCH             = 'htws'
    constant integer MAGE_TOWER         =  CHURCH
    constant integer GUARD_TOWER        = 'hgtw'
    constant integer HOUSE              = 'hhou'
    constant integer HUMAN_ALTAR        = 'halt'
    constant integer KEEP               = 'hkee'
    constant integer LUMBER_MILL        = 'hlum'
    constant integer SANCTUM            = 'hars'
    constant integer ARCANE_SANCTUM     =  SANCTUM
    constant integer TOWN_HALL          = 'htow'
    constant integer WATCH_TOWER        = 'hwtw'
    constant integer WORKSHOP           = 'harm'
    constant integer ARCANE_VAULT       = 'hvlt'
    constant integer ARCANE_TOWER       = 'hatw'

    // human upgrades
    constant integer UPG_MELEE          = 'Rhme'
    constant integer UPG_RANGED         = 'Rhra'
    constant integer UPG_ARTILLERY      = 'Rhaa'
    constant integer UPG_ARMOR          = 'Rhar'
    constant integer UPG_GOLD           = 'Rhmi'
    constant integer UPG_MASONRY        = 'Rhac'
    constant integer UPG_SIGHT          = 'Rhss'
    constant integer UPG_DEFEND         = 'Rhde'
    constant integer UPG_BREEDING       = 'Rhan'
    constant integer UPG_PRAYING        = 'Rhpt'
    constant integer UPG_SORCERY        = 'Rhst'
    constant integer UPG_LEATHER        = 'Rhla'
    constant integer UPG_GUN_RANGE      = 'Rhri'
    constant integer UPG_WOOD           = 'Rhlh'
    constant integer UPG_SENTINEL       = 'Rhse'
    constant integer UPG_SCATTER        = 'Rhsr'
    constant integer UPG_BOMBS          = 'Rhgb'
    constant integer UPG_HAMMERS        = 'Rhhb'
    constant integer UPG_CONT_MAGIC     = 'Rhss'
    constant integer UPG_FRAGS          = 'Rhfs'
    constant integer UPG_TANK           = 'Rhrt'
    constant integer UPG_FLAK           = 'Rhfc'
    constant integer UPG_CLOUD          = 'Rhcd'

    //--------------------------------------------------------------------
    //  ORCS
    //--------------------------------------------------------------------

    // orc heroes
    constant integer BLADE_MASTER       = 'Obla'
    constant integer FAR_SEER           = 'Ofar'
    constant integer TAUREN_CHIEF       = 'Otch'
    constant integer SHADOW_HUNTER      = 'Oshd'

    // special orc heroes
    constant integer GROM               = 'Ogrh'
    constant integer THRALL             = 'Othr'

    // orc hero abilities
    constant integer CRITICAL_STRIKE    = 'AOcr'
    constant integer MIRROR_IMAGE       = 'AOmi'
    constant integer BLADE_STORM        = 'AOww'
    constant integer WIND_WALK          = 'AOwk'

    constant integer CHAIN_LIGHTNING    = 'AOcl'
    constant integer EARTHQUAKE         = 'AOeq'
    constant integer FAR_SIGHT          = 'AOfs'
    constant integer SPIRIT_WOLF        = 'AOsf'

    constant integer ENDURANE_AURA      = 'AOae'
    constant integer REINCARNATION      = 'AOre'
    constant integer SHOCKWAVE          = 'AOsh'
    constant integer WAR_STOMP          = 'AOws'

    constant integer HEALING_WAVE       = 'AOhw'
    constant integer HEX                = 'AOhx'
    constant integer SERPENT_WARD       = 'AOsw'
    constant integer VOODOO             = 'AOvd'

    // orc units
    constant integer GUARDIAN           = 'oang'
    constant integer CATAPULT           = 'ocat'
    constant integer WITCH_DOCTOR       = 'odoc'
    constant integer GRUNT              = 'ogru'
    constant integer HEAD_HUNTER        = 'ohun'
    constant integer BERSERKER          = 'otbk'
    constant integer KODO_BEAST         = 'okod'
    constant integer PEON               = 'opeo'
    constant integer RAIDER             = 'orai'
    constant integer SHAMAN             = 'oshm'
    constant integer TAUREN             = 'otau'
    constant integer WYVERN             = 'owyv'
    constant integer BATRIDER           = 'otbr'
    constant integer SPIRIT_WALKER      = 'ospw'
    constant integer SPIRIT_WALKER_M    = 'ospm'

    // orc buildings
    constant integer ORC_ALTAR          = 'oalt'
    constant integer ORC_BARRACKS       = 'obar'
    constant integer BESTIARY           = 'obea'
    constant integer FORGE              = 'ofor'
    constant integer FORTRESS           = 'ofrt'
    constant integer GREAT_HALL         = 'ogre'
    constant integer LODGE              = 'osld'
    constant integer STRONGHOLD         = 'ostr'
    constant integer BURROW             = 'otrb'
    constant integer TOTEM              = 'otto'
    constant integer ORC_WATCH_TOWER    = 'owtw'
    constant integer VOODOO_LOUNGE      = 'ovln'

    // orc upgrades
    constant integer UPG_ORC_MELEE      = 'Rome'
    constant integer UPG_ORC_RANGED     = 'Rora'
    constant integer UPG_ORC_ARTILLERY  = 'Roaa'
    constant integer UPG_ORC_ARMOR      = 'Roar'
    constant integer UPG_ORC_WAR_DRUMS  = 'Rwdm'
    constant integer UPG_ORC_PILLAGE    = 'Ropg'
    constant integer UPG_ORC_BERSERK    = 'Robs'
    constant integer UPG_ORC_PULVERIZE  = 'Rows'
    constant integer UPG_ORC_ENSNARE    = 'Roen'
    constant integer UPG_ORC_VENOM      = 'Rovs'
    constant integer UPG_ORC_DOCS       = 'Rowd'
    constant integer UPG_ORC_SHAMAN     = 'Rost'
    constant integer UPG_ORC_SPIKES     = 'Rosp'
    constant integer UPG_ORC_BURROWS    = 'Rorb'
    constant integer UPG_ORC_REGEN      = 'Rotr'
    constant integer UPG_ORC_FIRE       = 'Rolf'
    constant integer UPG_ORC_SWALKER    = 'Rowt'
    constant integer UPG_ORC_BERSERKER  = 'Robk'
    constant integer UPG_ORC_NAPTHA     = 'Robf'
    constant integer UPG_ORC_CHAOS      = 'Roch'

    // Warcraft 2 orc units
    constant integer OGRE_MAGI          = 'nomg'
    constant integer ORC_DRAGON         = 'nrwm'
    constant integer SAPPER             = 'ngsp'
    constant integer ZEPPLIN            = 'nzep'
    constant integer ZEPPELIN           =  ZEPPLIN
    constant integer W2_WARLOCK         = 'nw2w'
    constant integer PIG_FARM           = 'npgf'
    constant integer FOREST_TROLL       = 'nftr'

    // special orc units
    constant integer CHAOS_GRUNT        = 'nchg'
    constant integer CHAOS_WARLOCK      = 'nchw'
    constant integer CHAOS_RAIDER       = 'nchr'
    constant integer CHAOS_PEON         = 'ncpn'
    constant integer CHAOS_KODO         = 'nckb'
    constant integer CHAOS_GROM         = 'Opgh'
    constant integer CHAOS_BLADEMASTER  = 'Nbbc'
    constant integer CHAOS_BURROW       = 'ocbw'

    //--------------------------------------------------------------------
    //  UNDEAD
    //--------------------------------------------------------------------

    // undead heroes
    constant integer DEATH_KNIGHT       = 'Udea'
    constant integer DREAD_LORD         = 'Udre'
    constant integer LICH               = 'Ulic'
    constant integer CRYPT_LORD         = 'Ucrl'

    // special undead heroes
    constant integer MALGANIS           = 'Umal'
    constant integer TICHONDRIUS        = 'Utic'
    constant integer PIT_LORD           = 'Npld'
    constant integer DETHEROC           = 'Udth'

    // undead hero abilities
    constant integer SLEEP              = 'AUsl'
    constant integer VAMP_AURA          = 'AUav'
    constant integer CARRION_SWARM      = 'AUcs'
    constant integer INFERNO            = 'AUin'

    constant integer DARK_RITUAL        = 'AUdr'
    constant integer DEATH_DECAY        = 'AUdd'
    constant integer FROST_ARMOR        = 'AUfu'
    constant integer FROST_NOVA         = 'AUfn'

    constant integer ANIM_DEAD          = 'AUan'
    constant integer DEATH_COIL         = 'AUdc'
    constant integer DEATH_PACT         = 'AUdp'
    constant integer UNHOLY_AURA        = 'AUau'

    constant integer CARRION_SCARAB     = 'AUcb'
    constant integer IMPALE             = 'AUim'
    constant integer LOCUST_SWARM       = 'AUls'
    constant integer THORNY_SHIELD      = 'AUts'

    // undead units
    constant integer ABOMINATION        = 'uabo'
    constant integer ACOLYTE            = 'uaco'
    constant integer BANSHEE            = 'uban'
    constant integer PIT_FIEND          = 'ucry'
    constant integer CRYPT_FIEND        =  PIT_FIEND
    constant integer FROST_WYRM         = 'ufro'
    constant integer GARGOYLE           = 'ugar'
    constant integer GARGOYLE_MORPH     = 'ugrm'
    constant integer GHOUL              = 'ugho'
    constant integer MEAT_WAGON         = 'umtw'
    constant integer NECRO              = 'unec'
    constant integer SKEL_WARRIOR       = 'uske'
    constant integer SHADE              = 'ushd'
    constant integer UNDEAD_BARGE       = 'uarb'
    constant integer OBSIDIAN_STATUE    = 'uobs'
    constant integer OBS_STATUE         =  OBSIDIAN_STATUE
    constant integer BLK_SPHINX         = 'ubsp'

    // undead buildings
    constant integer UNDEAD_MINE        = 'ugol'
    constant integer UNDEAD_ALTAR       = 'uaod'
    constant integer BONEYARD           = 'ubon'
    constant integer GARG_SPIRE         = 'ugsp'
    constant integer NECROPOLIS_1       = 'unpl'    // normal
    constant integer NECROPOLIS_2       = 'unp1'    // upgraded once
    constant integer NECROPOLIS_3       = 'unp2'    // full upgrade
    constant integer SAC_PIT            = 'usap'
    constant integer CRYPT              = 'usep'
    constant integer SLAUGHTERHOUSE     = 'uslh'
    constant integer DAMNED_TEMPLE      = 'utod'
    constant integer ZIGGURAT_1         = 'uzig'    // normal
    constant integer ZIGGURAT_2         = 'uzg1'    // upgraded
    constant integer ZIGGURAT_FROST     = 'uzg2'    // frost tower
    constant integer GRAVEYARD          = 'ugrv'
    constant integer TOMB_OF_RELICS     = 'utom'

    // undead upgrades
    constant integer UPG_UNHOLY_STR     = 'Rume'
    constant integer UPG_CR_ATTACK      = 'Rura'
    constant integer UPG_UNHOLY_ARMOR   = 'Ruar'
    constant integer UPG_CANNIBALIZE    = 'Ruac'
    constant integer UPG_GHOUL_FRENZY   = 'Rugf'
    constant integer UPG_FIEND_WEB      = 'Ruwb'
    constant integer UPG_ABOM           = 'Ruab'
    constant integer UPG_STONE_FORM     = 'Rusf'
    constant integer UPG_NECROS         = 'Rune'
    constant integer UPG_BANSHEE        = 'Ruba'
    constant integer UPG_MEAT_WAGON     = 'Rump'
    constant integer UPG_WYRM_BREATH    = 'Rufb'
    constant integer UPG_SKEL_LIFE      = 'Rusl'
    constant integer UPG_SKEL_MASTERY   = 'Rusm'
    constant integer UPG_EXHUME         = 'Ruex'
    constant integer UPG_SACRIFICE      = 'Rurs'
    constant integer UPG_ABOM_EXPL      = 'Ruax'
    constant integer UPG_CR_ARMOR       = 'Rucr'
    constant integer UPG_PLAGUE         = 'Rupc'
    constant integer UPG_BLK_SPHINX     = 'Rusp'
    constant integer UPG_BURROWING      = 'Rubu'

    //--------------------------------------------------------------------
    //  ELVES
    //--------------------------------------------------------------------

    // elf heroes
    constant integer DEMON_HUNTER       = 'Edem'
    constant integer DEMON_HUNTER_M     = 'Edmm'
    constant integer KEEPER             = 'Ekee'
    constant integer MOON_CHICK         = 'Emoo'
    constant integer MOON_BABE          =  MOON_CHICK
    constant integer MOON_HONEY         =  MOON_CHICK
    constant integer WARDEN             = 'Ewar'

    // special elf heroes
    constant integer SYLVANUS           = 'Hvwd'
    constant integer CENARIUS           = 'Ecen'
    constant integer ILLIDAN            = 'Eevi'
    constant integer ILLIDAN_DEMON      = 'Eevm'
    constant integer MAIEV              = 'Ewrd'

    // elf hero abilities
    constant integer FORCE_NATURE       = 'AEfn'
    constant integer ENT_ROOTS          = 'AEer'
    constant integer THORNS_AURA        = 'AEah'
    constant integer TRANQUILITY        = 'AEtq'

    constant integer EVASION            = 'AEev'
    constant integer IMMOLATION         = 'AEim'
    constant integer MANA_BURN          = 'AEmb'
    constant integer METAMORPHOSIS      = 'AEme'

    constant integer SEARING_ARROWS     = 'AHfa'
    constant integer SCOUT              = 'AEst'
    constant integer STARFALL           = 'AEsf'
    constant integer TRUESHOT           = 'AEar'

    constant integer BLINK              = 'AEbl'
    constant integer FAN_KNIVES         = 'AEfk'
    constant integer SHADOW_TOUCH       = 'AEsh'
    constant integer VENGEANCE          = 'AEsv'

    // elf units
    constant integer WISP               = 'ewsp'
    constant integer ARCHER             = 'earc'
    constant integer DRUID_TALON        = 'edot'
    constant integer DRUID_TALON_M      = 'edtm'
    constant integer BALLISTA           = 'ebal'
    constant integer DRUID_CLAW         = 'edoc'
    constant integer DRUID_CLAW_M       = 'edcm'
    constant integer DRYAD              = 'edry'
    constant integer HIPPO              = 'ehip'
    constant integer HIPPO_RIDER        = 'ehpr'
    constant integer HUNTRESS           = 'esen'
    constant integer CHIMAERA           = 'echm'
    constant integer ENT                = 'efon'
    constant integer MOUNTAIN_GIANT     = 'emtg'
    constant integer FAERIE_DRAGON      = 'efdr'

    // special elf units
    constant integer HIGH_ARCHER        = 'nhea'
    constant integer HIGH_FOOTMAN       = 'hcth'
    constant integer HIGH_FOOTMEN       =  HIGH_FOOTMAN
    constant integer HIGH_SWORDMAN      = 'hhes'
    constant integer DRAGON_HAWK        = 'nws1'
    constant integer CORRUPT_TREANT     = 'nenc'
    constant integer POISON_TREANT      = 'nenp'
    constant integer PLAGUE_TREANT      = 'nepl'
    constant integer SHANDRIS           = 'eshd'

    // elf buildings
    constant integer ANCIENT_LORE       = 'eaoe'
    constant integer ANCIENT_WAR        = 'eaom'
    constant integer ANCIENT_WIND       = 'eaow'
    constant integer TREE_AGES          = 'etoa'
    constant integer TREE_ETERNITY      = 'etoe'
    constant integer TREE_LIFE          = 'etol'
    constant integer ANCIENT_PROTECT    = 'etrp'
    constant integer ELF_ALTAR          = 'eate'
    constant integer BEAR_DEN           = 'edol'
    constant integer CHIMAERA_ROOST     = 'edos'
    constant integer HUNTERS_HALL       = 'edob'
    constant integer MOON_WELL          = 'emow'
    constant integer ELF_MINE           = 'egol'
    constant integer DEN_OF_WONDERS     = 'eden'

    // special elf buildings
    constant integer ELF_FARM           = 'nefm'
    constant integer ELF_GUARD_TOWER    = 'negt'
    constant integer HIGH_SKY           = 'negm'
    constant integer HIGH_EARTH         = 'negf'
    constant integer HIGH_TOWER         = 'negt'
    constant integer ELF_HIGH_BARRACKS  = 'nheb'
    constant integer CORRUPT_LIFE       = 'nctl'
    constant integer CORRUPT_WELL       = 'ncmw'
    constant integer CORRUPT_PROTECTOR  = 'ncap'
    constant integer CORRUPT_WAR        = 'ncaw'

    // elf upgrades
    constant integer UPG_STR_MOON       = 'Resm'
    constant integer UPG_STR_WILD       = 'Resw'
    constant integer UPG_MOON_ARMOR     = 'Rema'
    constant integer UPG_HIDES          = 'Rerh'
    constant integer UPG_ULTRAVISION    = 'Reuv'
    constant integer UPG_BLESSING       = 'Renb'
    constant integer UPG_SCOUT          = 'Resc'
    constant integer UPG_GLAIVE         = 'Remg'
    constant integer UPG_BOWS           = 'Reib'
    constant integer UPG_MARKSMAN       = 'Remk'
    constant integer UPG_DRUID_TALON    = 'Redt'
    constant integer UPG_DRUID_CLAW     = 'Redc'
    constant integer UPG_ABOLISH        = 'Resi'
    constant integer UPG_CHIM_ACID      = 'Recb'
    constant integer UPG_HIPPO_TAME     = 'Reht'
    constant integer UPG_BOLT           = 'Repd'
    constant integer UPG_MARK_CLAW      = 'Reeb'
    constant integer UPG_MARK_TALON     = 'Reec'
    constant integer UPG_HARD_SKIN      = 'Rehs'
    constant integer UPG_RESIST_SKIN    = 'Rers'
    constant integer UPG_WELL_SPRING    = 'Rews'

    //--------------------------------------------------------------------
    // Neutral
    //--------------------------------------------------------------------
    constant integer DEMON_GATE         = 'ndmg'
    constant integer FELLHOUND          = 'nfel'
    constant integer INFERNAL           = 'ninf'
    constant integer DOOMGUARD          = 'nbal'
    constant integer SATYR              = 'nsty'
    constant integer TRICKSTER          = 'nsat'
    constant integer SHADOWDANCER       = 'nsts'
    constant integer SOULSTEALER        = 'nstl'
    constant integer HELLCALLER         = 'nsth'
    constant integer SKEL_ARCHER        = 'nska'
    constant integer SKEL_MARKSMAN      = 'nskm'
    constant integer SKEL_BURNING       = 'nskf'
    constant integer SKEL_GIANT         = 'nskg'
    constant integer FURBOLG            = 'nfrl'
    constant integer FURBOLG_TRACKER    = 'nfrb'
    constant integer FURBOLG_SHAMAN     = 'nfrs'
    constant integer FURBOLG_CHAMP      = 'nfrg'
    constant integer FURBOLG_ELDER      = 'nfre'

    //--------------------------------------------------------------------
    // NAGA
    //--------------------------------------------------------------------

    // naga heroes
    constant integer NAGA_SORCERESS     = 'Nngs'
    constant integer NAGA_VASHJ         = 'Hvsh'

    // naga units
    constant integer NAGA_DRAGON        = 'nsnp'        // old names
    constant integer NAGA_WITCH         = 'nnsw'
    constant integer NAGA_SERPENT       = 'nwgs'
    constant integer NAGA_HYDRA         = 'nhyc'

    constant integer NAGA_SLAVE         = 'nmpe'        // peon
    constant integer NAGA_SNAP_DRAGON   =  NAGA_DRAGON  // weak ranged
    constant integer NAGA_COUATL        =  NAGA_SERPENT // weak air
    constant integer NAGA_SIREN         =  NAGA_WITCH   // caster
    constant integer NAGA_MYRMIDON      = 'nmyr'        // knight
    constant integer NAGA_REAVER        = 'nnmg'        // footman
    constant integer NAGA_TURTLE        =  NAGA_HYDRA   // siege
    constant integer NAGA_ROYAL         = 'nnrg'        // royal guard

    // naga buildings
    constant integer NAGA_TEMPLE        = 'nntt'        // town hall
    constant integer NAGA_CORAL         = 'nnfm'        // farm
    constant integer NAGA_SHRINE        = 'nnsa'        // sirens & couatls
    constant integer NAGA_SPAWNING      = 'nnsg'        // myrm, snap dragon, hydra
    constant integer NAGA_GUARDIAN      = 'nntg'        // tower
    constant integer NAGA_ALTAR         = 'nnad'        // altar

    // naga upgrades
    constant integer UPG_NAGA_ARMOR     = 'Rnam'
    constant integer UPG_NAGA_ATTACK    = 'Rnat'
    constant integer UPG_NAGA_ABOLISH   = 'Rnsi'
    constant integer UPG_SIREN          = 'Rnsw'
    constant integer UPG_NAGA_ENSNARE   = 'Rnen'


    //--------------------------------------------------------------------
    constant integer M1                 =    60
    constant integer M2                 =  2*60
    constant integer M3                 =  3*60
    constant integer M4                 =  4*60
    constant integer M5                 =  5*60
    constant integer M6                 =  6*60
    constant integer M7                 =  7*60
    constant integer M8                 =  8*60
    constant integer M9                 =  9*60
    constant integer M10                = 10*60
    constant integer M11                = 11*60
    constant integer M12                = 12*60
    constant integer M13                = 13*60
    constant integer M14                = 14*60
    constant integer M15                = 15*60

    constant integer EASY               = 1
    constant integer NORMAL             = 2
    constant integer HARD               = 3
    constant integer INSANE             = 4 // not used

    constant integer MELEE_NEWBIE       = 1
    constant integer MELEE_NORMAL       = 2
    constant integer MELEE_INSANE       = 3

    constant integer ATTACK_CAPTAIN     = 1
    constant integer DEFENSE_CAPTAIN    = 2
    constant integer BOTH_CAPTAINS      = 3

    constant integer BUILD_UNIT         = 1
    constant integer BUILD_UPGRADE      = 2
    constant integer BUILD_EXPAND       = 3

    constant integer UPKEEP_TIER1       = 50
    constant integer UPKEEP_TIER2       = 80


    // WoW Reforged
    // make constants available to triggers AND common.ai

    constant string MAP_VERSION                                      = "3.39"
    constant boolean MAP_DEBUG_MODE                                  = true // Disable for releases.

    constant real UI_FULLSCREEN_X                                    = 0.0
    constant real UI_FULLSCREEN_Y                                    = 0.57
    constant real UI_FULLSCREEN_WIDTH                                = 0.80
    constant real UI_FULLSCREEN_HEIGHT                               = 0.42
    constant real UI_FULLSCREEN_TITLE_Y                              = 0.548
    constant real UI_FULLSCREEN_TITLE_HEIGHT                         = 0.1
    constant real UI_FULLSCREEN_BOTTOM_BUTTON_Y                      = 0.20
    constant real UI_FULLSCREEN_BOTTOM_BUTTON_WIDTH                  = 0.12
    constant real UI_FULLSCREEN_BOTTOM_BUTTON_HEIGHT                 = 0.03
    constant real UI_FULLSCREEN_CLOSE_BUTTON_X                       = 0.34
    constant real UI_FULLSCREEN_NEXT_PAGE_BUTTON_X                   = 0.18
    constant real UI_FULLSCREEN_PREVIOUS_PAGE_BUTTON_X               = 0.06

    constant string UI_ICON_UP                                       = "ReplaceableTextures\\CommandButtons\\BTNReplay-SpeedUp.blp"
    constant string UI_ICON_DOWN                                     = "ReplaceableTextures\\CommandButtons\\BTNReplay-SpeedDown.blp"

    constant string URL_DISCORD                                      = "https://discord.com/invite/eM34z36"
    constant string URL_WEBSITE                                      = "https://wowreforged.org"
    constant string URL_DOWNLOAD                                     = "https://github.com/tdauth/wowr/releases"
    constant string URL_SUBSCRIBE                                    = "https://www.paypal.com/webapps/billing/plans/subscribe?plan_id=P-2H6673288J5283354M6TTVVY"
    constant string URL_DONATE                                       = "https://www.paypal.com/donate/?hosted_button_id=ZAAKMQLSNGDK8"

    constant string QR_CODE_SUBSCRIBE                                = "war3mapImported\\QR_Code_Subscribe.blp"
    constant string QR_CODE_DONATE                                   = "war3mapImported\\QR_Code_Donate.blp"
    constant string QR_CODE_DISCORD                                  = "war3mapImported\\QR_Code_Discord.blp"
    constant string QR_CODE_WEBSITE                                  = "war3mapImported\\QR_Code_Website.blp"

    // limits
    constant integer MAX_ITEM_ABILITIES                              = 4
    constant integer MAX_HERO_ABILITIES                              = 5
    constant integer MAX_UNIT_ABILITIES                              = 30 // actually infinite but we want to stop somewhere

    // balance
    constant integer MANA_COSTS_PER_ABILITY_LEVEL                    = 10

    // Hero Journey
    constant integer HERO_JOURNEY_HERO_STANDARD_ABILITIES            = 5
    constant integer HERO_JOURNEY_RANDOM_EVENTS                      = 10
    constant integer HERO_JOURNEY_EQUIPMENT_BAG_1                    = 15
    constant integer HERO_JOURNEY_MOUNTS                             = 20
    constant integer HERO_JOURNEY_PROFESSION_2                       = 25
    constant integer HERO_JOURNEY_BONUS_RACES                        = 30
    constant integer HERO_JOURNEY_HAND_OF_GOD                        = 35
    constant integer HERO_JOURNEY_HIDDEN_BASES                       = 35
    constant integer HERO_JOURNEY_BONUS_HEROS                        = 40
    constant integer HERO_JOURNEY_EQUIPMENT_BAG_2                    = 40
    constant integer HERO_JOURNEY_HERO_2                             = 45
    constant integer HERO_JOURNEY_PROFESSION_3                       = 50
    constant integer HERO_JOURNEY_BOSS_HEROES                        = 55
    constant integer HERO_JOURNEY_BONUS_MOUNTS                       = 55
    constant integer HERO_JOURNEY_BOSS_FIGHT_ISLAND                  = 55
    constant integer HERO_JOURNEY_RACE_2                             = 60
    constant integer HERO_JOURNEY_EQUIPMENT_BAG_3                    = 60
    constant integer HERO_JOURNEY_HERO_3                             = 65
    constant integer HERO_JOURNEY_RACE_3                             = 65
    constant integer HERO_JOURNEY_AI                                 = 70
    constant integer HERO_JOURNEY_VOID_LORDS                         = 75
    constant integer HERO_JOURNEY_ADVANCED_CHAT_COMMANDS             = 75
    constant integer HERO_JOURNEY_MAX_BOSS_LEVELS                    = 75
    constant integer HERO_JOURNEY_ALL_RACES                          = 75
    constant integer HERO_JOURNEY_ALL_PROFESSIONS                    = 75

    constant integer UPG_BONUS_HEROES                                = 'R04Y'
    constant integer UPG_HERO_LEVEL_75                               = 'R06B'
    constant integer UPG_VIP                                         = 'R06C'

    // AI
    constant integer WORKERS_COUNT_START                             = 20

    constant integer HERO_SELECTOR                                   = 'H056'
    constant integer BACK_PACK                                       = 'E008'
    constant integer BACKPACK                                        = BACK_PACK
    constant integer EQUIPMENT_BAG                                   = 'E00R'
    constant integer MAX_HERO_LEVEL                                  = 75
    constant integer MAX_HERO_SPELL_LEVEL                            = 15
    constant integer MAX_HEROES                                      = 3
    constant integer SPELL_BOOK                                      = 'o025'
    constant integer POWER_GENERATOR                                 = 'n025'
    constant integer ITEM_TINY_POWER_GENERATOR                       = 'I05C'
    constant integer PORTAL                                          = 'h014'
    constant integer ITEM_TINY_PORTAL                                = 'I05B'
    constant integer PORTAL_NEUTRAL                                  = 'nwgt'
    constant integer PORTAL_NEUTRAL_2                                = 'n01G'
    constant integer PORTAL_NEUTRAL_FREELANCER                       = 'n03A'
    constant integer PORTAL_NEUTRAL_WATER                            = 'n04A'
    constant integer RESEARCH_TENT                                   = 'n042'
    constant integer ITEM_TINY_RESEARCH_TENT                         = 'I0LK'
    constant integer EVENT_HOUSE                                     = 'n054'
    constant integer CRAFTING_STASH                                  = 'h04V'
    constant integer ITEM_TINY_CRAFTING_STASH                        = 'I0LL'
    constant integer CRAFTING_STASH_NEUTRAL                          = 'h0J2'
    constant integer MARKETPLACE                                     = 'nmrk'
    constant integer TRADING_POST                                    = 'n04J'
    constant integer ITEM_TINY_TRADING_POST                          = 'I0L9'
    constant integer ANTIMAGIC_WARD                                  = 'o01Z'
    constant integer PACK_HORSE_PACKED                               = 'h097'
    constant integer PACK_HORSE                                      = 'h02N'
    constant integer THIEVES_GUILD                                   = 'n09D'
    constant integer ITEM_TINY_THIEVES_GUILD                         = 'I124'
    constant integer MOUNTS_CAGE                                     = 'o04H'
    constant integer ITEM_TINY_MOUNTS_CAGE                           = 'I125'
    constant integer ALCHEMIST_LAB                                   = 'o054'
    constant integer WITCH_HUT                                       = 'o05F'
    constant integer ITEM_TINY_WITCH_HUT                             = 'I0MX'
    constant integer HERO_ABILITIES                                  = 'n0E3'
    constant integer ITEM_TINY_HERO_ABILITIES                        = 'I0J6'
    constant integer HERO_ABILITIES_NEUTRAL                          = 'n049'
    constant integer SKINS                                           = 'n0GD'
    constant integer ITEM_TINY_SKINS                                 = 'I0QM'
    constant integer SKINS_NEUTRAL                                   = 'n0GB'
    constant integer DRAGON_ROOST                                    = 'n09L'
    constant integer ITEM_TINY_DRAGON_ROOST                          = 'I126'
    constant integer TEMPLE_OF_DARKNESS                              = 'h00N'
    constant integer TEMPLE_OF_LIGHT                                 = 'h00M'
    constant integer HERO_SPELLS_SLOT_1                              = 'n0AN'
    constant integer HERO_SPELLS_SLOT_2                              = 'n08I'
    constant integer HERO_SPELLS_SLOT_3                              = 'n06Y'
    constant integer HERO_SPELLS_SLOT_4                              = 'n08H'
    constant integer HERO_SPELLS_SLOT_5                              = 'n08G'
    constant integer MOUNTS_SHOP                                     = 'n06U'
    constant integer WALL                                            = 'h04Q'
    constant integer ITEM_TINY_WALL                                  = 'I0L8'
    constant integer ENGINEER_SHIP                                   = 'n03H'
    constant integer GNOMISH_SUBMARINE                               = 'h029'
    constant integer LEVEL_PORTAL                                    = 'h0QO'
    constant integer GAME_MODE_TAVERN                                = 'n05U'
    constant integer HEROES_TAVERN                                   = 'n0I0'
    constant integer RACES_TAVERN                                    = 'n0I1'
    constant integer PROFESSIONS_TAVERN                              = 'n0I2'
    constant integer START_LOCATIONS_TAVERN                          = 'n05V'
    constant integer ARMORY                                          = 'n0IS'
    constant integer ITEM_TINY_ARMORY                                = 'I0U7'
    constant integer ARMORY_NEUTRAL                                  = 'n0IU'
    constant integer FRUIT_STAND_ALL_RACES                           = 'n0J7'
    constant integer ITEM_TINY_FRUIT_STAND_ALL_RACES                 = 'I0WV'
    constant integer RESURRECTION_STONE_0                            = 'nbse'
    constant integer RESURRECTION_STONE_1                            = 'nbsw'
    constant integer WATER_TOWER                                     = 'n0ND'
    constant integer ADVANCED_WATER_TOWER                            = 'n0NE'
    constant integer LEGENDARY_ARTIFACT                              = 'nfrm'

    constant integer DEAD_ANIMAL                                     = 'n0A2'

    // Neutral
    constant integer GOLD_MINE                                       = 'ngol'
    constant integer RANDOM_MINE                                     = 'n0DF'
    constant integer GEMSTONES_MINE                                  = 'n0DC'
    constant integer ORE_MINE                                        = 'n0DG'
    constant integer WELL                                            = 'n0DH'
    constant integer OIL_PLATFORM                                    = 'n0DK'
    constant integer FOOD_FARM                                       = 'n0DL'
    constant integer FISH_SCHOOL                                     = 'n0DQ'
    constant integer BERRY_BUSHES                                    = 'n0H7'
    constant integer MINERAL_FIELDS                                  = 'n0DS'
    constant integer VESPENE_GEYSERS                                 = 'n0DR'
    constant integer POWER_CRYSTAL_MINE                              = 'n0DZ'
    constant integer MONUMENT                                        = 'n0ET'
    constant integer ROCKS_MINE                                      = 'n0GJ'
    constant integer FRUIT_STAND                                     = 'n0GU'
    constant integer ARGUNITE_MINE                                   = 'n0JT'
    constant integer FEL_MINE                                        = 'n0FB'
    constant integer RANDOM_WATER_MINE                               = 'n0DT'
    constant integer WATER_OIL_PLATFORM                              = 'n0DU'
    constant integer FLOTSAM                                         = 'n0DJ'

    constant integer ANIMAL_PEN                                      = 'n0O5' // Wool Mine

    // Properties
    constant integer PROPERTY_WYRMREST_TEMPLE                        = 'n0OC'

    // Banners
    constant integer BANNER_SHOP_NEUTRAL                             = 'n0E4'
    constant integer BANNER_SHOP                                     = 'n0E6'

    constant integer BANNER_STORMWIND                                = 'o057'
    constant integer BANNER_KUL_TIRAS                                = 'o056'
    constant integer BANNER_GILNEAS                                  = 'o04K'
    constant integer BANNER_ALTERAC                                  = 'o04F'
    constant integer BANNER_DALARAN                                  = 'o04J'
    constant integer BANNER_THERAMORE                                = 'o058'
    constant integer BANNER_STROMGARDE                               = 'o059'
    constant integer BANNER_LORDAERON                                = 'o05A'
    constant integer BANNER_HIGH_ELF                                 = 'o05B'
    constant integer BANNER_BLOOD_ELF                                = 'o05H'
    constant integer BANNER_BRONZEBEARD                              = 'o08I'
    constant integer BANNER_IRONFORGE                                = 'o09V'
    constant integer BANNER_WILDHAMMER                               = 'o0AM'
    constant integer BANNER_STORMPIKE                                = 'o0BJ'
    constant integer BANNER_DARK_IRON                                = 'o0BK'
    constant integer BANNER_EXPLORERS                                = 'o0BL'
    constant integer BANNER_ORC                                      = 'o0BM'
    constant integer BANNER_UNDEAD                                   = 'o0BN'
    constant integer BANNER_NIGHT_ELF                                = 'o0BO'
    constant integer BANNER_PANDAREN                                 = 'o0BP'

    constant integer ITEM_TINY_BANNER_STORMWIND                      = 'I15A'
    constant integer ITEM_TINY_BANNER_DALARAN                        = 'I13C'
    constant integer ITEM_TINY_BANNER_ALTERAC                        = 'I13B'
    constant integer ITEM_TINY_BANNER_GILNEAS                        = 'I13D'
    constant integer ITEM_TINY_BANNER_KUL_TIRAS                      = 'I159'
    constant integer ITEM_TINY_BANNER_THERAMORE                      = 'I15B'
    constant integer ITEM_TINY_BANNER_STROMGARDE                     = 'I15C'
    constant integer ITEM_TINY_BANNER_LORDAERON                      = 'I15D'
    constant integer ITEM_TINY_BANNER_HIGH_ELF                       = 'I15E'
    constant integer ITEM_TINY_BANNER_BLOOD_ELF                      = 'I15F'
    constant integer ITEM_TINY_BANNER_BRONZEBEARD                    = 'I15G'
    constant integer ITEM_TINY_BANNER_IRONFORGE                      = 'I15H'
    constant integer ITEM_TINY_BANNER_WILDHAMMER                     = 'I15I'
    constant integer ITEM_TINY_BANNER_STORMPIKE                      = 'I15J'
    constant integer ITEM_TINY_BANNER_DARK_IRON                      = 'I15K'
    constant integer ITEM_TINY_BANNER_EXPLORERS                      = 'I15L'
    constant integer ITEM_TINY_BANNER_ORC                            = 'I15M'
    constant integer ITEM_TINY_BANNER_UNDEAD                         = 'I15N'
    constant integer ITEM_TINY_BANNER_NIGHT_ELF                      = 'I15O'
    constant integer ITEM_TINY_BANNER_PANDAREN                       = 'I162'

    // All Races
    constant integer SHREDDER                                        = 'ngir'
    constant integer DRILLBOT                                        = 'n0M5'
    constant integer HARVEST_CART                                    = 'n0H6'
    constant integer AI_LABORATORY                                   = 'h01T'
    constant integer BLACK_DRAGON                                    = 'nbwm'
    constant integer BRONZE_DRAGON                                   = 'nbzd'
    constant integer BLUE_DRAGON                                     = 'nadr'
    constant integer GREEN_DRAGON                                    = 'ngrd'
    constant integer NETHER_DRAGON                                   = 'nndr'
    constant integer RED_DRAGON                                      = 'nrwm'

    constant integer DIVINE_GOLEM                                    = 'n05R'

    constant integer UPG_TEMPLE_OF_DEMIGODS_BLUEPRINTS               = 'R00B'
    constant integer UPG_STORM_PROTECTION                            = 'R029'

    constant integer MAX_WOWR_RESEARCH_LEVEL                         = 75
    constant integer MAX_WOWR_HERO_LEVEL                             = 75

    constant integer HIDEOUT                                         = 'h00J'
    constant integer FORTIFIED_HIDEOUT                               = 'h00K'
    constant integer GUARDIANS_CITADEL                               = 'h00L'

    constant integer GRYPHON_MOUNT                                   = 'h004'
    constant integer WYVERN_MOUNT                                    = 'o003'
    constant integer FROST_WYRM_MOUNT                                = 'u004'
    constant integer CHIMAERA_MOUNT                                  = 'e005'
    constant integer NETHER_DRAKE_MOUNT                              = 'n007'
    constant integer DRAGONHAWK_MOUNT                                = 'h04L'
    constant integer ZEPPELIN_MOUNT                                  = 'n0BT'
    constant integer PHOENIX_MOUNT                                   = 'h0UW'
    constant integer SNOWY_OWL_MOUNT                                 = 'h0V5'

    constant integer FOUNTAIN_OF_LIFE                                = 'h007'
    constant integer FREELANCER_PROTECTION_TOWER                     = 'n03I'
    constant integer NEUTRAL_CITIZEN                                 = 'n02Y'
    constant integer NEUTRAL_CITIZEN_FEMALE                          = 'n03E'
    constant integer NEUTRAL_CHILD                                   = 'n0IV'

    constant integer GNOMISH_LOCOMOTIVE_TRAIN                        = 'n0IP'

    // Levers
    constant integer LEVER_ALL                                       = 'n0AH'

    constant integer MOVE_BRIDGE_DOWN                                = 'o02X' // close
    constant integer MOVE_BRIDGE_UP                                  = 'o02Y' // open
    constant integer CLOSE_GATE                                      = 'o02W' // close
    constant integer OPEN_GATE                                       = 'o02V' // open
    constant integer DISABLE_PORTAL                                  = 'o040' // close
    constant integer ENABLE_PORTAL                                   = 'o03Z' // open

    // Destructibles
    constant integer CRANNIES_SUMMER                                 = 'B011'
    constant integer CRANNIES_FALL                                   = 'B012'
    constant integer CRANNIES_WINTER                                 = 'B013'
    constant integer CRANNIES_WINTER_SNOWY                           = 'B014'

    // clans
    constant integer CLAN_SHOP                                       = 'n04I'
    constant integer CLAN_HORN_SOUND                                 = 'I050'
    constant integer CLAN_LAUGH_SOUND                                = 'I051'
    constant integer CLAN_CREATE_CLAN                                = 'I04H'
    constant integer CLAN_TINY_CLAN_HALL                             = 'I04I'
    constant integer ITEM_TINY_CLAN_HALL                             = 'I04I'
    constant integer ITEM_TINY_CLAN_TOWER                            = 'I05A'
    constant integer CLAN_BANNER_NIGHT_ELF                           = 'I04U'
    constant integer CLAN_BANNER_UNDEAD                              = 'I04V'
    constant integer CLAN_BANNER_ORC                                 = 'I04T'
    constant integer CLAN_BANNER_HUMAN                               = 'I04S'
    constant integer CLAN_BANNER_PANDAREN                            = 'I11I'
    constant integer CLAN_BANNER_DWARF                               = 'I11J'
    constant integer CLAN_BANNER_GNOME                               = 'I11K'

    constant integer CLAN_HALL                                       = 'h02M'
    constant integer CLAN_HALL_KING_CASTLE                           = 'h03U'
    constant integer CLAN_HALL_MANSION                               = 'h03O'
    constant integer CLAN_HALL_NORSE_HALL                            = 'h03V'
    constant integer CLAN_HALL_STONE_CASTLE                          = 'h03T'
    constant integer CLAN_HALL_STONE_KEEP                            = 'h03S'
    constant integer CLAN_TOWER                                      = 'n04N'
    constant integer ADVANCED_CLAN_TOWER                             = 'n04M'
    constant integer CLAN_EMISSARY                                   = 'n04G'

    constant integer UPG_HERO_CLAN                                   = 'R03D'
    constant integer UPG_IMPROVED_CLAN_HALL                          = 'R03C'
    constant integer UPG_IMPROVED_CLAN                               = 'R03B'
    constant integer UPG_CLAN_HAS_NO_AI_PLAYER                       = 'R046'

    constant integer DEMIGOD_LIGHT                                   = 'H003'
    constant integer DEMIGOD_DARK                                    = 'H002'

    constant integer UPG_EVOLUTION                                   = 'R00U'
    constant integer UPG_CHEAP_EVOLUTION                             = 'R01V'
    constant integer UPG_IMPROVED_POWER_GENERATOR                    = 'R01T'
    constant integer UPG_IMPROVED_MOUNT                              = 'R024'
    constant integer UPG_IMPROVED_HAND_OF_GOD                        = 'R00V'
    constant integer UPG_IMPROVED_MASONRY                            = 'R00W'
    constant integer UPG_IMPROVED_NAVY                               = 'R035'
    constant integer UPG_IMPROVED_CREEP_HUNTER                       = 'R02Z'
    constant integer UPG_DEMIGOD                                     = 'R04S'
    constant integer UPG_DRAGON_ROOST                                = 'R06M'
    constant integer UPG_ARCANE_PORTALS                              = 'R026'

    constant integer VOID_LORD_RANGE_STRENGTH                        = 'N08V'
    constant integer VOID_LORD_RANGE_AGILITY                         = 'N06O'
    constant integer VOID_LORD_RANGE_INTELLIGENCE                    = 'N08U'
    constant integer VOID_LORD_MELEE_STRENGTH                        = 'N09X'
    constant integer VOID_LORD_MELEE_AGILITY                         = 'N0AM'
    constant integer VOID_LORD_MELEE_INTELLIGENCE                    = 'N0AL'
    constant integer ARCHANGEL_STRENGTH                              = 'H0A3'
    constant integer ARCHANGEL_AGILITY                               = 'H0BN'
    constant integer ARCHANGEL_INTELLIGENCE                          = 'H0BO'
    constant integer SEA_GIANT_STRENGTH                              = 'H0FB'
    constant integer SEA_GIANT_AGILITY                               = 'H0F9'
    constant integer SEA_GIANT_INTELLIGENCE                          = 'H0FA'
    constant integer CUSTOMIZABLE_HERO_STRENGTH_MELEE                = 'H0Q3'
    constant integer CUSTOMIZABLE_HERO_AGILITY_MELEE                 = 'H0Q4'
    constant integer CUSTOMIZABLE_HERO_INTELLIGENCE_MELEE            = 'H0Q5'
    constant integer CUSTOMIZABLE_HERO_STRENGTH_RANGE                = 'H0Q6'
    constant integer CUSTOMIZABLE_HERO_AGILITY_RANGE                 = 'H0Q7'
    constant integer CUSTOMIZABLE_HERO_INTELLIGENCE_RANGE            = 'H0Q8'
    constant integer GNOMISH_SUBMARINE_HERO                          = 'H0GN'
    constant integer GNOMISH_SUBMARINE_HERO_PILOT                    = 'N0BB'
    constant integer GOBLIN_SUBMARINE_HERO                           = 'H0GO'
    constant integer GOBLIN_SUBMARINE_HERO_SUBMERGED                 = 'H0GS'
    constant integer DWARF_SUBMARINE_HERO                            = 'H0GR'
    constant integer DWARF_SUBMARINE_HERO_SUBMERGED                  = 'H0GT'
    constant integer HUMAN_BATTLESHIP_HERO                           = 'H0KA'
    constant integer CAPTAIN_HERO                                    = 'N0CR'
    constant integer ITEM_VALUES_DUMMY_HERO                          = 'H04W'

    constant integer ITEM_TYPE_RANDOM                                = 'I19T'
    constant integer ITEM_TYPE_RANDOM_HERO                           = 'I068'
    constant integer ITEM_TYPE_RANDOM_RACE                           = 'I06A'
    constant integer ITEM_TYPE_RANDOM_PROFESSION                     = 'I069'
    constant integer ITEM_TYPE_RANDOM_START_LOCATION                 = 'I0ZS'
    constant integer ITEM_TYPE_WARLORD                               = 'I05R'
    constant integer ITEM_TYPE_FREELANCER                            = 'I05Q'

    constant integer ITEM_TYPE_SCRIBE                                = 'I0HC'

    // arena
    constant integer ITEM_TYPE_TICKET_1                              = 'I00Y'
    constant integer ITEM_TYPE_STONE_TOKEN                           = 'fgrg'

    constant integer ITEM_TYPE_TICKET_2                              = 'I00Z'
    constant integer ITEM_TYPE_TALISMAN_OF_THE_WILD                  = 'totw'

    constant integer ITEM_TYPE_TICKET_3                              = 'I011'
    constant integer ITEM_TYPE_ICE_SHARD                             = 'shar'

    constant integer ITEM_TYPE_TICKET_4                              = 'I012'
    constant integer ITEM_TYPE_GLOVES_OF_SPELL_MASTERY               = 'gvsm'

    constant integer ITEM_TYPE_TICKET_5                              = 'I013'
    constant integer ITEM_TYPE_SHAMAN_CLAWS                          = 'shcw'

    constant integer ITEM_TYPE_TICKET_6                              = 'I014'
    constant integer ITEM_TYPE_THUNDERLIZARD_DIAMOND                 = 'thdm'

    constant integer ITEM_TYPE_TICKET_7                              = 'I010'
    constant integer ITEM_TYPE_SHIELD_OF_HONOR                       = 'shhn'

    constant integer ITEM_TYPE_TICKET_8                              = 'I015'
    constant integer ITEM_TYPE_SERATHIL                              = 'srtl'

    constant integer ITEM_TYPE_TICKET_9                              = 'I016'
    constant integer ITEM_TYPE_STONEMAUL_ARENA_MASTER_BELT           = 'I03G'

    // mercenary camps
    constant integer MERCENARY_CAMP_ASHENVALE                        = 'nmr5'
    constant integer MERCENARY_CAMP_BARRENS                          = 'nmr4'
    constant integer MERCENARY_CAMP_BLACK_CITADEL                    = 'nmrf'
    constant integer MERCENARY_CAMP_CITYSCAPE                        = 'nmr8'
    constant integer MERCENARY_CAMP_DALARAN                          = 'nmr9'
    constant integer MERCENARY_CAMP_DUNGEON                          = 'nmra'
    constant integer MERCENARY_CAMP_FELWOOD                          = 'nmr6'
    constant integer MERCENARY_CAMP_ICECROWN_GLACIER                 = 'nmrd'
    constant integer MERCENARY_CAMP_LORDAERON_FALL                   = 'nmr2'
    constant integer MERCENARY_CAMP_LORDAERON_SUMMER                 = 'nmer'
    constant integer MERCENARY_CAMP_LORDAERON_WINTER                 = 'nmr3'
    constant integer MERCENARY_CAMP_NORHTREND                        = 'nmr7'
    constant integer MERCENARY_CAMP_OUTLAND                          = 'nmre'
    constant integer MERCENARY_CAMP_SUNKEN_RUINS                     = 'nmrc'
    constant integer MERCENARY_CAMP_UNDERGROUND                      = 'nmrb'
    constant integer MERCENARY_CAMP_VILLAGE                          = 'nmr0'
    constant integer MERCENARY_CAMP_KUL_TIRAS                        = 'n0OA'
    constant integer MERCENARY_CAMP_ARGUS                            = 'n0J5'
    constant integer MERCENARY_CAMP_EMERALD_DREAM                    = 'n0MM'
    constant integer MERCENARY_CAMP_PANDARIA                         = 'n08L'
    constant integer MERCENARY_CAMP_SEA                              = 'n0JA'
    constant integer MERCENARY_CAMP_SUNSTRIDER_ISLE                  = 'n01S'
    constant integer MERCENARY_CAMP_NEW_CITADEL                      = 'n03D'
    constant integer MERCENARY_CAMP_SKYWALL                          = 'n0BV'
    constant integer MERCENARY_CAMP_FIRELANDS                        = 'n0DB'
    constant integer MERCENARY_CAMP_ABYSSAL_MAW                      = 'n0DD'
    constant integer MERCENARY_CAMP_DEEPHOLM                         = 'n0DM'
    constant integer MERCENARY_CAMP_SHADOWLANDS                      = 'n0ML'
    constant integer MERCENARY_CAMP_NYALOTHA                         = 'n0M4'
    constant integer MERCENARY_CAMP_DESERT                           = 'n0OI'
    constant integer MERCENARY_CAMP_VIP                              = 'n0OP'

    // Professions

    // Herbalist
    constant integer FOUNTAIN_OF_HEALTH                              = 'h087' // doctor
    constant integer ITEM_FOUNTAIN_OF_HEALTH                         = 'I10A' // doctor
    constant integer ITEM_SCROLL_OF_HEALING                          = 'shea' // grand master
    constant integer ITEM_TALISMAN_OF_EVERLASTING                    = 'I025' // master
    constant integer ITEM_POTION_OF_INVULNERABILITY                  = 'pnvu' // adept
    constant integer ITEM_HEALTH_STONE                               = 'hlst' // advanced
    constant integer ITEM_POTION_OF_GREATER_HEALING                  = 'pghe' // novice

    // Alchemist
    constant integer FOUNTAIN_OF_MANA                                = 'h088' // doctor
    constant integer ITEM_FOUNTAIN_OF_MANA                           = 'I10C' // doctor
    constant integer ITEM_SCROLL_OF_MANA                             = 'sman' // grand master
    constant integer ITEM_TALISMAN_OF_SPELL_PROTECTION               = 'I024' // master
    constant integer ITEM_WAND_OF_MANA_STEALING                      = 'woms' // adept
    constant integer ITEM_MANA_STONE                                 = 'mnst' // advanced
    constant integer ITEM_POTION_OF_GREATER_MANA                     = 'pgma' // novice

    // Weapon Smith
    constant integer ITEM_WEAPON_FORGING_HAMMER                      = 'I15V' // doctor
    constant integer ITEM_MYTHICAL_POISON_BLADE                      = 'I15Q' // grand master
    constant integer ITEM_BLESSED_DRAGON_LANCE                       = 'I00R' // master
    constant integer ITEM_DEMON_SLAYER_AXE                           = 'I00Q' // adept
    constant integer ITEM_MITHRIL_LONG_SWORD                         = 'I00P' // advanced
    constant integer ITEM_BOW_OF_FIRE                                = 'I00O' // novice

    // Armorer
    constant integer ITEM_ARMOR_FORGING_HAMMER                       = 'I15U' // doctor
    constant integer ITEM_MYTHICAL_GOLDEN_ARMOR                      = 'I15T' // grand master
    constant integer ITEM_BLESSED_CHAMPION_ARMOR                     = 'I00N' // master
    constant integer ITEM_HEAVY_PLATED_SHIELD                        = 'I00M' // adept
    constant integer ITEM_PLATED_HELMET                              = 'I00L' // advanced
    constant integer ITEM_LIGHT_LEATHER_ARMOR                        = 'I00K' // novice

    // Engineer
    constant integer UPG_MASONRY_ENGINEER                            = 'R085' // doctor
    constant integer POWER_GENERATOR_ENGINEER                        = 'n0OJ' // doctor
    constant integer ITEM_POWER_GENERATOR_ENGINEER                   = 'I19C' // doctor
    constant integer ITEM_SCROLL_OF_REPAIR                           = 'I190' // grand master
    constant integer ITEM_TINY_DEATH_TOWER                           = 'I00S' // master
    constant integer DEATH_TOWER                                     = 'ntt1' // master
    constant integer ADVANCED_DEATH_TOWER                            = 'ntx2' // master
    constant integer ITEM_TINY_BOULDER_TOWER                         = 'I02H' // adept
    constant integer BOULDER_TOWER                                   = 'nbt1' // adept
    constant integer ADANCED_BOULDER_TOWER                           = 'nbt2' // adept
    constant integer ITEM_TINY_COLD_TOWER                            = 'I00U' // advanced
    constant integer COLD_TOWER                                      = 'ndt1' // advanced
    constant integer ADVANCED_COLD_TOWER                             = 'ndt2' // advanced
    constant integer ITEM_TINY_FLAME_TOWER                           = 'I00T' // novice
    constant integer FLAME_TOWER                                     = 'nft1' // novice
    constant integer ADVANCED_FLAME_TOWER                            = 'nft2' // novice

    // Demolition Expert
    constant integer ITEM_NUCLEAR_SILO                               = 'I19M' // doctor
    constant integer NUCLEAR_SILO                                    = 'o0BZ' // doctor
    constant integer TNT_CATAPULT                                    = 'o0BY' // grand master
    constant integer ITEM_SLEDGE_HAMMER                              = 'I193' // master
    // adept is 2 goblin sappers
    constant integer ITEM_EXPLOSIVE_BARRELS                          = 'I19B' // advanced
    constant integer ITEM_GOBLIN_GRENADES                            = 'I137' // advanced
    constant integer ITEM_GOBLIN_LAND_MINES                          = 'gobm' // novice

    constant integer GOBLIN_LAND_MINE                                = 'nglm'
    constant integer EXPLOSIVE_BARREL                                = 'n0LH'

    // Lore Master
    constant integer ITEM_ANKH_OF_REINCARNATION                      = 'ankh' // master
    constant integer ITEM_SCROLL_OF_RESURRECTION                     = 'srrc' // adept
    constant integer ITEM_SCROLL_OF_RESTORATION                      = 'sres' // advanced
    constant integer ITEM_SCROLL_OF_PROTECTION                       = 'spro' // novice

    // Sorcerer
    constant integer ITEM_WAND_OF_SORCERER_ILLUSION                  = 'I039' // master
    constant integer ITEM_WAND_OF_REANIMATION                        = 'I038' // adept
    constant integer ITEM_WAND_OF_THE_WIND                           = 'wcyc' // advanced
    constant integer ITEM_WAND_OF_NEUTRALIZATION                     = 'wneu' // novice

    // Runeforger
    constant integer ITEM_RUNE_OF_GREATER_RESURRECTION               = 'I164' // doctor
    constant integer ITEM_RUNE_OF_LESSER_RESURRECTION_RUNEFORGER     = 'I163' // grand master
    constant integer ITEM_RUNE_OF_REBIRTH_RUNEFORGER                 = 'I032' // master
    constant integer ITEM_RUNE_OF_RESTORATION_RUNEFORGER             = 'I02Z' // adept
    constant integer ITEM_RUNE_OF_DISPEL_MAGIC_RUNEFORGER            = 'I031' // advanced
    constant integer ITEM_RUNE_OF_SPEED_RUNEFORGER                   = 'I030' // novice

    // Dragon Breeder
    constant integer DRAGON_BREEDER_ROOST                            = 'n0DA' // doctor
    constant integer ITEM_DRAGON_BREEDER_ROOST                       = 'I10B' // doctor
    constant integer ITEM_DRAGON_EGG                                 = 'I0B1' // grand master
    constant integer ITEM_GREEN_DRAGON_EGG                           = 'I037' // master
    constant integer ITEM_GREEN_DRAKE_EGG                            = 'I035' // adept
    constant integer ITEM_THARIFAS_EGG                               = 'I036' // advanced
    constant integer ITEM_GREEN_DRAGON_WHELP_EGG                     = 'I034' // novice

    // Jewel Crafter
    constant integer ITEM_GOLDEN_CROWN                               = 'I165' // doctor
    constant integer ITEM_BRACELET                                   = 'I166' // grand master
    constant integer ITEM_JEWEL_AMULET                               = 'I079' // master
    constant integer ITEM_GREEN_GEMSTONE                             = 'I078' // adept
    constant integer ITEM_ENCHANTED_GEMSTONE                         = 'I077' // advanced
    constant integer ITEM_RING_OF_SUPERIORITY                        = 'rnsp' // novice

    // Enchanter
    constant integer ITEM_DOCTOR_ENCHANTING_FORMULA                  = 'I15S' // doctor
    constant integer ITEM_GRAND_MASTER_ENCHANTING_FORMULA            = 'I15R' // grand master

    // Captain
    // TODO Add item types.
    constant integer SHIPYARD                                        = 'h0AT' // doctor
    constant integer ITEM_SHIPYARD                                   = 'I19D' // doctor
    constant integer CANNON                                          = 'h0AU' // doctor shipyard

    // Archaeologist
    constant integer EXCAVATION_SITE                                 = 'n0M2' // doctor
    constant integer ITEM_EXCAVATION_SITE                            = 'I160' // doctor
    // TODO Add item types.

    // Witch Doctor
    constant integer ITEM_PEACE_WARDS                                = 'I0R4' // doctor
    constant integer ITEM_POWER_WARDS                                = 'I189' // grand master
    constant integer ITEM_HEALING_WARDS                              = 'whwd' // master
    constant integer ITEM_MANA_WARDS                                 = 'I09I' // adept
    constant integer ITEM_STASIS_TRAPS                               = 'I09K' // advanced
    constant integer ITEM_SENTRY_WARDS                               = 'wswd' // novice

    // Merchant
    // TODO Add item types.
    constant integer ITEM_AMULET_OF_HAGGLE                           = 'I18Y' // grand master
    constant integer ITEM_MERCHANT_SHOP                              = 'I18Z' // doctor
    constant integer MERCHANT_SHOP                                   = 'h0AR' // doctor

    // Farmer
    constant integer FARM_FARMER                                     = 'h0KW'
    constant integer ITEM_TINY_FARM_FARMER                           = 'I0JU'
    constant integer GRANARY                                         = 'h0M7'
    constant integer ITEM_TINY_GRANARY                               = 'I0KA'
    constant integer WATER_SUPPLY                                    = 'h0KX'
    constant integer ITEM_TINY_WATER_SUPPLY                          = 'I0JW'
    constant integer WIND_MILL                                       = 'h0M8'
    constant integer ITEM_TINY_WIND_MILL                             = 'I0KB'
    constant integer ANIMAL_PEN_FARMER                               = 'h0AN' // grand master
    constant integer ITEM_TINY_ANIMAL_PEN                            = 'I18G' // grand master
    constant integer BARN                                            = 'h0AS' // doctor
    constant integer ITEM_TINY_BARN                                  = 'I195' // doctor

    constant integer COW                                             = 'n0DX'
    constant integer CHICKEN                                         = 'nech'

    // Tamer
    constant integer ITEM_SMALL_BAIT                                 = 'I0L4' // rank 1
    constant integer ITEM_BAIT                                       = 'I0L5' // rank 2
    constant integer ITEM_ADVANCED_BAIT                              = 'I0L6' // rank 3
    constant integer ITEM_MONSTER_LURE                               = 'I0L2' // rank 4
    constant integer ITEM_SCROLL_OF_CHARM                            = 'I19R' // grand master
    constant integer ITEM_CAGE                                       = 'I19S' // doctor
    constant integer CAGE_TAMER                                      = 'h0AV' // doctor

    // Inscriptor
    constant integer ITEM_DOCTOR_GLYPH                               = 'I15X'
    constant integer ITEM_GRAND_MASTER_GLYPH                         = 'I15W'
    constant integer ITEM_MASTER_GLYPH                               = 'I0NR'
    constant integer ITEM_ADVANCED_GLYPH                             = 'I0NQ'
    constant integer ITEM_ADEPT_GLYPH                                = 'I0NP'
    constant integer ITEM_NOVICE_GLYPH                               = 'I0NO'

    // Necromancer
    constant integer ITEM_ROD_OF_NECROMANCY                          = 'rnec' // rank 1
    constant integer ITEM_WAND_OF_CORPSES                            = 'I0S9' // rank 2
    constant integer ITEM_SACRIFICAL_SCULL                           = 'skul' // rank 3
    constant integer ITEM_BOOK_OF_THE_DEAD                           = 'fgsk' // rank 4
    constant integer ITEM_SCROLL_OF_ANIMATE_DEAD                     = 'sand' // rank 5
    constant integer ITEM_TINY_NECROMANCER_GRAVEYARD                 = 'I110' // rank 6
    constant integer NECROMANCER_GRAVEYARD                           = 'u038'
    constant integer NECROMANCER_MEAT_WAGON                          = 'u03M'

    // Golem Sculptor
    constant integer ITEM_TINY_MUD_GOLEM                             = 'I0SJ' // rank 1
    constant integer ITEM_TINY_WAR_GOLEM                             = 'I0SL' // rank 2
    constant integer ITEM_TINY_SIEGE_GOLEM                           = 'I0SK' // rank 3
    constant integer ITEM_TINY_FLESH_GOLEM                           = 'I0SM' // rank 4
    constant integer ITEM_TINY_DIVINE_GOLEM                          = 'I186' // rank 5
    constant integer ITEM_TINY_GOLEM_FACTORY                         = 'I185' // rank 6

    constant integer GOLEM_FACTORY                                   = 'n0O6'
    constant integer DIVINE_GOLEM_GOLEM_SCULPTOR                     = 'n0O7'

    // Combiner
    // TODO Add item types.

    // Hunter
    constant integer HUNTING_CAMP                                    = 'n0OF' // doctor
    constant integer ITEM_HUNTING_CAMP                               = 'I194' // doctor
    constant integer HUNTING_HAWK                                    = 'n0OG' // grand master

    // Critters
    constant integer STAG                                            = 'nder'
    constant integer PIG                                             = 'npig'
    constant integer SHEEP                                           = 'nshe'
    constant integer FROG                                            = 'nfro'
    constant integer SNOWY_OWL                                       = 'nsno'
    constant integer RABBIT                                          = 'necr'
    constant integer HERMIT_CRAB                                     = 'nhmc'
    constant integer CRAB                                            = 'ncrb'
    constant integer FEL_BOAR                                        = 'nfbr'
    constant integer BEE                                             = 'n0DO'
    constant integer RACCOON                                         = 'nrac'
    constant integer ALBATROSS                                       = 'nalb'
    constant integer SKINK                                           = 'nskk'
    constant integer RAT                                             = 'nrat'
    constant integer DOG                                             = 'ndog'
    constant integer DUNE_WORM                                       = 'ndwm'
    constant integer PENGUIN                                         = 'npng'
    constant integer SEAL                                            = 'nsea'
    constant integer VULTURE                                         = 'nvul'
    constant integer TALBUK                                          = 'n0JM'
    constant integer RAVEN                                           = 'n0KK'
    constant integer PARROT                                          = 'n0KL'
    constant integer CAMEL                                           = 'n0MZ'
    constant integer FOX                                             = 'n0B5'
    constant integer HEDGEHOG                                        = 'n0BR'
    constant integer PIGEON                                          = 'n0BS'
    constant integer TURTLE                                          = 'n0OO'

    constant integer ITEM_ANTLER                                     = 'I0VS'
    constant integer ITEM_PIG_SKIN                                   = 'I0VT'
    constant integer ITEM_SHEEP_WOOL                                 = 'I0VU'
    constant integer ITEM_FROG_LEGS                                  = 'I0VY'
    constant integer ITEM_SNOWY_OWL_FEATHER                          = 'I0WB'
    constant integer ITEM_RABBIT_SKIN                                = 'I0WC'
    constant integer ITEM_HERMIT_CRAB_SHELL                          = 'I0WD'
    constant integer ITEM_CRAB_SHELL                                 = 'I0WE'
    constant integer ITEM_FEL_BOAR_SKIN                              = 'I0WF'
    constant integer ITEM_BEE_STING                                  = 'I0WG'
    constant integer ITEM_RACOON_SKIN                                = 'I0ZM'
    constant integer ITEM_ALBATROSS_PLUMAGE                          = 'I0ZN'
    constant integer ITEM_SKINK_SKIN                                 = 'I0HH'
    constant integer ITEM_RATS_TAIL                                  = 'I0HF'
    constant integer ITEM_DOG_SKIN                                   = 'I0K0'
    constant integer ITEM_DUNE_WORM_PISS                             = 'I0HI'
    constant integer ITEM_PENGUIN_WINGS                              = 'I0I9'
    constant integer ITEM_SEAL_BLUBBER                               = 'I0JI'
    constant integer ITEM_VULTURE_FEATHER                            = 'I0JJ'
    constant integer ITEM_TALBUK_ANTLER                              = 'I0JK'
    constant integer ITEM_RAVEN_FEATHER                              = 'I0JL'
    constant integer ITEM_PARROT_FEATHER                             = 'I0JR'
    constant integer ITEM_CAMEL_HUMPS                                = 'I0JZ'
    constant integer ITEM_FOX_SKIN                                   = 'I0ZC'
    constant integer ITEM_HEDGEHOG_SKIN                              = 'I0ZP'
    constant integer ITEM_PIGEON_FEATHER                             = 'I0ZW'
    constant integer ITEM_TURTLE_SHELL                               = 'I19V'

    // Miner
    constant integer ITEM_PICKAXE                                    = 'I0W7'

    // Cook
    constant integer FIRE_PIT_COOK                                   = 'h0U1'
    constant integer ITEM_FIRE_PIT                                   = 'I0WO'

    // Fisherman
    constant integer ITEM_FISHING_PORT                               = 'I0WY'
    constant integer FISHING_PORT                                    = 'h0U2'
    constant integer ITEM_FISH_MARKET                                = 'I0X8'
    constant integer FISH_MARKET_FISHERMAN                           = 'n0J8'
    // TODO Add item types.

    // Prospector
    constant integer ITEM_GOLD_DRILL                                 = 'I11X'
    constant integer GOLD_PANNING                                    = 'h0XX'
    constant integer ITEM_TINY_GOLD_PANNING                          = 'I11Y'

    // Lumberjack
    constant integer SAWMILL                                         = 'h0UH'
    constant integer ITEM_TINY_SAWMILL                               = 'I0XN'

    // Warlock
    constant integer ITEM_WAND_OF_DRAIN                              = 'I0YH' // rank 1
    constant integer ITEM_INFERNO_STONE                              = 'infs' // rank 2
    constant integer ITEM_DEMON_BLOOD                                = 'I0Y7' // rank 3
    constant integer ITEM_TINY_DEMON_GATE                            = 'I0YG' // rank 4
    constant integer ITEM_SPIKED_COLLAR                              = 'fgfh' // grand master
    constant integer ITEM_DEMONIC_FIGURE                             = 'fgdg' // grand master
    constant integer ITEM_TINY_FEL_FOUNTAIN                          = 'I15Y' // doctor
    constant integer FEL_FOUNTAIN_WARLOCK                            = 'n0M0'

    // Thief
    constant integer SAFE                                            = 'h0OH'
    constant integer ITEM_TINY_SAFE                                  = 'I0FN'
    constant integer THIEVES_GUILD_THIEF                             = 'n076'
    constant integer ITEM_TINY_THIEVES_GUILD_THIEF                   = 'I10R'

    // Astromancer
    constant integer ITEM_NAVIGATION_SCROLL                          = 'I12V'
    constant integer ITEM_TINY_PORTAL_ASTROMANCER                    = 'I12W'
    constant integer ITEM_FLARE_GUN                                  = 'fgun'
    constant integer ITEM_METEOR_STONE                               = 'I0FN'
    constant integer ARCANE_OBSERVATORY_ASTROMANCER                  = 'n0MO'
    constant integer ITEM_TINY_ARCANE_OBSERVATORY_ASTROMANCER        = 'I12Z'
    constant integer MOON                                            = 'n0OL' // grand master
    constant integer ITEM_MOON                                       = 'I19F' // grand master
    constant integer STAR                                            = 'n0OK' // doctor
    constant integer ITEM_STAR                                       = 'I19E' // doctor

    // Bard
    // TODO Add item types.
    constant integer RECORD_PLAYER                                   = 'h0G0'
    constant integer ITEM_RECORD_PLAYER                              = 'I14Q'

    // All Races Engineer
    constant integer CHEST                                           = 'h0Y9'
    constant integer ITEM_TINY_CHEST                                 = 'I134'

    // Items

    // Holy Set
    constant integer ITEM_HOLY_CREST                                 = 'I16G'
    constant integer ITEM_HOLY_BOOTS                                 = 'I16H'
    constant integer ITEM_HOLY_GAUNTLET                              = 'I16I'
    constant integer ITEM_HOLY_ARMOR                                 = 'I16J'
    constant integer ITEM_HOLY_SHIELD                                = 'I16K'
    constant integer ITEM_HOLY_SWORD                                 = 'I16L'

    constant integer ITEM_BOOTS_OF_TELEPORTATION                     = 'I0YI'
    constant integer ITEM_GOBLIN_TOOL_BOX                            = 'I0Q1'
    constant integer ITEM_SPADE                                      = 'I19U'

    constant integer ITEM_GOLD_COINS                                 = 'gold'
    constant integer ITEM_GOLD_BARS                                  = 'I055'

    constant integer ITEM_ROCKS                                      = 'I095'
    constant integer ITEM_ORE_GOLD                                   = 'I08A'
    constant integer ITEM_ORE_IRON                                   = 'I089'
    constant integer ITEM_ORE_SILVER                                 = 'I08B'

    constant integer ITEM_GEM_AMBER                                  = 'I0OF'
    constant integer ITEM_GEM_AMETHYST                               = 'I0OG'
    constant integer ITEM_GEM_AQUAMARINE                             = 'I0OH'
    constant integer ITEM_GEM_DIAMOND                                = 'I0OI'
    constant integer ITEM_GEM_EMERALD                                = 'I0OJ'
    constant integer ITEM_GEM_JADE                                   = 'I0OK'
    constant integer ITEM_GEM_MALACHITE                              = 'I0OL'
    constant integer ITEM_GEM_OPAL                                   = 'I0OM'
    constant integer ITEM_GEM_RUBY                                   = 'I0ON'
    constant integer ITEM_GEM_SAPPHIRE                               = 'I0OO'
    constant integer ITEM_GEM_TOPAZ                                  = 'I0OP'
    constant integer ITEM_GEM_TURQUOISE                              = 'I0OQ'

    constant integer ITEM_CHRISTMAS_PRESENT                          = 'I0AP'
    constant integer ITEM_EASTER_EGG                                 = 'I05I'
    constant integer ITEM_CANDY                                      = 'I146'

    // Food
    constant integer ITEM_BUNDLE_OF_WHEAT                            = 'I0KT'
    constant integer ITEM_APPLE                                      = 'I141'
    constant integer ITEM_BANANA                                     = 'I0S8'
    constant integer ITEM_CHERRY                                     = 'I0EJ'
    constant integer ITEM_FISH                                       = 'I0KN'
    constant integer ITEM_GARLIC                                     = 'I0WW'
    constant integer ITEM_LEMON                                      = 'I0U2'
    constant integer ITEM_MEAT                                       = 'I0X1'
    constant integer ITEM_MILK                                       = 'I0FY'
    constant integer ITEM_ORANGE                                     = 'I0U3'
    constant integer ITEM_PLUM                                       = 'I0FP'
    constant integer ITEM_PUMPKIN                                    = 'I140'
    constant integer ITEM_WOOL                                       = 'I0FZ'

    // Tomes
    constant integer TOME_OF_AGILITY                                 = 'tdex'
    constant integer TOME_OF_AGILITY_2                               = 'tdx2'
    constant integer TOME_OF_EXPERIENCE                              = 'texp'
    constant integer TOME_OF_GREATER_EXPERIENCE                      = 'tgxp'
    constant integer TOME_OF_INTELLIGENCE                            = 'tint'
    constant integer TOME_OF_INTELLIGENCE_2                          = 'tin2'
    constant integer TOME_OF_KNOWLEDGE                               = 'tpow'
    constant integer TOME_OF_STRENGTH                                = 'tstr'
    constant integer TOME_OF_STRENGTH_2                              = 'tst2'
    constant integer TOME_OF_POWER                                   = 'tkno'
    constant integer TOME_OF_ARMOR                                   = 'I13G'
    constant integer TOME_OF_DAMAGE                                  = 'I13E'
    constant integer TOME_OF_MOVEMENT                                = 'I1A8'
    constant integer TOME_OF_SIGHT                                   = 'I1A7'
    constant integer TOME_OF_MAGIC                                   = 'I1A4'
    constant integer TOME_OF_CHAOS                                   = 'I1A5'
    constant integer TOME_OF_DIVINITY                                = 'I1A6'
    constant integer TOME_OF_SKILL_POINTS                            = 'I156'
    constant integer MANUAL_OF_HEALTH                                = 'manh'
    constant integer MANUAL_OF_MANA                                  = 'I13F'
    constant integer TOME_OF_LIFE_REGENARTION                        = 'I1AB'
    constant integer TOME_OF_MANA_REGENERATION                       = 'I1AC'

    // Dungeon
    constant integer ITEM_SPIKE_TRAPS                                = 'I0GH'

    // Creeps
    constant integer BARBED_ARACHNATHID_WITH_BURROW                  = 'nanm'
    constant integer BARBED_ARACHNATHID_BURROWED                     = 'nbnb'
    constant integer SAND_WORM                                       = 'n0N2'
    constant integer SAND_WORM_BURROWED                              = 'n0N3'
    constant integer LIVING_STATUE                                   = 'n0N7'
    constant integer LIVING_STATUE_M                                 = 'n0N8' // standing
    constant integer CAGE                                            = 'o043'
    constant integer CRATES_0                                        = 'o0BQ'
    constant integer CRATES_1                                        = 'o0BR'
    constant integer BARREL_0                                        = 'o0C1'
    constant integer BARREL_1                                        = 'o0C2'
    constant integer PIRATE                                          = 'h0AM'
    constant integer EGG_SACK                                        = 'o0AN'
    constant integer EXPLOSIVE_BARREL_CREEP                          = 'h0P9'

    // Housing
    constant integer CARETAKER                                       = 'n0O2'
    constant integer LEAVE_HOUSING                                   = 'o0BS'
    constant integer ITEM_HOUSE_KEY                                  = 'I16O'

    constant integer ENTER_COMMON_HOUSING                            = 'o0C3'
    constant integer LEAVE_COMMON_HOUSING                            = 'o0C4'

    // Neutral Buildings
    constant integer TRAINER                                         = 'n0OQ'
    constant integer LIBRARY                                         = 'n075'

    // Freelancer
    constant integer FREELANCER_TIER_1                               = HIDEOUT
    constant integer FREELANCER_TIER_2                               = FORTIFIED_HIDEOUT
    constant integer FREELANCER_TIER_3                               = GUARDIANS_CITADEL
    constant integer FREELANCER_LABORATORY                           = 'h01V'
    constant integer FREELANCER_SHOP                                 = 'h01S'
    constant integer FREELANCER_MERCENARY_CAMP                       = 'h01U'
    constant integer FREELANCER_HOUSING                              = 'h081'
    constant integer FREELANCER_TOWER                                = 'n055'
    constant integer FREELANCER_ADVANCED_TOWER                       = 'n056'
    constant integer FREELANCER_SHIPYARD                             = 'o09W'

    constant integer UPG_FREELANCER_MAGIC_SENTRY                     = 'R0EM'
    constant integer UPG_FREELANCER_MASONRY                          = 'R00W'
    constant integer UPG_FREELANCER_CHEAP_EVOLUTION                  = UPG_CHEAP_EVOLUTION

    constant integer CREEP_DARK_WIZARD                               = 'nwzd'
    constant integer CREEP_UNBROKEN_DARK_WEAVER                      = 'nubw'
    constant integer CREEP_DOOM_GUARD                                = 'nbal'
    constant integer CREEP_WRAITH                                    = 'ngh2'
    constant integer CREEP_SPIDER_CRAB                               = 'nsc2'
    constant integer CREEP_HARPY                                     = 'nhrh'
    constant integer CREEP_GREEN_DRAKE                               = 'ngdk'
    constant integer CREEP_DARK_TROLL_PRIEST                         = 'ndth'
    constant integer CREEP_BANDIT_LORD                               = 'nbld'
    constant integer CREEP_SEA_GIANT_BEHEMOTH                        = 'nsgb'
    constant integer CREEP_EREDAR_WARLOCK                            = 'nerw'

    constant integer ITEM_FREELANCER_TIER_1                          = 'I018'
    constant integer ITEM_FREELANCER_TIER_2                          = 'I0NG'
    constant integer ITEM_FREELANCER_TIER_3                          = 'I0NH'
    constant integer ITEM_FREELANCER_LABORATORY                      = 'I0NF'
    constant integer ITEM_FREELANCER_MERCENARY_CAMP                  = 'I0NE'
    constant integer ITEM_FREELANCER_SHOP                            = 'I0ND'
    constant integer ITEM_FREELANCER_HOUSING                         = 'I0TZ'
    constant integer ITEM_FREELANCER_TOWER                           = 'I0NB'
    constant integer ITEM_FREELANCER_ADVANCED_TOWER                  = 'I0NC'
    constant integer ITEM_FREELANCER_SHIPYARD                        = 'I0X3'

    constant integer FREELANCER_CITIZEN_MALE                         = NEUTRAL_CITIZEN
    constant integer FREELANCER_CITIZEN_FEMALE                       = NEUTRAL_CITIZEN_FEMALE
    constant integer FREELANCER_CHILD                                = NEUTRAL_CHILD
    constant integer FREELANCER_PET                                  = 'n00Q'

    // Old Horde
    constant integer OLD_HORDE_TIER_1                                = 'o07P'
    constant integer OLD_HORDE_TIER_2                                = 'o089'
    constant integer OLD_HORDE_TIER_3                                = 'o08A'
    constant integer OLD_HORDE_FARM                                  = 'o07Q'
    constant integer OLD_HORDE_ALTAR                                 = 'o082'
    constant integer OLD_HORDE_MILL                                  = 'o07S'
    constant integer OLD_HORDE_BLACKSMITH                            = 'o07T'
    constant integer OLD_HORDE_BARRACKS                              = 'o07R'
    constant integer OLD_HORDE_SHOP                                  = 'o09U'
    constant integer OLD_HORDE_WATCH_TOWER                           = 'o07U'
    constant integer OLD_HORDE_GUARD_TOWER                           = 'o086'
    constant integer OLD_HORDE_CANNON_TOWER                          = 'o087'
    constant integer OLD_HORDE_TEMPLE_OF_THE_DAMNED                  = 'u030'
    constant integer OLD_HORDE_GOBLIN_ALCHEMIST                      = 'o084'
    constant integer OLD_HORDE_DRAGON_ROOST                          = 'o085'
    constant integer OLD_HORDE_OGRE_MOUND                            = 'o083'
    constant integer OLD_HORDE_FOUNDRY                               = 'o07V'
    constant integer OLD_HORDE_OIL_PLATFORM                          = 'o07X'
    constant integer OLD_HORDE_OIL_REFINERY                          = 'o088'
    constant integer OLD_HORDE_SHIPYARD                              = 'o07W'

    constant integer UPG_HORDE_BACKPACK                              = 'R0FG'
    constant integer UPG_HORDE_BERSERKER_REGENERATION                = 'R0FT'
    constant integer UPG_HORDE_BERSERKER_SCOUTING                    = 'R0FR'
    constant integer UPG_HORDE_DEATH_AND_DECAY                       = 'R0FX'
    constant integer UPG_HORDE_HASTE                                 = 'R0FV'
    constant integer UPG_HORDE_OGRE_MAGES                            = 'R0FC'
    constant integer UPG_HORDE_RAISE_DEAD                            = 'R0FZ'
    constant integer UPG_HORDE_LIGHTER_AXES                          = 'R0FS'
    constant integer UPG_HORDE_TROLL_BERSERKER_TRAINING              = 'R0FK'
    constant integer UPG_HORDE_UNHOLY_ARMOR                          = 'R0FW'
    constant integer UPG_HORDE_UPGRADE_CANNONS                       = 'R0FB'
    constant integer UPG_HORDE_UPGRADE_CATAPULT                      = 'R0FE'
    constant integer UPG_HORDE_UPGRADE_SHIELDS                       = 'R0FI'
    constant integer UPG_HORDE_UPGRADE_SHIP_ARMOR                    = 'R0FA'
    constant integer UPG_HORDE_UPGRADE_THROWING_AXES                 = 'R0FJ'
    constant integer UPG_HORDE_UPGRADE_WEAPONS                       = 'R0FH'
    constant integer UPG_HORDE_UPGRADE_WHIRLWIND                     = 'R0FY'

    constant integer OLD_HORDE_WORKER_BASE                           = 'o07N'
    constant integer OLD_HORDE_WORKER_NORMAL                         = 'o07O'
    constant integer OLD_HORDE_WORKER_ADVANCED                       = 'o07Z'
    constant integer OLD_HORDE_OGRE                                  = 'n0I9'
    constant integer OLD_HORDE_OGRE_MAGE                             = 'n0IE'
    constant integer OLD_HORDE_TROLL_AXETHROWER                      = 'n0I8'
    constant integer OLD_HORDE_TROLL_BERSERKER                       = 'n0IA'
    constant integer OLD_HORDE_CATPULT                               = 'o081'
    constant integer OLD_HORDE_DEATH_KNIGHT                          = 'o07L'
    constant integer OLD_HORDE_DRAGON                                = 'n0IC'
    constant integer OLD_HORDE_GREAT_SEE_TURTLE                      = 'n0IF'
    constant integer OLD_HORDE_GOBLIN_SAPPERS                        = 'n0IB'
    constant integer OLD_HORDE_GOBLIN_ZEPPELIN                       = 'n0ID'
    constant integer OLD_HORDE_GRUNT                                 = 'o080'
    constant integer OLD_HORDE_EYE_OF_KILROGG                        = 'n0J0'
    constant integer OLD_HORDE_OIL_TANKER                            = 'o07Y'

    constant integer OLD_HORDE_HOUSING                               = 'h080'
    constant integer OLD_HORDE_CITIZEN_MALE                          = 'n0AW'
    constant integer OLD_HORDE_CITIZEN_FEMALE                        = 'n0AX'
    constant integer OLD_HORDE_CHILD                                 = 'n0AY'
    constant integer OLD_HORDE_PET                                   = 'n0AZ'

    // Alliance of Lordaeron
    constant integer ALLIANCE_TIER_1                                 = 'h0S3'
    constant integer ALLIANCE_TIER_2                                 = 'h0TE'
    constant integer ALLIANCE_TIER_3                                 = 'h0TF'
    constant integer ALLIANCE_FARM                                   = 'h0TG'
    constant integer ALLIANCE_CHURCH                                 = 'h0TN'
    constant integer ALLIANCE_MILL                                   = 'h0TI'
    constant integer ALLIANCE_BLACKSMITH                             = 'h0TJ'
    constant integer ALLIANCE_BARRACKS                               = 'h0TH'
    constant integer ALLIANCE_SHOP                                   = 'h0TP'
    constant integer ALLIANCE_SCOUT_TOWER                            = 'h0TV'
    constant integer ALLIANCE_GUARD_TOWER                            = 'h0TZ'
    constant integer ALLIANCE_CANNON_TOWER                           = 'h0U0'
    constant integer ALLIANCE_MAGE_TOWER                             = 'h0TK'
    constant integer ALLIANCE_GNOMISH_INVENTOR                       = 'h0TL'
    constant integer ALLIANCE_AVIARY                                 = 'h0TM'
    constant integer ALLIANCE_STABLES                                = 'h0TU'
    constant integer ALLIANCE_SHIPYARD                               = 'o08K'
    constant integer ALLIANCE_OIL_PLATFORM                           = 'o08M'

    constant integer UPG_ALLIANCE_BACKPACK                           = 'R0G0'
    constant integer UPG_ALLIANCE_BLIZZARD                           = 'R0HR'
    constant integer UPG_ALLIANCE_ELVEN_RANGER_TRAINING              = 'R0G2'
    constant integer UPG_ALLIANCE_HEALING                            = 'R0HL'
    constant integer UPG_ALLIANCE_INVISIBILITY                       = 'R0HP'
    constant integer UPG_ALLIANCE_PALADINS                           = 'R0HK'
    constant integer UPG_ALLIANCE_POLYMORPH                          = 'R0HQ'
    constant integer UPG_ALLIANCE_SLOW                               = 'R0HO'
    constant integer UPG_ALLIANCE_UPGRADE_ARROWS                     = 'R0G1'
    constant integer UPG_ALLIANCE_UPGRADE_BALLISTAS                  = 'R0HS'
    constant integer UPG_ALLIANCE_UPGRADE_SHIELDS                    = 'R0HN'
    constant integer UPG_ALLIANCE_UPGRADE_SWORDS                     = 'R0HM'

    constant integer ALLIANCE_WORKER_BASE                            = 'h0S2'
    constant integer ALLIANCE_WORKER_NORMAL                          = 'h0TW'
    constant integer ALLIANCE_WORKER_ADVANCED                        = 'h0TX'
    constant integer ALLIANCE_FOOTMAN                                = 'h0TS'
    constant integer ALLIANCE_ELVEN_ARCHER                           = 'n0J2'
    constant integer ALLIANCE_ELVEN_RANGER                           = 'n0J3'
    constant integer ALLIANCE_KNIGHT                                 = 'h0TT'
    constant integer ALLIANCE_PALADIN                                = 'h0WF'
    constant integer ALLIANCE_MAGE                                   = 'h0TO'
    constant integer ALLIANCE_BALLISTA                               = 'e029'
    constant integer ALLIANCE_DEMOLITION_SQUAD                       = 'n0J1'
    constant integer ALLIANCE_GRYPHON_RIDER                          = 'h0WO'
    constant integer ALLIANCE_FLYING_MACHINE                         = 'h0TQ'
    constant integer ALLIANCE_OIL_TANKER                             = 'h0TY'

    constant integer ALLIANCE_HOUSING                                = 'h04X'
    constant integer ALLIANCE_CITIZEN_MALE                           = 'n0AP'
    constant integer ALLIANCE_CITIZEN_FEMALE                         = 'n0AQ'
    constant integer ALLIANCE_CHILD                                  = 'n0AS'
    constant integer ALLIANCE_PET                                    = 'n0AV'

    // Human
    constant integer ITEM_HUMAN_TIER_1                               = 'I02P'
    constant integer ITEM_HUMAN_TIER_2                               = 'I0L7'
    constant integer ITEM_HUMAN_TIER_3                               = 'tcas'
    constant integer ITEM_HUMAN_FARM                                 = 'tfar'
    constant integer ITEM_HUMAN_SCOUT_TOWER                          = 'tsct'
    constant integer ITEM_HUMAN_GUARD_TOWER                          = 'I0LH'
    constant integer ITEM_HUMAN_CANNON_TOWER                         = 'I0LI'
    constant integer ITEM_HUMAN_ARCANE_TOWER                         = 'I0LJ'
    constant integer ITEM_HUMAN_ALTAR                                = 'tbak'
    constant integer ITEM_HUMAN_BARRACKS                             = 'tbar'
    constant integer ITEM_HUMAN_BLACK_SMITH                          = 'tbsm'
    constant integer ITEM_HUMAN_MILL                                 = 'tlum'
    constant integer ITEM_HUMAN_ARCANE_SANCTUM                       = 'I0LC'
    constant integer ITEM_HUMAN_GRYPHON_AVIARY                       = 'I0LB'
    constant integer ITEM_HUMAN_WORKSHOP                             = 'I0LA'
    constant integer ITEM_HUMAN_SHOP                                 = 'I0LD'
    constant integer ITEM_HUMAN_SHIPYARD                             = 'I0LG'
    constant integer ITEM_HUMAN_SPECIAL_BUILDING                     = 'I0LF'
    constant integer ITEM_HUMAN_HOUSING                              = 'I0LE'

    constant integer HUMAN_CITIZEN_MALE                              = 'n00E'
    constant integer HUMAN_CITIZEN_FEMALE                            = 'n00F'
    constant integer HUMAN_CHILD                                     = 'n0CV'
    constant integer HUMAN_PET                                       = 'n00Q'
    constant integer HUMAN_HOUSING                                   = 'h00R'

    constant integer HUMAN_SHIPYARD                                  = 'h010'
    constant integer HUMAN_TRANSPORT_SHIP                            = 'hbot'
    constant integer HUMAN_FRIGATE                                   = 'hdes'
    constant integer HUMAN_BATTLESHIP                                = 'hbsh'

    constant integer UPG_HUMAN_BACKPACK                              = 'Rhpm'
    constant integer UPG_HUMAN_SUNDERING_BLADES                      = 'Rhsb'
    constant integer UPG_HUMAN_FLARE                                 = 'Rhfl'
    constant integer UPG_HUMAN_ARCANE_OBSERVATORY                    = 'R022' // special building

    constant integer HUMAN_ARCANE_OBSERVATORY                        = 'h01Q' // special building

    // Orc
    constant integer ITEM_ORC_TIER_1                                 = 'tgrh'
    constant integer ITEM_ORC_TIER_2                                 = 'I0LS'
    constant integer ITEM_ORC_TIER_3                                 = 'I0LQ'
    constant integer ITEM_ORC_BURROW                                 = 'I0LM'
    constant integer ITEM_ORC_WATCH_TOWER                            = 'I0LW'
    constant integer ITEM_ORC_ALTAR                                  = 'I0LP'
    constant integer ITEM_ORC_BARRACKS                               = 'I0LN'
    constant integer ITEM_ORC_MILL                                   = 'I0LV'
    constant integer ITEM_ORC_LODGE                                  = 'I0LR'
    constant integer ITEM_ORC_TOTEM                                  = 'I0LT'
    constant integer ITEM_ORC_BEASTIARY                              = 'I0LO'
    constant integer ITEM_ORC_VOODOO_LOUNGE                          = 'I0LU'
    constant integer ITEM_ORC_SHIPYARD                               = 'I0LY'
    constant integer ITEM_ORC_SPECIAL_BUILDING                       = 'I0LZ'
    constant integer ITEM_ORC_HOUSING                                = 'I0LX'

    constant integer UPG_ORC_BACKPACK                                = 'Ropm'
    constant integer UPG_FEL                                         = 'R01Y' // special building

    constant integer ORC_CITIZEN_MALE                                = 'n00I'
    constant integer ORC_CITIZEN_FEMALE                              = 'n00J'
    constant integer ORC_PET                                         = 'n00U'
    constant integer ORC_CHILD                                       = 'n0CW'
    constant integer ORC_HOUSING                                     = 'h00V'

    constant integer ORC_SHIPYARD                                    = 'o009'
    constant integer ORC_TRANSPORT_SHIP                              = 'obot'
    constant integer ORC_JUGGERNAUGHT                                = 'ojgn'
    constant integer ORC_FRIGATE                                     = 'odes'

    constant integer FOUNTAIN_OF_BLOOD                               = 'o00F' // special building
    constant integer FEL_DRAGON_ROOST                                = 'ndrb'

    // Undead
    constant integer UNDEAD_CRYPT_FIEND_BURROWED                     = 'ucrm'
    constant integer CARRION_BEETLE_1                                = 'ucs1'
    constant integer CARRION_BEETLE_2                                = 'ucs2'
    constant integer CARRION_BEETLE_3                                = 'ucs3'
    constant integer CARRION_BEETLE_2_BURROWED                       = 'ucsB'
    constant integer CARRION_BEETLE_3_BURROWED                       = 'ucsC'

    constant integer UNDEAD_CITIZEN_MALE                             = 'n00G'
    constant integer UNDEAD_CITIZEN_FEMALE                           = 'n00H'
    constant integer UNDEAD_CHILD                                    = 'n0IT'
    constant integer UNDEAD_PET                                      = 'n00R'
    constant integer UNDEAD_HOUSING                                  = 'h00U'

    constant integer UNDEAD_SHIPYARD                                 = 'u00K'
    constant integer UNDEAD_TRANSPORT_SHIP                           = 'ubot'
    constant integer UNDEAD_BATTLESHIP                               = 'uubs'
    constant integer UNDEAD_FRIGATE                                  = 'udes'

    constant integer UPG_UNDEAD_LICH_KING                            = 'R020' // special building

    constant integer UNDEAD_LICH_KING                                = 'n037' // special building

    // Night Elf
    constant integer ELF_CITIZEN_MALE                                = 'n00O'
    constant integer ELF_CITIZEN_FEMALE                              = 'n00P'
    constant integer ELF_HOUSING                                     = 'e016'

    constant integer ELF_SHIPYARD                                    = 'e009'
    constant integer ELF_TRANSPORT_SHIP                              = 'etrs'
    constant integer ELF_BATTLESHIP                                  = 'ebsh'
    constant integer ELF_FRIGATE                                     = 'edes'

    constant integer UPG_ELF_WORLD_TREE                              = 'R01Z'

    constant integer ELF_WORLD_TREE                                  = 'o00G' // special building

    // Blood Elf
    constant integer BLOOD_ELF_TOWN_HALL                             = 'h009' // town hall
    constant integer BLOOD_ELF_KEEP                                  = 'h00A' // keep
    constant integer BLOOD_ELF_CASTLE                                = 'h00B' // castle
    constant integer BLOOD_ELF_SCOUT_TOWER                           = 'h00I' // tower
    constant integer BLOOD_ELF_GUARD_TOWER                           = ELF_GUARD_TOWER // guard tower
    constant integer BLOOD_ELF_ARCANE_TOWER                          = 'h0WK' // arcane tower
    constant integer BLOOD_ELF_ARCANE_SACNTUM                        = 'h00E' // arcane
    constant integer BLOOD_ELF_ALTAR                                 = 'h0GH' // altar
    constant integer BLOOD_ELF_FARM                                  = 'h0GI' // farm
    constant integer BLOOD_ELF_ARCANE_VAULT                          = 'h00H' // shop
    constant integer BLOOD_ELF_BARRACKS                              = 'h00C' // barracks
    constant integer BLOOD_ELF_BLACK_SMITH                           = 'h00D' // blacksmith
    constant integer BLOOD_ELF_LUMBER_MILL                           = 'h00F' // lumber mill
    constant integer BLOOD_ELF_WORKSHOP                              = 'h013' // workshop
    constant integer BLOOD_ELF_PHOENIX_EGG                           = 'h04P' // aviary
    constant integer BLOOD_ELF_MAGIC_VAULT                           = 'n038' // special building
    constant integer BLOOD_ELF_SHIPYARD                              = 'h0WJ'

    constant integer UPG_BLOOD_ELF_BACKPACK                          = 'R0DY'
    constant integer UPG_BLOOD_ELF_BREEDING                          = 'R000'
    constant integer UPG_BLOOD_ELF_BOWS                              = 'R009'
    constant integer UPG_BLOOD_ELF_WOOD                              = 'R006'
    constant integer UPG_BLOOD_ELF_MASONRY                           = 'R003'
    constant integer UPG_BLOOD_ELF_MELEE                             = 'R001'
    constant integer UPG_BLOOD_ELF_ARMOR                             = 'R002'
    constant integer UPG_BLOOD_ELF_MARKSMAN                          = 'R00A'
    constant integer UPG_BLOOD_ELF_MOON_ARMOR                        = 'R004'
    constant integer UPG_BLOOD_ELF_PRAYING                           = 'R007'
    constant integer UPG_BLOOD_ELF_STR_MOON                          = 'R008'
    constant integer UPG_BLOOD_ELF_LEATHER                           = 'R005'
    constant integer UPG_BLOOD_ELF_BURNING_OIL                       = 'R00Y'
    constant integer UPG_BLOOD_ELF_IMPROVED_SIEGE                    = 'R00Z'
    constant integer UPG_BLOOD_ELF_CONT_MAGIC                        = 'R04A'
    constant integer UPG_BLOOD_ELF_CLOUD                             = 'R04B'
    constant integer UPG_BLOOD_ELF_SIPHON_MANA                       = 'R09M'
    constant integer UPG_BLOOD_ELF_MAGIC_VAULT                       = 'R021' // special building

    constant integer BLOOD_ELF_SORCERESS                             = 'h0QL'
    constant integer BLOOD_ELF_PRIEST                                = 'h00G'
    constant integer BLOOD_ELF_LIEUTENANT                            = 'nbel'
    constant integer BLOOD_ELF_WAGON                                 = 'h012'
    constant integer BLOOD_ELF_BALLISTA                              = 'e00C'
    constant integer BLOOD_ELF_CAGE                                  = 'e00D'
    constant integer BLOOD_ELF_DRAGON_HAWK                           = 'h04M'
    constant integer BLOOD_ELF_SPELL_BREAKER                         = 'h04N'
    constant integer BLOOD_ELF_PHOENIX                               = 'h04O'
    constant integer BLOOD_ELF_DECIMATOR                             = 'h0KI'

    constant integer BLOOD_ELF_TRANSPORT_SHIP                        = 'h05R'
    constant integer BLOOD_ELF_FRIGATE                               = 'h04U'
    constant integer BLOOD_ELF_BATTLESHIP                            = 'h05S'

    constant integer BLOOD_ELF_CITIZEN_MALE                          = 'n00K'
    constant integer BLOOD_ELF_CITIZEN_FEMALE                        = 'n00L'
    constant integer BLOOD_ELF_CHILD                                 = 'n05T'
    constant integer BLOOD_ELF_PET                                   = 'n00T'
    constant integer BLOOD_ELF_HOUSING                               = 'h00T'

    // Naga
    constant integer NAGA_TEMPLE_1                                   = 'n05M'
    constant integer NAGA_TEMPLE_3                                   = 'n05N'
    constant integer NAGA_MURLOC_HUT                                 = 'o008' // lumber mill and blacksmith
    constant integer NAGA_FISH_MARKET                                = 'h00X' // shop
    constant integer NAGA_TREASURY_OF_THE_TIDES                      = NAGA_FISH_MARKET
    constant integer NAGA_SERPENT_PYRAMID                            = 'n05P'
    constant integer NAGA_PORTAL                                     = 'h0Y6'
    constant integer NAGA_STATUE_OF_ASZHARA                          = 'o00I' // special building
    constant integer NAGA_SHIPYARD                                   = 'e00O'

    constant integer UPG_NAGA_SUBMERGE                               = 'Rnsb'
    constant integer UPG_NAGA_SORCEROR                               = 'R0IH' // spellbreaker
    constant integer UPG_NAGA_BACKPACK                               = 'R01E'
    constant integer UPG_NAGA_STATUE_OF_AZSHARA                      = 'R02B' // special building

    constant integer NAGA_WHALER                                     = 'n05Q' // sorceress
    constant integer NAGA_SORCEROR                                   = 'n0LA' // spellbreaker
    constant integer NAGA_CORAL_GOLEM                                = 'n05O' // mortar
    constant integer NAGA_SNAP_DRAGON_SUBMERGED                      = 'nsbs' // weak ranged
    constant integer NAGA_MYRMIDON_SUBMERGED                         = 'nmys' // knight
    constant integer NAGA_ROYAL_SUBMERGED                            = 'nnrs' // royal guard

    constant integer NAGA_CITIZEN_MALE                               = 'n00M'
    constant integer NAGA_CITIZEN_FEMALE                             = 'n00N'
    constant integer NAGA_CHILD                                      = 'n0AI'
    constant integer NAGA_PET                                        = 'n00V'
    constant integer NAGA_HOUSING                                    = 'h00Q'

    // Demon
    constant integer DEMON_GATE_1                                    = 'u005' // tier 1
    constant integer DEMON_GATE_2                                    = 'u00E' // tier 2
    constant integer DEMON_GATE_3                                    = 'u00F' // tier 3
    constant integer DEMON_FORTIFIED_INFERNAL_JUGGERNAUT             = 'u00H' // watch tower and farm
    constant integer DEMON_FORTIFIED_INFERNAL_MACHINE                = 'u007' // farm
    constant integer DEMON_ALTAR                                     = 'u008'
    constant integer DEMON_DIMENSIONAL_GATE                          = 'u00A' // barracks
    constant integer DEMON_DUNGEON_OF_PAIN                           = 'u00C' // sanctum/damned temple
    constant integer DEMON_FLOATING_ROCKS                            = 'u009' // lumber will and blacksmith
    constant integer DEMON_OBELISK                                   = 'u00G' // shop
    constant integer DEMON_PORTAL                                    = 'u00B' // slaughterhouse/barracks for stronger units at tier 2
    constant integer DEMON_SHRINE                                    = 'u00D' // totem/strong units at tier 3
    constant integer DEMON_LEGION_TRANSPORTER                        = 'u019'
    constant integer DEMON_SACRIFICAL_PIT                            = 'u01A'
    constant integer DEMON_BOOK_OF_SUMMONING                         = 'n039' // special building 1
    constant integer DEMON_OUTLAND_DIMENSIONAL_GATE                  = 'o00H' // special building 2
    constant integer DEMON_SHIPYARD                                  = 'u017'

    constant integer DEMON_IMP                                       = 'u006' // worker
    constant integer DEMON_OVERLORD                                  = 'n01A' // ghoul
    constant integer DEMON_FEL_STALKER                               = 'n019' // pit fiend
    constant integer DEMON_NETHER_DRAKE                              = 'n01B' // gargoyle
    constant integer DEMON_INFERNAL_MACHINE                          = 'n01C' // meat wagon
    constant integer DEMON_GREATER_VOID_WALKER                       = 'n01E' // obsidian statue
    constant integer DEMON_EREDAR_SORCERER                           = 'n014' // necromancer
    constant integer DEMON_SUCCUBUS                                  = 'n015' // banshee
    constant integer DEMON_INFERNAL                                  = 'n012' // frost wyrm/tauren
    constant integer DEMON_INFERNAL_REAVER                           = 'n07R'
    constant integer DEMON_VOID_REAVER                               = 'n07S'
    constant integer DEMON_FEL_REAVER                                = 'n07Q'
    constant integer DEMON_JAILER                                    = 'n08O'
    constant integer DEMON_INQUISITOR                                = 'n08P'
    constant integer DEMON_LEGION_SHIP                               = 'u01M'

    constant integer UPG_DEMON_UNHOLY_STR                            = 'R00H'
    constant integer UPG_DEMON_UNHOLY_ARMOR                          = 'R00R'
    constant integer UPG_DEMON_CR_ATTACK                             = 'R00S'
    constant integer UPG_DEMON_CR_ARMOR                              = 'R00T'
    constant integer UPG_DEMON_WEB                                   = 'R00I'
    constant integer UPG_DEMON_CLEAVING_ATTACK                       = 'R00L'
    constant integer UPG_DEMON_DEVOUR_MAGIC                          = 'R00J'
    constant integer UPG_DEMON_FIRE                                  = 'R00M'
    constant integer UPG_DEMON_RAIN_OF_FIRE                          = 'R00P'
    constant integer UPG_DEMON_DEFEND                                = 'R00N'
    constant integer UPG_DEMON_CRIPPLE                               = 'R00O'
    constant integer UPG_DEMON_SLOW                                  = 'R00Q'
    constant integer UPG_DEMON_SUCCUBUS                              = 'R00F'
    constant integer UPG_DEMON_EREDAR_SORCERER                       = 'R00E'
    constant integer UPG_DEMON_RESISTANT_SKIN                        = 'R00D'
    constant integer UPG_DEMON_PERMANENT_IMMOLATION                  = 'R00C'
    constant integer UPG_DEMON_HARDENED_SKIN                         = 'R00K'
    constant integer UPG_DEMON_WAR_STOMP                             = 'R06D'
    constant integer UPG_DEMON_IMPROVED_DEVOUR                       = 'R06F'
    constant integer UPG_DEMON_ANTI_MAGIC_SHELL                      = 'R06G'
    constant integer UPG_DEMON_SOUL_THEFT                            = 'R08Y'
    constant integer UPG_DEMON_SPACE_TRAVEL                          = 'R093'
    constant integer UPG_DEMON_FEL_TRANSPORTING                      = 'R06E'
    constant integer UPG_DEMON_INFERNO                               = 'R0G6'
    constant integer UPG_DEMON_BACKPACK                              = 'R00G'
    constant integer UPG_DEMON_BOOK_OF_SUMMONING                     = 'R023' // special building
    constant integer UPG_DEMON_OUTLAND_DIMENSIONAL_GATE              = 'R02A' // special building

    constant integer DEMON_CITIZEN_MALE                              = 'n016'
    constant integer DEMON_CITIZEN_FEMALE                            = 'n017'
    constant integer DEMON_CHILD                                     = 'n05X'
    constant integer DEMON_PET                                       = 'n018'

    constant integer DEMON_HOUSING                                   = 'h00Y'

    // Draenei
    constant integer DRAENEI_HAVEN                                   = 'ndh2' // tier 1 - 3
    constant integer DRAENEI_BARRACKS                                = 'ndh3'
    constant integer DRAENEI_SEERS_DEN                               = 'ndh4'
    constant integer DRAENEI_ALTAR_OF_SEERS                          = 'o052'
    constant integer DRAENEI_HUT                                     = 'o053'
    constant integer DRAENEI_MILL                                    = 'n062'
    constant integer DRAENEI_SHOP                                    = 'n01N'
    constant integer DRAENEI_BOULDER_TOWER                           = 'nbt1'
    constant integer DRAENEI_ADVANCED_BOULDER_TOWER                  = 'nbt2'
    constant integer DRAENEI_PRISON                                  = 'o00K'
    constant integer DRAENEI_SHIPYARD                                = 'o00A'

    constant integer DRAENEI_LABORER                                 = 'ndrl' // worker
    constant integer DRAENEI_VINDICATOR                              = 'ndrn' // footman
    constant integer DRAENEI_STALKER                                 = 'ndrt' // knight
    constant integer DRAENEI_SALAMANDER                              = 'n01W' // pit fiend
    constant integer DRAENEI_SEER                                    = 'n01U' // priest
    constant integer DRAENEI_HARBINGER                               = 'n01V' // sorceress
    constant integer DRAENEI_DEMOLISHER                              = 'ncat' // mortar
    constant integer DRAENEI_NETHER_DRAKE                            = 'n01Q' // gryphon

    constant integer UPG_DRAENEI_DEVOUR                              = 'R018'
    constant integer UPG_DRAENEI_DEMON_FIRE                          = 'R017'
    constant integer UPG_DRAENEI_HARBRINGER_ADEPT                    = 'R015'
    constant integer UPG_DRAENEI_SEER_ADEPT                          = 'R014'
    constant integer UPG_DRAENEI_IMPROVED_MASONRY                    = 'R016'
    constant integer UPG_DRAENEI_STEEL_ARMOR                         = 'R013'
    constant integer UPG_DRAENEI_STEEL_MELEE_WEAPONS                 = 'R011'
    constant integer UPG_DRAENEI_STEEL_RANGED_WEAPONS                = 'R012'
    constant integer UPG_DRAENEI_PRISON                              = 'R0D2'

    constant integer DRAENEI_CITIZEN_MALE                            = 'n01L'
    constant integer DRAENEI_CITIZEN_FEMALE                          = 'n01M'
    constant integer DRAENEI_CHILD                                   = 'n063'
    constant integer DRAENEI_PET                                     = 'n00R'
    constant integer DRAENEI_HOUSING                                 = 'h011'

    // Furbolg
    constant integer FURBOLG_TRIBAL_CENTER                           = 'n026' // tier 1-3
    constant integer FURBOLG_BARRACKS                                = 'n027' // barracks
    constant integer FURBOLG_DEFILED_FOUNTAIN                        = 'n02B' // sanctum/damned temple
    constant integer FURBOLG_LUMBER_CAMP                             = 'h017' // lumber will and blacksmith
    constant integer FURBOLG_MARKETPLACE                             = 'u00Q' // shop
    constant integer FURBOLG_WOLVES_CAGE                             = 'n02C' // slaughterhouse/barracks for stronger units at tier 2
    constant integer FURBOLG_POLAR_HUT                               = 'n02D' // totem/strong units at tier 3
    constant integer FURBOLG_GREEN_DRAGON_ROOST                      = 'n02R' // totem/strong units at tier 3
    constant integer FURBOLG_HUT                                     = 'n028' // farm
    constant integer GUARDING_FURBOLG                                = 'h016' // tower
    constant integer RESURRECTION_STONE                              = 'h01R' // altar
    constant integer FURBOLG_CORRUPTED_ANCIENT_PROTECTOR             = 'o00J' // special building
    constant integer FURBOLG_SHIPYARD                                = 'o00E'

    constant integer YOUNG_FURBOLG                                   = 'h01M' // worker
    constant integer FURBOLG_EX                                      = 'n02E'
    constant integer FURBOLG_CHAMPION_EX                             = 'n02F'
    constant integer FURBOLG_ELDER_SHAMAN                            = 'n02G'
    constant integer FURBOLG_SHAMAN_EX                               = 'n02H'
    constant integer FURBOLG_TRACKER_EX                              = 'n02I'
    constant integer FURBOLG_URSA_WARRIOR                            = 'n02J' // tauren
    constant integer GREEN_DRAKE                                     = 'n02S' // frost wyrm
    constant integer POLAR_FURBOLG                                   = 'n02K'
    constant integer POLAR_FURBOLG_CHAMPION                          = 'n02L'
    constant integer TIMBER_WOLF                                     = 'n02O'
    constant integer GIANT_WOLF                                      = 'n02M'
    constant integer DIRE_WOLF                                       = 'n02N'

    constant integer CORRUPTED_FURBOLG                               = 'n02P'

    constant integer UPG_FURBOLG_WEB                                 = 'R01Q'
    constant integer UPG_FURBOLG_STEEL_RWEAPONS                      = 'R01G'
    constant integer UPG_FURBOLG_STEEL_WEAPONS                       = 'R01F'
    constant integer UPG_FURBOLG_STEEL_ARMOR                         = 'R01H'
    constant integer UPG_FURBOLG_LUMBER                              = 'R01S'
    constant integer UPG_FURBOLG_SHAMAN                              = 'R01K'
    constant integer UPG_FURBOLG_ELDER_SHAMAN                        = 'R01L'
    constant integer UPG_FURBOLG_FAERIE_FIRE                         = 'R01N'
    constant integer UPG_FURBOLG_ENSNARE                             = 'R01M'
    constant integer UPG_FURBOLG_CR_ARMOR                            = 'R01J'
    constant integer UPG_FURBOLG_CR_ATTACK                           = 'R01I'
    constant integer UPG_FURBOLG_CORRUPTION                          = 'R01R'
    constant integer UPG_FURBOLG_BLOOD_LUST                          = 'R01O'
    constant integer UPG_FURBOLG_BASH                                = 'R01P'
    constant integer UPG_FURBOLG_BACKPACK                            = 'R01D'
    constant integer UPG_FURBOLG_CORRUPTED_ANCIENT_PROTECTOR         = 'R02C'

    constant integer FURBOLG_CITIZEN_MALE                            = 'n029'
    constant integer FURBOLG_CITIZEN_FEMALE                          = 'n02A'
    constant integer FURBOLG_CHILD                                   = 'n05Z'
    constant integer FURBOLG_PET                                     = 'n0C7'
    constant integer FURBOLG_HOUSING                                 = 'h015'

    // Goblin
    constant integer GOBLIN_TIER_1                                   = 'o00O' // tier 1
    constant integer GOBLIN_TIER_2                                   = 'o022' // tier 2
    constant integer GOBLIN_TIER_3                                   = 'o023' // tier 3
    constant integer GOBLIN_BARRACKS                                 = 'o011' // barracks
    constant integer GOBLIN_ARCANE_LABORATORY                        = 'o014' // sanctum/damned temple
    constant integer GOBLIN_FUEL_PUMP                                = 'o00S' // lumber will and blacksmith
    constant integer GOBLIN_SHOP                                     = 'o01A' // shop
    constant integer GOBLIN_TANK_FACTORY                             = 'o00Z' // slaughterhouse/barracks for stronger units at tier 2
    constant integer GOBLIN_AIR_FIELD                                = 'o00R' // totem/strong units at tier 3
    constant integer GOBLIN_HUT                                      = 'o019' // farm
    constant integer GOBLIN_TOWER                                    = 'o00U' // tower
    constant integer GOBLIN_ROCKET_TOWER_1                           = 'o00W' // tower 1
    constant integer GOBLIN_ROCKET_TOWER_2                           = 'o00X' // tower 2
    constant integer GOBLIN_ROCKET_TOWER_3                           = 'o00Y' // tower 3
    constant integer GOBLIN_ALTAR                                    = 'o00T' // altar
    constant integer GOBLIN_HEAVY_TANK                               = 'o01G' // special building
    constant integer GOBLIN_SHIPYARD                                 = 'o01B'
    constant integer GOBLIN_TUNNEL_WAYGATE                           = 'o018'
    constant integer GOBLIN_TUNNEL                                   = 'o00P'

    constant integer GOBLIN_LABORER                                  = 'h02L' // worker
    constant integer GOBLIN_SHREDDER                                 = 'n03W' // lumber worker
    constant integer GOBLIN_FLAMETHROWER                             = 'o013'
    constant integer GOBLIN_FLAME_TANK                               = 'h02D'
    constant integer GOBLIN_MAGE                                     = 'o010'
    constant integer GOBLIN_SORCERESS                                = 'o012'
    constant integer GOBLIN_FLAME_SHREDDER                           = 'o00V'
    constant integer GOBLIN_ASSAULT_TANK                             = 'h02F'
    constant integer GOBLIN_WAR_ZEPPELIN                             = 'n03T' // frost wyrm
    constant integer GOBLIN_AIR_DRONE                                = 'h02G'
    constant integer GOBLIN_SAPPER                                   = 'n03V'
    constant integer OGRE_GOBLIN_SQUAD                               = 'o01C'
    constant integer GOBLIN_EMPEROR                                  = 'h02E' // tauren
    constant integer GOBLIN_STEAM_ROLLER                             = 'h02K' // Obsidian Statue
    constant integer GOBLIN_SUBMARINE                                = 'h02I'
    constant integer GOBLIN_MOBILE_TURRET                            = 'e00J'
    constant integer GOBLIN_TURRET                                   = 'o01E'

    constant integer UPG_GOBLIN_STEEL_RWEAPONS                       = 'R033'
    constant integer UPG_GOBLIN_STEEL_WEAPONS                        = 'R02M'
    constant integer UPG_GOBLIN_STEEL_ARMOR                          = 'R031'
    constant integer UPG_GOBLIN_ALCHEMIST_ADEPT                      = 'R036'
    constant integer UPG_GOBLIN_MAGE_ADEPT                           = 'R037'
    constant integer UPG_GOBLIN_SORCERESS_ADEPT                      = 'R038'
    constant integer UPG_GOBLIN_AIR_SUPPLIES                         = 'R02H'
    constant integer UPG_GOBLIN_BARRAGE                              = 'R02N'
    constant integer UPG_GOBLIN_CHEMISTRY                            = 'R02L'
    constant integer UPG_GOBLIN_CLUSTER_ROCKETS                      = 'R02Y'
    constant integer UPG_GOBLIN_CUT_DOWN_TREES                       = 'R039'
    constant integer UPG_GOBLIN_DEMOLISH                             = 'R02R'
    constant integer UPG_GOBLIN_ENGINEERING                          = 'R02S'
    constant integer UPG_GOBLIN_EXPLOSIVE_BARREL                     = 'R02W'
    constant integer UPG_GOBLIN_EXPLOSIVES                           = 'R02J'
    constant integer UPG_GOBLIN_FLAME_GRENADES                       = 'R02T'
    constant integer UPG_GOBLIN_BURNING_OIL                          = 'R04P'
    constant integer UPG_GOBLIN_FUEL                                 = 'R02Q'
    constant integer UPG_GOBLIN_WAR_ZEPPELIN_BOMBS                   = 'R034'
    constant integer UPG_GOBLIN_IMPROVED_CONSTRUCTION                = 'R030'
    constant integer UPG_GOBLIN_MOBILE_TURRET                        = 'R02U'
    constant integer UPG_GOBLIN_OBSERVATORY                          = 'R02I'
    constant integer UPG_GOBLIN_OIL_DRILLING                         = 'R02V'
    constant integer UPG_GOBLIN_REPAIR                               = 'R02K'
    constant integer UPG_GOBLIN_BANKING                              = 'R02P'
    constant integer UPG_GOBLIN_LUMBER                               = 'R02O'
    constant integer UPG_GOBLIN_BACKPACK                             = 'R02G'

    constant integer GOBLIN_CITIZEN_MALE                             = 'n03Y'
    constant integer GOBLIN_CITIZEN_FEMALE                           = 'n03Z'
    constant integer GOBLIN_CHILD                                    = 'n05Y'
    constant integer GOBLIN_HOUSING                                  = 'h02H'

    // Dwarf
    constant integer DWARF_TIER_1                                    = 'h02R' // tier 1
    constant integer DWARF_TIER_2                                    = 'h030' // tier 2
    constant integer DWARF_TIER_3                                    = 'h031' // tier 3
    constant integer DWARF_BARRACKS                                  = 'h02V' // barracks
    constant integer DWARF_MYSTICAL_HALL                             = 'h037' // sanctum/damned temple
    constant integer DWARF_BLACKSMITH                                = 'h02X' // lumber will and blacksmith
    constant integer DWARF_TAVERN                                    = 'h03E' // shop
    constant integer DWARF_WORKSHOP                                  = 'h032' // slaughterhouse/barracks for stronger units at tier 2
    constant integer DWARF_BEASTIARY                                 = 'h02Z' // totem/strong units at tier 3
    constant integer DWARF_HOUSE                                     = 'h036' // farm
    constant integer DWARF_TOWER                                     = 'h039' // tower
    constant integer DWARF_TOWER_GUN                                 = 'h03B' // tower 1
    constant integer DWARF_TOWER_GUARD                               = 'h03C' // tower 2
    constant integer DWARF_TOWER_CANNON                              = 'h03D' // tower 3
    constant integer DWARF_ALTAR                                     = 'h033' // altar
    constant integer DWARF_LUMBER_MILL                               = 'n04Z' // special building
    constant integer DWARF_MINE                                      = 'u011'
    constant integer DWARF_MINE_2                                    = 'u00Z'
    constant integer DWARF_MINE_3                                    = 'u010'
    constant integer DWARF_SHIPYARD                                  = 'h038'

    constant integer DWARF_MINER                                     = 'h02Q' // worker
    constant integer DWARF_TROLL_SLAYER                              = 'h02U'
    constant integer DWARF_RIFLEMAN                                  = 'h02W'
    constant integer DWARF_BATTLEPRIEST                              = 'h03A'
    constant integer DWARF_RUNECASTER                                = 'o01L'
    constant integer DWARF_RIDER                                     = 'h02Y' // knight
    constant integer DWARF_MORTAR                                    = 'h03H'
    constant integer DWARF_POLAR_BEAR                                = 'n04T' // tauren
    constant integer DWARF_GRYPHON_RIDER                             = 'h035'
    constant integer DWARF_GRYPHON                                   = 'n04U'
    constant integer DWARF_FLYING_MACHINE                            = 'h03I'
    constant integer DWARF_SIEGE_ENGINE                              = 'h03G'
    constant integer DWARF_STEAM_FORTRESS                            = 'h03F'
    constant integer DWARF_SUBMARINE                                 = 'h0WL'

    constant integer UPG_DWARF_RANGED                                = 'R043'
    constant integer UPG_DWARF_MELEE                                 = 'R040'
    constant integer UPG_DWARF_ARMOR                                 = 'R041'
    constant integer UPG_DWARF_LEATHER                               = 'R042'
    constant integer UPG_DWARF_BATTLEPRIEST_ADEPT                    = 'R03U'
    constant integer UPG_DWARF_RUNECASTER_ADEPT                      = 'R03T'
    constant integer UPG_DWARF_BERSERK                               = 'R03N'
    constant integer UPG_DWARF_SLAM                                  = 'R03K'
    constant integer UPG_DWARF_SLEEP_FORM                            = 'R03V'
    constant integer UPG_DWARF_ANIMAL_WAR_TRAINING                   = 'R044'
    constant integer UPG_DWARF_BARRAGE                               = 'R03P'
    constant integer UPG_DWARF_BREEDING                              = 'R03I'
    constant integer UPG_DWARF_DEVOUR                                = 'R03L'
    constant integer UPG_DWARF_ELITE_SIEGE_TANK                      = 'R03Q'
    constant integer UPG_DWARF_FLAK_CANNONS                          = 'R03W'
    constant integer UPG_DWARF_FLARE                                 = 'R03Z'
    constant integer UPG_DWARF_MITHRIL                               = 'R03O'
    constant integer UPG_DWARF_POLAR_BEAR_BOMBS                      = 'R034'
    constant integer UPG_DWARF_FLYING_MACHINE_BOMBS                  = 'R03X'
    constant integer UPG_DWARF_FRAGMENTATION_SHARDS                  = 'R03Y'
    constant integer UPG_DWARF_LONG_RIFLES                           = 'R03M'
    constant integer UPG_DWARF_STORM_HAMMERS                         = 'R045'
    constant integer UPG_DWARF_MASONRY                               = 'R03R'
    constant integer UPG_DWARF_LUMBER_MILL                           = 'R03J'
    constant integer UPG_DWARF_LUMBER                                = 'R03S'
    constant integer UPG_DWARF_BACKPACK                              = 'R03H'

    constant integer DWARF_CITIZEN_MALE                              = 'n04S'
    constant integer DWARF_CITIZEN_FEMALE                            = 'n050'
    constant integer DWARF_HOUSING                                   = 'h02S'

    // High Elf
    constant integer HIGH_ELF_TIER_1                                 = 'h040' // tier 1
    constant integer HIGH_ELF_TIER_2                                 = 'h03Z' // tier 2
    constant integer HIGH_ELF_TIER_3                                 = 'h041' // tier 3
    constant integer HIGH_ELF_OUTPOST                                = 'h04G' // scout tower
    constant integer HIGH_ELF_GUARD_TOWER                            = 'n05I' // guard tower
    constant integer HIGH_ELF_FARM                                   = 'h04B' // farm
    constant integer HIGH_ELF_MAGE_TOWER                             = 'h043' // arcane
    constant integer HIGH_ELF_ALTAR                                  = 'h042' // altar
    constant integer HIGH_ELF_BAZAAR                                 = 'h04D' // shop
    constant integer HIGH_ELF_BARRACKS                               = 'h044' // barracks
    constant integer HIGH_ELF_ENCHANTER_TOWER                        = 'h04I' // blacksmith/lumber mill
    constant integer HIGH_ELF_STABLES                                = 'h04F' // barracks 2/workshop
    constant integer HIGH_ELF_AVIARY                                 = 'h045' // aviary
    constant integer HIGH_ELF_DRAGON_NEXUS                           = 'h04J' // boneyard
    constant integer HIGH_ELF_SUNWELL                                = 'n05F' // special building
    constant integer HIGH_ELF_SHIPYARD                               = 'h04Y'

    constant integer UPG_HIGH_ELF_BOWS                               = 'R04G'
    constant integer UPG_HIGH_ELF_WOOD                               = 'R04H'
    constant integer UPG_HIGH_ELF_MASONRY                            = 'R04K'
    constant integer UPG_HIGH_ELF_MELEE                              = 'R04M'
    constant integer UPG_HIGH_ELF_ARMOR                              = 'R04N'
    constant integer UPG_HIGH_ELF_STR_MOON                           = 'R04Q'
    constant integer UPG_HIGH_ELF_LEATHER                            = 'R04O'
    constant integer UPG_HIGH_ELF_MARKSMAN                           = 'R04D'
    constant integer UPG_HIGH_ELF_PRAYING                            = 'R04J'
    constant integer UPG_HIGH_ELF_PRAYING_CLERIC                     = 'R04L'
    constant integer UPG_HIGH_ELF_ANIMAL                             = 'R04F'
    constant integer UPG_HIGH_ELF_ANTIMAGIC                          = 'R04C'
    constant integer UPG_HIGH_ELF_CLOUD                              = 'R04E'
    constant integer UPG_HIGH_ELF_TAMING                             = 'R04I'
    constant integer UPG_HIGH_ELF_BACKPACK                           = 'R048'
    constant integer UPG_HIGH_ELF_MAGIC_SENTRY                       = 'R049'
    constant integer UPG_HIGH_ELF_DRAGONHAWL_TAMING                  = 'R04R'
    constant integer UPG_HIGH_ELF_DIURNAL                            = 'R0D2'
    constant integer UPG_HIGH_ELF_SUNWELL                            = 'R047' // special building

    constant integer HIGH_ELF_ENGINEER                               = 'n05D' // worker
    constant integer HIGH_ELF_ARCHER                                 = 'n05G' // rifleman
    constant integer HIGH_ELF_RANGER                                 = 'n05H'
    constant integer HIGH_ELF_SWORDMAN                               = 'h04A' // footman
    constant integer HIGH_ELF_LIEUTENANT                             = 'h049'
    constant integer HIGH_ELF_PRIEST                                 = 'h047'
    constant integer HIGH_ELF_SORCERESS                              = 'h048'
    constant integer HIGH_ELF_BIRDIEPULT                             = 'e00N'
    constant integer HIGH_ELF_KNIGHT                                 = 'h04E' // knight
    constant integer HIGH_ELF_EAGLE                                  = 'e00M'
    constant integer HIGH_ELF_EAGLE_RIDER                            = 'e00L'
    constant integer HIGH_ELF_DRAGON_HAWK                            = 'e00K'
    constant integer HIGH_ELF_DRAGON_HAWK_RIDER                      = 'h046'
    constant integer HIGH_ELF_DRAGON_HAWK_ARCHER                     = 'e00P'
    constant integer HIGH_ELF_ARCH_CLERIC                            = 'h04C'
    constant integer HIGH_ELF_DRAGON                                 = 'n05L'

    constant integer HIGH_ELF_TRANSPORT_SHIP                         = 'h00S'
    constant integer HIGH_ELF_FRIGATE                                = 'h03X'
    constant integer HIGH_ELF_BATTLESHIP                             = 'h04T'

    constant integer HIGH_ELF_CITIZEN_MALE                           = 'n05E'
    constant integer HIGH_ELF_CITIZEN_FEMALE                         = 'n05J'
    constant integer HIGH_ELF_CHILD                                  = 'n05W'
    constant integer HIGH_ELF_PET                                    = 'n05K'
    constant integer HIGH_ELF_HOUSING                                = 'h04H'

    // Gnome
    constant integer GNOME_TIER_1                                    = 'h0JX'
    constant integer GNOME_TIER_2                                    = 'h0KB'
    constant integer GNOME_TIER_3                                    = 'h0KE'
    constant integer GNOME_GEAR                                      = 'h0KL' // farm
    constant integer GNOME_BRASSMAN                                  = 'e01G' // barracks
    constant integer GNOME_FACTORY                                   = 'h0KK' // forge/lumber mill
    constant integer GNOME_TURRET                                    = 'h0KH' // watch tower
    constant integer GNOME_AVIARY                                    = 'h0KN' // aviary
    constant integer GNOME_LABORATORY                                = 'h0NI' // sanctuary
    constant integer GNOME_WORKSHOP                                  = 'h0KS' // workshop
    constant integer GNOME_TELEPORTER                                = 'h0KT' // sacrifical pit
    constant integer GNOME_ALTAR_OF_TECHNOLOGY                       = 'h0QM' // altar
    constant integer GNOME_TECHNOLOGY_FAIR                           = 'h0QN' // shop
    constant integer GNOME_SHIPYARD                                  = 'h0WN'

    constant integer UPG_GNOME_BACKPACK                              = 'R09O'
    constant integer UPG_GNOME_INVENTIONS                            = 'R09N'
    constant integer UPG_GNOME_ARCANIST                              = 'R0DH'
    constant integer UPG_GNOME_DAMAGE                                = 'R0E0'
    constant integer UPG_GNOME_ARMOR                                 = 'R0E1'
    constant integer UPG_GNOME_ENGINEERING                           = 'R0E2'
    constant integer UPG_GNOME_RESISTANT_SKIN                        = 'R0E3'

    constant integer GNOME_ENGINEER                                  = 'h0JY' // worker
    constant integer GNOME_RIFLEMAN                                  = 'h0KC' // rifleman
    constant integer GNOME_FIELD_ENGINEER                            = 'h0K8' // knight
    constant integer GNOME_ARTILLERY_TANK                            = 'h0KD' // demolisher
    constant integer GNOME_FLYING_MACHINE                            = 'h0KO'
    constant integer GNOME_GRYPHON_RIDER                             = 'h0KP'
    constant integer GNOME_HOVER_COPTER                              = 'h0KQ'
    constant integer GNOME_MORTAR_TEAM                               = 'h0KR'

    constant integer GNOME_CITIZEN_MALE                              = 'n0D0'
    constant integer GNOME_CITIZEN_FEMALE                            = 'n0D4'
    constant integer GNOME_CITIZEN_CHILD                             = 'n0D5'
    constant integer GNOME_CITIZEN_PET                               = 'n0D3'
    constant integer GNOME_HOUSING                                   = 'h0KZ'

    // Dalaran
    constant integer DALARAN_TIER_1                                  = 'h051' // tier 1
    constant integer DALARAN_TIER_2                                  = 'h099' // tier 2
    constant integer DALARAN_TIER_3                                  = 'h09A' // tier 3
    constant integer DALARAN_GUARD_TOWER_1                           = 'n085' // guard tower 1
    constant integer DALARAN_GUARD_TOWER_2                           = 'n08E' // guard tower 2
    constant integer DALARAN_POWER_GENERATOR                         = 'h053' // farm
    constant integer DALARAN_ARCANE_SANCTUM                          = 'h09N' // arcane
    constant integer DALARAN_ALTAR                                   = 'h09L' // altar
    constant integer DALARAN_SHOP                                    = 'h09M' // shop
    constant integer DALARAN_BARRACKS                                = 'h055' // barracks
    constant integer DALARAN_BLACKSMITH                              = 'h09P' // blacksmith/lumber mill
    constant integer DALARAN_ZOO                                     = 'h09O' // barracks 2/workshop
    constant integer DALARAN_AVIARY                                  = 'h0A0' // aviary
    constant integer DALARAN_ELEMENTAL_SANCTUARY_1                   = 'h09F' // boneyard 1
    constant integer DALARAN_ELEMENTAL_SANCTUARY_2                   = 'h09X' // boneyard 2
    constant integer DALARAN_VIOLET_CITADEL                          = 'h09J' // special building
    constant integer DALARAN_MINE                                    = 'u018' // goldmine
    constant integer DALARAN_SHIPYARD                                = 'h09D'

    constant integer UPG_DALARAN_GOLD                                = 'R063'
    constant integer UPG_DALARAN_MELEE                               = 'R069'
    constant integer UPG_DALARAN_ARMOR                               = 'R06A'
    constant integer UPG_DALARAN_CR_ATTACK                           = 'R06H'
    constant integer UPG_DALARAN_CR_ARMOR                            = 'R068'
    constant integer UPG_DALARAN_DEFEND                              = 'R05U'
    constant integer UPG_DALARAN_SORCERESS                           = 'R083'
    constant integer UPG_DALARAN_WIZARD                              = 'R05X'
    constant integer UPG_DALARAN_FIRE_MAGE                           = 'R065'
    constant integer UPG_DALARAN_GOLEM                               = 'R06N'
    constant integer UPG_DALARAN_ANIMAL                              = 'R066'
    constant integer UPG_DALARAN_CLOUD                               = 'R067'
    constant integer UPG_DALARAN_BACKPACK                            = 'R05T'
    constant integer UPG_DALARAN_MAGIC_SENTRY                        = 'R05W'
    constant integer UPG_DALARAN_BLINK                               = 'R05Y'
    constant integer UPG_DALARAN_MANA_SHIELD                         = 'R061'
    constant integer UPG_DALARAN_SPAWN_FIRE_ELEMENTALS               = 'R05Z'
    constant integer UPG_DALARAN_SHIELD                              = 'R05R'
    constant integer UPG_DALARAN_ELEMENTAL                           = 'R060'
    constant integer UPG_DALARAN_FEEDBACK                            = 'R05V'
    constant integer UPG_DALARAN_FLYING_CITY                         = 'R062'
    constant integer UPG_DALARAN_VIOLET_CITADEL                      = 'R05S' // special building

    constant integer DALARAN_WORKER                                  = 'h052' // worker
    constant integer DALARAN_PIKEMAN                                 = 'h09Q'
    constant integer DALARAN_APPRENTICE_WIZARD                       = 'n087'
    constant integer DALARAN_SUPPLY_CART                             = 'h09S'
    constant integer DALARAN_WIZARD                                  = 'n086'
    constant integer DALARAN_SORCERESS                               = 'h0A2'
    constant integer DALARAN_FIRE_MAGE                               = 'h09R'
    constant integer DALARAN_MUTANT                                  = 'n08D'
    constant integer DALARAN_REJECT                                  = 'n089'
    constant integer DALARAN_GUARDIAN_GOLEM                          = 'n08A'
    constant integer DALARAN_FLESH_GOLEM                             = 'n088'
    constant integer DALARAN_DRAGON_HAWK                             = 'h0A1'
    constant integer DALARAN_AIR_ELEMENTAL                           = 'h09U'
    constant integer DALARAN_FIRE_ELEMENTAL                          = 'h09I'
    constant integer DALARAN_FROST_ELEMENTAL                         = 'h09V'
    constant integer DALARAN_LIGHTNING_ELEMENTAL                     = 'h09K'
    constant integer DALARAN_POISON_ELEMENTAL                        = 'h09W'
    constant integer DALARAN_VOID_ELEMENTAL                          = 'h09Z'
    constant integer DALARAN_SAND_ELEMENTAL                          = 'h09G'
    constant integer DALARAN_WATER_ELEMENTAL                         = 'h09H'
    constant integer DALARAN_SEA_ELEMENTAL                           = 'n084'

    constant integer DALARAN_CITIZEN_MALE                            = 'n082'
    constant integer DALARAN_CITIZEN_FEMALE                          = 'n08B'
    constant integer DALARAN_CHILD                                   = 'n09I'
    constant integer DALARAN_PET                                     = 'n00Q'
    constant integer DALARAN_HOUSING                                 = 'h09E'

    // Kul Tiras
    constant integer KULTIRAS_TIER_1                                 = 'h057' // tier 1
    constant integer KULTIRAS_TIER_2                                 = 'h05I' // tier 2
    constant integer KULTIRAS_TIER_3                                 = 'h05J' // tier 3
    constant integer KULTIRAS_WATCH_TOWER                            = 'h06H' // scout tower
    constant integer KULTIRAS_GUARD_TOWER                            = 'h06L' // guard tower
    constant integer KULTIRAS_CANNON_TOWER                           = 'h06M' // cannon tower
    constant integer KULTIRAS_ARCANE_TOWER                           = 'h06N' // arcane tower
    constant integer KULTIRAS_HOUSE                                  = 'h05B' // farm
    constant integer KULTIRAS_ARCANE_SANCTUM                         = 'h06G' // arcane
    constant integer KULTIRAS_ALTAR                                  = 'h05A' // altar
    constant integer KULTIRAS_SHOP                                   = 'h05Q' // shop
    constant integer KULTIRAS_BARRACKS_1                             = 'h05C' // barracks 1
    constant integer KULTIRAS_BARRACKS_2                             = 'h0BQ' // barracks 2
    constant integer KULTIRAS_LUMBER_MILL                            = 'h05P' // lumber mill
    constant integer KULTIRAS_BLACKSMITH                             = 'h05O' // blacksmith
    constant integer KULTIRAS_WORKSHOP                               = 'h05H' // workshop
    constant integer KULTIRAS_AVIARY                                 = 'h06I' // aviary
    constant integer KULTIRAS_CRANE                                  = 'o021' // citizens building on shallow water for extra resources
    constant integer KULTIRAS_PROUDMOORE_KEEP                        = 'h08Z' // special building
    constant integer KULTIRAS_SHIPYARD                               = 'h05G'
    constant integer KULTIRAS_SHIPYARD_ADVANCED                      = 'h0CR'

    constant integer UPG_KULTIRAS_LUMBER                             = 'R05M'
    constant integer UPG_KULTIRAS_MASONRY                            = 'R05N'
    constant integer UPG_KULTIRAS_MELEE                              = 'R06T'
    constant integer UPG_KULTIRAS_ARMOR                              = 'R06U'
    constant integer UPG_KULTIRAS_RANGED                             = 'R06W'
    constant integer UPG_KULTIRAS_LEATHER                            = 'R06V'
    constant integer UPG_KULTIRAS_DEFEND                             = 'R06P'
    constant integer UPG_KULTIRAS_LONG_RIFLES                        = 'R058'
    constant integer UPG_KULTIRAS_BACKPACK                           = 'R06Z'
    constant integer UPG_KULTIRAS_TRUE_SIGHT                         = 'R06Y'
    constant integer UPG_KULTIRAS_SHIP_DOCTOR                        = 'R05K'
    constant integer UPG_KULTIRAS_SORCERER                           = 'R05J'
    constant integer UPG_KULTIRAS_HYDROMANCER                        = 'R05L'
    constant integer UPG_KULTIRAS_CLEAVING_ATTACK                    = 'R06R'
    constant integer UPG_KULTIRAS_SUNDERING_BLADES                   = 'R070'
    constant integer UPG_KULTIRAS_ANIMAL                             = 'R05O'
    constant integer UPG_KULTIRAS_DEVOUR                             = 'R06X'
    constant integer UPG_KULTIRAS_ENSNARE                            = 'R06Q'
    constant integer UPG_KULTIRAS_GHOSTS                             = 'R06O'
    constant integer UPG_KULTIRAS_MAGIC_SENTRY                       = 'R06S'
    constant integer UPG_KULTIRAS_LAND_CANNONS                       = 'R056'
    constant integer UPG_KULTIRAS_SHIP_CANNONS                       = 'R055'
    constant integer UPG_KULTIRAS_SHIPYARD_REPAIR                    = 'R059'
    constant integer UPG_KULTIRAS_TRANSPORTERS                       = 'R057'
    constant integer UPG_KULTIRAS_FRAGS                              = 'R071'
    constant integer UPG_KULTIRAS_FLARE                              = 'R072'
    constant integer UPG_KULTIRAS_PROUDMOORE_KEEP                    = 'R05I' // special building

    constant integer KULTIRAS_WORKER                                 = 'h058' // worker
    constant integer KULTIRAS_FOOTMAN                                = 'h054'
    constant integer KULTIRAS_RIFLEMAN                               = 'h05E'
    constant integer KULTIRAS_KNIGHT                                 = 'h05F'
    constant integer KULTIRAS_GUARDSMAN                              = 'h05D'
    constant integer KULTIRAS_FLIBUSTIER                             = 'h05L'
    constant integer KULTIRAS_FLIBUSTIER_GUN                         = 'h05M'
    constant integer KULTIRAS_ROYAL_GUARD                            = 'h0BP'
    constant integer KULTIRAS_CANONEER_TEAM                          = 'h00Z'
    constant integer KULTIRAS_STORM_SORCERER                         = 'h06K'
    constant integer KULTIRAS_SHIP_DOCTOR                            = 'h06J'
    constant integer KULTIRAS_HYDROMANCER                            = 'n06X'
    constant integer KULTIRAS_LAND_SHIP                              = 'h0BT'
    constant integer KULTIRAS_GUNSHIP                                = 'h0BR'
    constant integer KULTIRAS_ALBATROSS_RIDER                        = 'n09O'
    constant integer KULTIRAS_PEREGRIN_FALCON                        = 'n09P'
    constant integer KULTIRAS_FLYING_DREADNOUGHT                     = 'h0BW'
    constant integer KULTIRAS_BATTLESHIP                             = 'h05N'
    constant integer KULTIRAS_DREADNOUGHT                            = 'h05K'
    constant integer KULTIRAS_PIRATE_BATTLESHIP                      = 'h059'

    constant integer KULTIRAS_CITIZEN_MALE                           = 'n066'
    constant integer KULTIRAS_CITIZEN_FEMALE                         = 'n0BL'
    constant integer KULTIRAS_CHILD                                  = 'n0CV'
    constant integer KULTIRAS_PET                                    = 'n00Q'
    constant integer KULTIRAS_HOUSING                                = 'h090'

    // Lordaeron
    constant integer LORDAERON_TIER_1                                = 'h0LX'
    constant integer LORDAERON_TIER_2                                = 'h0MC'
    constant integer LORDAERON_TIER_3                                = 'h0MD'
    constant integer LORDAERON_ALTAR                                 = 'h0ME'
    constant integer LORDAERON_ARCANE_TOWER                          = 'h0NE'
    constant integer LORDAERON_BARRACKS                              = 'h0MH'
    constant integer LORDAERON_BLACKSMITH                            = 'h0MJ'
    constant integer LORDAERON_CANNON_TOWER                          = 'h0NC'
    constant integer LORDAERON_FARM                                  = 'h0MF'
    constant integer LORDAERON_AVIARY                                = 'h0MM'
    constant integer LORDAERON_GUARD_TOWER                           = 'h0ND'
    constant integer LORDAERON_LUMBER_MILL                           = 'h0MK'
    constant integer LORDAERON_SCOUT_TOWER                           = 'h0MN'
    constant integer LORDAERON_MAGE_TOWER                            = 'h0MP'
    constant integer LORDAERON_SCARLET_MONASTERY                     = 'h0N6'
    constant integer LORDAERON_TRADE_HOUSE                           = 'h0ML'
    constant integer LORDAERON_WORKSHOP                              = 'h0MO'
    constant integer LORDAERON_SHIPYARD                              = 'h0NB'

    constant integer UPG_LORDAERON_LUMBER                            = 'R0AH'
    constant integer UPG_LORDAERON_MASONRY                           = 'R0AI'
    constant integer UPG_LORDAERON_MELEE                             = 'R0AL'
    constant integer UPG_LORDAERON_ARMOR                             = 'R0AO'
    constant integer UPG_LORDAERON_RANGED                            = 'R0AP'
    constant integer UPG_LORDAERON_LEATHER                           = 'R0AQ'
    constant integer UPG_LORDAERON_DEFEND                            = 'R0AN'
    constant integer UPG_LORDAERON_LONG_RIFLES                       = 'R0AS'
    constant integer UPG_LORDAERON_BACKPACK                          = 'R0AG'
    constant integer UPG_LORDAERON_SORCERY                           = 'R0AX'
    constant integer UPG_LORDAERON_MAGE                              = 'R0AW'
    constant integer UPG_LORDAERON_RAIN_OF_FIRE                      = 'R0AY'
    constant integer UPG_LORDAERON_ANIMAL                            = 'R0AT'
    constant integer UPG_LORDAERON_CROSSBOWMEN                       = 'R0A6'
    constant integer UPG_LORDAERON_HUMAN_COURAGE                     = 'R0AZ'
    constant integer UPG_LORDAERON_ARCHERY                           = 'R0AM'
    constant integer UPG_LORDAERON_ENGINEERING                       = 'R0AR'
    constant integer UPG_LORDAERON_SCARLET_CRUSADE                   = 'R0AF'
    constant integer UPG_LORDAERON_SPEARMEN                          = 'R0A5'
    constant integer UPG_LORDAERON_SCARLET_MONASTERY                 = 'R0AD' // special building

    constant integer LORDAERON_WORKER                                = 'h0LY' // worker
    constant integer LORDAERON_AIR_SHIP                              = 'n0E2'
    constant integer LORDAERON_ALLIANCE_SIEGE_TOWER                  = 'h0OE'
    constant integer LORDAERON_ARCHER                                = 'n0DE'
    constant integer LORDAERON_BANNER_CARRIER                        = 'h0NA'
    constant integer LORDAERON_BATTLE_MAGE                           = 'h0N9'
    constant integer LORDAERON_CROSSBOWMAN                           = 'n0DI'
    constant integer LORDAERON_FOOTMAN                               = 'h0MV'
    constant integer LORDAERON_GRYPHON_RIDER                         = 'h0MS'
    constant integer LORDAERON_KNIGHT                                = 'h0MI'
    constant integer LORDAERON_MAGE                                  = 'h0MT'
    constant integer LORDAERON_PEGASUS_KNIGHT                        = 'h0MQ'
    constant integer LORDAERON_RIFLEMAN                              = 'h0N8'
    constant integer LORDAERON_SORCERESS                             = 'h0MU'
    constant integer LORDAERON_SPEARMAN                              = 'h0MR'
    constant integer LORDAERON_SCARLET_CRUSADE_PALADIN               = 'h0OK'

    constant integer LORDAERON_CITIZEN_MALE                          = 'n0DY'
    constant integer LORDAERON_CITIZEN_FEMALE                        = 'n0E0'
    constant integer LORDAERON_CHILD                                 = 'n0CV'
    constant integer LORDAERON_PET                                   = 'n00Q'
    constant integer LORDAERON_HOUSING                               = 'h0N7'

    // Stormwind
    constant integer STORMWIND_TIER_1                                = 'h0QY'
    constant integer ITEM_STORMWIND_TIER_1                           = 'I0TC'
    constant integer STORMWIND_TIER_2                                = 'h0RC'
    constant integer ITEM_STORMWIND_TIER_2                           = 'I17A'
    constant integer STORMWIND_TIER_3                                = 'h0RD'
    constant integer ITEM_STORMWIND_TIER_3                           = 'I17B'
    constant integer STORMWIND_ALTAR                                 = 'h0R1'
    constant integer ITEM_STORMWIND_ALTAR                            = 'I17E'
    constant integer STORMWIND_ARCANE_TOWER                          = 'h0RJ'
    constant integer ITEM_STORMWIND_ARCANE_TOWER                     = 'I17P'
    constant integer STORMWIND_BARRACKS                              = 'h0RB'
    constant integer ITEM_STORMWIND_BARRACKS                         = 'I17D'
    constant integer STORMWIND_BLACKSMITH                            = 'h0R8'
    constant integer ITEM_STORMWIND_BLACKSMITH                       = 'I17F'
    constant integer STORMWIND_CANNON_TOWER                          = 'h0RI'
    constant integer ITEM_STORMWIND_CANNON                           = 'I17O'
    constant integer STORMWIND_FARM                                  = 'h0R0'
    constant integer ITEM_STORMWIND_FARM                             = 'I17C'
    constant integer STORMWIND_AVIARY                                = 'h0R9'
    constant integer ITEM_STORMWIND_AVIARY                           = 'I17K'
    constant integer STORMWIND_GUARD_TOWER                           = 'h0RH'
    constant integer ITEM_STORMWIND_GUARD_TOWER                      = 'I17Q'
    constant integer STORMWIND_LUMBER_MILL                           = 'h0R3'
    constant integer ITEM_STORMWIND_LUMBER_MILL                      = 'I17G'
    constant integer STORMWIND_SCOUT_TOWER                           = 'h0R4'
    constant integer ITEM_STORMWIND_SCOUT_TOWER                      = 'I179'
    constant integer STORMWIND_MAGE_TOWER                            = 'h0RA'
    constant integer ITEM_STORMWIND_MAGE_TOWER                       = 'I17H'
    constant integer STORMWIND_CATHEDRAL_OF_LIGHT                    = 'h0RK' // special building
    constant integer ITEM_STORMWIND_CATHEDRAL_OF_LIGHT               = 'I17M'
    constant integer STORMWIND_ARCANE_VAULT                          = 'h0R2'
    constant integer ITEM_STORMWIND_ARCANE_VAULT                     = 'I17I'
    constant integer STORMWIND_WORKSHOP                              = 'h0R7'
    constant integer ITEM_STORMWIND_WORKSHOP                         = 'I17J'
    constant integer STORMWIND_SHIPYARD                              = 'h0RG'
    constant integer ITEM_STORMWIND_SHIPYARD                         = 'I17N'

    constant integer UPG_STORMWIND_LUMBER                            = 'R0ES'
    constant integer UPG_STORMWIND_MASONRY                           = 'R0ET'
    constant integer UPG_STORMWIND_MELEE                             = 'R0EU'
    constant integer UPG_STORMWIND_ARMOR                             = 'R0F1'
    constant integer UPG_STORMWIND_RANGED                            = 'R0F2'
    constant integer UPG_STORMWIND_LEATHER                           = 'R0F9'
    constant integer UPG_STORMWIND_DEFEND                            = 'R0EV'
    constant integer UPG_STORMWIND_BOWS                              = 'R0EW'
    constant integer UPG_STORMWIND_MARKSMANSHIP                      = 'R0EX'
    constant integer UPG_STORMWIND_SUNDERING_BLADES                  = 'R0FU'
    constant integer UPG_STORMWIND_BACKPACK                          = 'R0ER'
    constant integer UPG_STORMWIND_SORCERY                           = 'R0F6'
    constant integer UPG_STORMWIND_MAGE                              = 'R0F5'
    constant integer UPG_STORMWIND_PRIEST                            = 'R0F7'
    constant integer UPG_STORMWIND_ANIMAL                            = 'R0EZ'
    constant integer UPG_STORMWIND_UNMOUNT                           = 'R0EY'
    constant integer UPG_STORMWIND_MAGIC_SENTRY                      = 'R0F8'
    constant integer UPG_STORMWIND_REINFORCED_DEFENSES               = 'R0EP'
    constant integer UPG_STORMWIND_CATHEDRAL_OF_LIGHT                = 'R0EQ' // special building

    constant integer STORMWIND_WORKER                                = 'h0QZ' // worker
    constant integer STORMWIND_FOOTMAN                               = 'h0RS'
    constant integer STORMWIND_RANGER                                = 'n0I3'
    constant integer STORMWIND_KNIGHT                                = 'h0RU'
    constant integer STORMWIND_KNIGHT_UNMOUNTED                      = 'h0RT'
    constant integer STORMWIND_BANNER_CARRIER                        = 'h0RQ'
    constant integer STORMWIND_GRYPHON_KNIGHT                        = 'h0RP'
    constant integer STORMWIND_EAGLE_KNIGHT                          = 'h0S0'
    constant integer STORMWIND_GRYPHON_RIDER                         = 'h0RZ'
    constant integer STORMWIND_LION_RIDER                            = 'h0UM'
    constant integer STORMWIND_BISHOP                                = 'h0RL'
    constant integer STORMWIND_MAGE                                  = 'h0RM'
    constant integer STORMWIND_PRIEST                                = 'h0RX'
    constant integer STORMWIND_SORCERESS                             = 'h0RY'
    constant integer STORMWIND_ALLIANCE_SIEGE_TOWER                  = 'h0RE'
    constant integer STORMWIND_CANNON                                = 'h0RV'
    constant integer STORMWIND_AIR_SHIP                              = 'n0AU'

    constant integer STORMWIND_CITIZEN_MALE                          = 'n05S'
    constant integer STORMWIND_CITIZEN_FEMALE                        = 'n0E0'
    constant integer STORMWIND_CHILD                                 = 'n0CV'
    constant integer STORMWIND_PET                                   = 'n00Q'
    constant integer STORMWIND_HOUSING                               = 'h0RF'
    constant integer ITEM_STORMWIND_HOUSING                          = 'I17L'

    // Pandaren
    constant integer PANDAREN_TIER_1                                 = 'h06D' // tier 1
    constant integer PANDAREN_TIER_2                                 = 'h0AC' // tier 2
    constant integer PANDAREN_TIER_3                                 = 'h0AD' // tier 3
    constant integer PANDAREN_SHELTER                                = 'h06R' // farm
    constant integer PANDAREN_ELEMENTAL_SANCTUARY                    = 'h0AB' // arcane
    constant integer PANDAREN_ALTAR                                  = 'h0A7' // altar
    constant integer PANDAREN_WAR_ACADEMY                            = 'h0AH' // barracks
    constant integer PANDAREN_LUMBER_MILL                            = 'h0AE' // lumber mill
    constant integer PANDAREN_WORKSHOP                               = 'h0A9' // workshop
    constant integer PANDAREN_STORM_SPIRE                            = 'h0AF' // aviary
    constant integer PANDAREN_BREWERY                                = 'h0QH' // shop
    constant integer PANDAREN_SCOUT_TOWER                            = 'h06Q' // scout tower
    constant integer PANDAREN_GUARD_TOWER                            = 'h0TB' // guard tower
    constant integer PANDAREN_CANNON_TOWER                           = 'h0TA' // cannon tower
    constant integer PANDAREN_MAGIC_TOWER                            = 'h0QI' // arcane tower
    constant integer PANDAREN_JADE_FOREST                            = 'n0GQ' // special building
    constant integer PANDAREN_SHIPYARD                               = 'e01V'
    constant integer PANDAREN_BLACKSMITH                             = 'h0TC' // blacksmith

    constant integer UPG_PANDAREN_MELEE                              = 'R0DJ'
    constant integer UPG_PANDAREN_ARMOR                              = 'R0DK'
    constant integer UPG_PANDAREN_DRINK                              = 'R0DM'
    constant integer UPG_PANDAREN_DEFEND                             = 'R06I'
    constant integer UPG_PANDAREN_IMPROVED_BOWS                      = 'R090'
    constant integer UPG_PANDAREN_BACKPACK                           = 'R08Z'
    constant integer UPG_PANDAREN_DRUNK_PANDA                        = 'R091'
    constant integer UPG_PANDAREN_DRUID                              = 'R092'
    constant integer UPG_PANDAREN_MONK                               = 'R0DL'
    constant integer UPG_PANDAREN_SAGE                               = 'R0DS'
    constant integer UPG_PANDAREN_BERSERK                            = 'R0DU'
    constant integer UPG_PANDAREN_CHAIN_LIGHTNING                    = 'R0DO'
    constant integer UPG_PANDAREN_CLOUD                              = 'R0DP'
    constant integer UPG_PANDAREN_COMMAND_AURA                       = 'R0DR'
    constant integer UPG_PANDAREN_FIREWORK                           = 'R0DN'
    constant integer UPG_PANDAREN_FRAGMENTATION_SHARDS               = 'R0DT'
    constant integer UPG_PANDAREN_HARDENED_SKIN                      = 'R0DV'
    constant integer UPG_PANDAREN_JADE_FOREST                        = 'R0DQ' // special building
    constant integer UPG_PANDAREN_MAGIC_SENTRY                       = 'R0DI'
    constant integer UPG_PANDAREN_SPIKED_SHELL                       = 'R0DW'
    constant integer UPG_PANDAREN_BAMBOO_STICKS                      = 'R0FU'

    constant integer PANDAREN_WOODCUTTER                             = 'h067' // worker
    constant integer PANDAREN_ARCHER                                 = 'h0B0'
    constant integer PANDAREN_HONORGUARD                             = 'h0B1'
    constant integer PANDAREN_WARLORD                                = 'h0AG'
    constant integer PANDAREN_SHAMAN                                 = 'o04N' // monk
    constant integer PANDAREN_SAGE                                   = 'h0AA'
    constant integer PANDAREN_DRUID                                  = 'e01E'
    constant integer PANDAREN_DRAGON_TURTLE                          = 'n0GO'
    constant integer PANDAREN_FIREWORK_TEAM                          = 'h0A8'
    constant integer PANDAREN_PRIMAL_PANDAREN                        = 'n0GR'
    constant integer PANDAREN_CLOUD_SERPENT                          = 'e01D'
    constant integer PANDAREN_GIANT_SEA_TURTLE                       = 'n0GS'

    constant integer PANDAREN_TRANSPORT_SHIP                         = 'e01W'
    constant integer PANDAREN_BATTLESHIP                             = 'e01X'

    constant integer PANDAREN_CITIZEN_MALE                           = 'n08M'
    constant integer PANDAREN_CITIZEN_FEMALE                         = 'n08N'
    constant integer PANDAREN_CHILD                                  = 'n064'
    constant integer PANDAREN_PET                                    = 'n0GP'
    constant integer PANDAREN_HOUSING                                = 'h0JU'

    // Troll
    constant integer TROLL_TIER_1                                    = 'o029'
    constant integer TROLL_TIER_2                                    = 'o02A'
    constant integer TROLL_TIER_3                                    = 'o02B'
    constant integer TROLL_HUT                                       = 'o02E' // farm
    constant integer TROLL_WAR_MILL                                  = 'o04V' // lumber mill
    constant integer TROLL_ALTAR_OF_BLOOD                            = 'o02P' // altar
    constant integer TROLL_SPIRIT_LODGE                              = 'o02F' // spirit lodge
    constant integer TROLL_ICE_TROLL_HUT                             = 'o04R' // tauren totem
    constant integer TROLL_BESTIARY                                  = 'o02I' // beastiary
    constant integer TROLL_WATCH_TOWER                               = 'o04X'
    constant integer TROLL_BARRACKS                                  = 'o02D' // barracks
    constant integer TROLL_VOODOO_LOUNGE                             = 'o04U' // shop
    constant integer TROLL_TEMPLE_OF_SACRIFICE                       = 'o050' // special building
    constant integer TROLL_SHIPYARD                                  = 'o051'

    constant integer UPG_TROLL_SPEARS                                = 'R09E'
    constant integer UPG_TROLL_ARMOR                                 = 'R09H'
    constant integer UPG_TROLL_CREATURE_ATTACK                       = 'R09F'
    constant integer UPG_TROLL_CREATURE_ARMOR                        = 'R09G'
    constant integer UPG_TROLL_TROLL_REGENEARTION                    = 'R096'
    constant integer UPG_TROLL_ICE_TROLL_HIGH_PRIEST                 = 'R09A'
    constant integer UPG_TROLL_TRUESHOT_AURA                         = 'R098'
    constant integer UPG_TROLL_WAR_DRUMS                             = 'R09K'
    constant integer UPG_TROLL_TROLL_HEXER                           = 'R09I'
    constant integer UPG_TROLL_SHAMAN                                = 'R09J'
    constant integer UPG_TROLL_TROLL_WITCH_DOCTOR                    = 'R09B'
    constant integer UPG_TROLL_TROLL_BLOODMAGE                       = 'R09L'
    constant integer UPG_TROLL_TROLL_TRIBES                          = 'R094'
    constant integer UPG_TROLL_BERSERKER                             = 'R097'
    constant integer UPG_TROLL_LIQUID_FIRE                           = 'R095'
    constant integer UPG_TROLL_BARRAGE                               = 'R09D'
    constant integer UPG_TROLL_BACKPACK                              = 'R099'
    constant integer UPG_TROLL_TEMPLE_OF_SACRIFICE                   = 'R09C'

    constant integer TROLL_GATHERER                                  = 'o02C' // worker
    constant integer TROLL_MAN_HUNTER                                = 'o02H'
    constant integer TROLL_HEAD_HUNTER                               = 'o04T'
    constant integer TROLL_RIDER                                     = 'o04Q'
    constant integer TROLL_VOODOO_CANNONEER                          = 'o04Z' // demolisher
    constant integer TROLL_WITCH_DOCTOR                              = 'o04W'
    constant integer TROLL_SHAMAN                                    = 'o02G'
    constant integer TROLL_BATRIDER                                  = 'o04O'
    constant integer TROLL_BAT                                       = 'o02J'
    constant integer TROLL_THRONE_OF_WAR                             = 'o04S'
    constant integer TROLL_ICE_TROLL_HIGH_PRIEST                     = 'n07Z'
    constant integer TROLL_ICE_TROLL_WARLORD                         = 'n0CO'
    constant integer TROLL_BLOOD_MAGE                                = 'o02L'
    constant integer TROLL_HEXER                                     = 'o02K'
    constant integer TROLL_TIGERSHARK_RIDER                          = 'n07Y'

    constant integer TROLL_CITIZEN_MALE                              = 'n07X'
    constant integer TROLL_CITIZEN_FEMALE                            = 'n081'
    constant integer TROLL_CHILD                                     = 'n0CX'
    constant integer TROLL_PET                                       = 'n09V'
    constant integer TROLL_HOUSING                                   = 'h098'

    // Tauren
    constant integer TAUREN_TIER_1                                    = 'o02M'
    constant integer TAUREN_TIER_2                                    = 'o037'
    constant integer TAUREN_TIER_3                                    = 'o038'
    constant integer TAUREN_TAUREN_BARRACKS                           = 'o03A'
    constant integer TAUREN_ALTAR                                     = 'o06D'
    constant integer TAUREN_LUMBER_MILL                               = 'o03B'
    constant integer TAUREN_SPIRIT_LODGE                              = 'o03H'
    constant integer TAUREN_SPIRIT_LOUNGE                             = 'o03F'
    constant integer TAUREN_TAUREN_TOTEM                              = 'o06K'
    constant integer TAUREN_TENT                                      = 'o039'
    constant integer TAUREN_TOTEM_POLE                                = 'o06P'
    constant integer TAUREN_WYVERN_ROOST                              = 'o03C'
    constant integer TAUREN_WATCH_TOWER                               = 'o03G'

    constant integer UPG_TAUREN_ARMOR                                 = 'R0DE'
    constant integer UPG_TAUREN_MELEE                                 = 'R0DF'
    constant integer UPG_TAUREN_RANGED                                = 'R0DG'
    constant integer UPG_TAUREN_BACKPACK                              = 'R0D5'
    constant integer UPG_TAUREN_EARTH_MOTHER                          = 'R0D6'
    constant integer UPG_TAUREN_INVISIBILITY                          = 'R0DD'
    constant integer UPG_TAUREN_PULVERIZE                             = 'R0DC'
    constant integer UPG_TAUREN_SPIRIT_WALKER                         = 'R0D7'
    constant integer UPG_TAUREN_DRUID                                 = 'R0D8'
    constant integer UPG_TAUREN_WAR_DRUMS                             = 'R0DB'
    constant integer UPG_TAUREN_ELITE_TAUREN                          = 'R0D9'
    constant integer UPG_TAUREN_TOTEM_POLE                            = 'R0DA'

    constant integer TAUREN_ELITE_TAUREN                              = 'o06M'
    constant integer TAUREN_KODO_BEAST_RIDERLESS                      = 'o06G'
    constant integer TAUREN_KODO_BEAST_RIDER                          = 'o06Q'
    constant integer TAUREN_SPIRIT_WALKER                             = 'o06J'
    constant integer TAUREN_SPIRIT_WALKER_ETHERAL                     = 'o06O'
    constant integer TAUREN_SPIRIT_WYVERN                             = 'o03E'
    constant integer TAUREN_TAUREN                                    = 'o06L'
    constant integer TAUREN_TAUREN_AXE_FIGHTER                        = 'o06E'
    constant integer TAUREN_TAUREN_CATAPULT                           = 'o06F'
    constant integer TAUREN_TAUREN_DRUID                              = 'o06H'
    constant integer TAUREN_TAUREN_DRUID_CAT                          = 'o06I'
    constant integer TAUREN_TAUREN_SPEAR_THROWER                      = 'o06N'
    constant integer TAUREN_TAUREN_WORKER                             = 'o02N'
    constant integer TAUREN_WYVERN                                    = 'o03D'

    constant integer TAUREN_CITIZEN_MALE                              = 'n09Z'
    constant integer TAUREN_CITIZEN_FEMALE                            = 'n0BM'
    constant integer TAUREN_CHILD                                     = 'n0LP'
    constant integer TAUREN_PET                                       = 'n0BN'
    constant integer TAUREN_HOUSING                                   = 'h0H1'

    // Worgen
    constant integer WORGEN_TOWN_HALL                                = 'h0IU'
    constant integer WORGEN_KEEP                                     = 'h0IZ'
    constant integer WORGEN_CASTLE                                   = 'h0IV'
    constant integer WORGEN_BARRACKS                                 = 'h0J6'
    constant integer WORGEN_ALTAR                                    = 'h0J0'
    constant integer WORGEN_BLACKSMITH                               = 'h0J4'
    constant integer WORGEN_WIZARD_TOWER                             = 'h0IY' // sanctuary
    constant integer WORGEN_HOUSE                                    = 'h0J3' // farm
    constant integer WORGEN_LUMBER_MILL                              = 'h0J7'
    constant integer WORGEN_WORKSHOP                                 = 'h0JE'
    constant integer WORGEN_MANOR                                    = 'h0J8' // aviary
    constant integer WORGEN_TRADE_HOUSE                              = 'h0J5' // shop
    constant integer WORGEN_SCOUT_TOWER                              = 'h0JF'
    constant integer WORGEN_GUARD_TOWER                              = 'h0JG'
    constant integer WORGEN_ARCANE_TOWER                             = 'h0JI'
    constant integer WORGEN_CANNON_TOWER                             = 'h0JH'
    constant integer WORGEN_CATHEDRAL                                = 'h0J9'
    constant integer WORGEN_GREYMANE_WALL                            = 'h0PP'
    constant integer WORGEN_SHIPYARD                                 = 'h0JB'

    constant integer ITEM_WORGEN_TIER_2                              = 'I0P3'
    constant integer ITEM_WORGEN_TIER_3                              = 'I0P4'
    constant integer ITEM_WORGEN_BARRACKS                            = 'I0PC'
    constant integer ITEM_WORGEN_LUMBER_MILL                         = 'I0P6'
    constant integer ITEM_WORGEN_ALTAR                               = 'I0P8'
    constant integer ITEM_WORGEN_SHOP                                = 'I0P9'
    constant integer ITEM_WORGEN_HOUSE                               = 'I0P5'
    constant integer ITEM_WORGEN_BLACKSMITH                          = 'I0P7'
    constant integer ITEM_WORGEN_WIZARD_TOWER                        = 'I0PK'
    constant integer ITEM_WORGEN_WORKSHOP                            = 'I0PH'
    constant integer ITEM_WORGEN_MANOR                               = 'I0PA'
    constant integer ITEM_WORGEN_SCOUT_TOWER                         = 'I0PG'
    constant integer ITEM_WORGEN_GUARD_TOWER                         = 'I0PF'
    constant integer ITEM_WORGEN_CANNON_TOWER                        = 'I0PD'
    constant integer ITEM_WORGEN_ARCANE_TOWER                        = 'I0PB'
    constant integer ITEM_WORGEN_CATHEDRAL                           = 'I0PE'
    constant integer ITEM_WORGEN_GREYMANE_WALL                       = 'I0PL'
    constant integer ITEM_WORGEN_HOUSING                             = 'I0PJ'
    constant integer ITEM_WORGEN_SHIPYARD                            = 'I0PI'

    constant integer UPG_WORGEN_DRUID                                = 'R08U'
    constant integer UPG_WORGEN_NOCTURNAL                            = 'R08X'
    constant integer UPG_WORGEN_CURSE                                = 'R08T'
    constant integer UPG_WORGEN_BACKPACK                             = 'R08V'
    constant integer UPG_WORGEN_CATHEDRAL                            = 'R08W'
    constant integer UPG_WORGEN_GREYMANE_WALL                        = 'R0CB'
    constant integer UPG_WORGEN_ANIMAL_WAR_TRAINING                  = 'R0BX'
    constant integer UPG_WORGEN_BARRAGE                              = 'R0C8'
    constant integer UPG_WORGEN_CARGO                                = 'R0CA'
    constant integer UPG_WORGEN_DEFEND                               = 'R0C3'
    constant integer UPG_WORGEN_NIGHTSTALKER                         = 'R0C4'
    constant integer UPG_WORGEN_RAIN_OF_FIRE                         = 'R0C9'
    constant integer UPG_WORGEN_ROCKETS                              = 'R0BY'
    constant integer UPG_WORGEN_SLOW_POISON                          = 'R0BV'
    constant integer UPG_WORGEN_WORGEN_CLAWS                         = 'R0C5'
    constant integer UPG_WORGEN_ARMOR                                = 'R0C6'
    constant integer UPG_WORGEN_RANGE                                = 'R0C7'
    constant integer UPG_WORGEN_HUMAN_COURAGE                        = 'R0C2'
    constant integer UPG_WORGEN_IMPROVED_CRITICAL_STRIKE             = 'R0BU'
    constant integer UPG_WORGEN_IMPROVED_WALL                        = 'R0C0'
    constant integer UPG_WORGEN_LONG_RIFLES                          = 'R0BW'
    constant integer UPG_WORGEN_MAGIC_SENTRY                         = 'R0BZ'

    constant integer WORGEN_PEASANT                                  = 'h0IT'
    constant integer WORGEN_FOOTMAN                                  = 'h0JD'
    constant integer WORGEN_RIFLEMAN                                 = 'h0JC'
    constant integer WORGEN_KNIGHT                                   = 'h0IW'
    constant integer WORGEN_DRUID                                    = 'h0IX'
    constant integer WORGEN_BANNER_CARRIER                           = 'h0PG'
    constant integer WORGEN_BATTLE_MAGE                              = 'h0PI'
    constant integer WORGEN_GILNEAS_GUNSHIP                          = 'h0PF'
    constant integer WORGEN_MANTICORE                                = 'e01G'
    constant integer WORGEN_MINDLESS_WORGEN                          = 'o05J'
    constant integer WORGEN_NIGHTSTALKER                             = 'h0PJ'
    constant integer WORGEN_STORMCROW_KNIGHT                         = 'h0PH'
    constant integer WORGEN_TRANSPORT_SHIP                           = 'h0PK'
    constant integer WORGEN_FRIGATE                                  = 'h0PL'
    constant integer WORGEN_BATTLESHIP                               = 'h0PM'

    constant integer WORGEN_CITIZEN_MALE                             = 'n0C5'
    constant integer WORGEN_CITIZEN_FEMALE                           = 'n0C6'
    constant integer WORGEN_CHILD                                    = 'n0OD'
    constant integer WORGEN_PET                                      = 'n0C7'
    constant integer WORGEN_HOUSING                                  = 'h0JA'

    // Vrykul
    constant integer VRYKUL_TIER_1                                   = 'h0IA'
    constant integer VRYKUL_TIER_2                                   = 'h0IB'
    constant integer VRYKUL_TIER_3                                   = 'h0IC'
    constant integer VRYKUL_ALTAR                                    = 'h0OF'
    constant integer VRYKUL_FISHER_HOUSE                             = 'h0IE'
    constant integer VRYKUL_LONGHOUSE                                = 'h0IJ'
    constant integer VRYKUL_PROTO_DRAKE_ROOST                        = 'n0BY'
    constant integer VRYKUL_VALKYR_TEMPLE                            = 'h0P4'
    constant integer VRYKUL_BEASTIARY                                = 'h0P5'
    constant integer VRYKUL_BLACKSMITH                               = 'h0P6'
    constant integer VRYKUL_LAMP                                     = 'h0P7' // scout tower
    constant integer VRYKUL_SHIPYARD                                 = 'h0IN'
    constant integer VRYKUL_INN                                      = 'h0PB' // shop
    constant integer VRYKUL_HALL_OF_VALOR                            = 'h0PD' // special building

    constant integer UPG_VRYKUL_BACKPACK                             = 'R0BE'
    constant integer UPG_VRYKUL_DEFEND                               = 'R0BF'
    constant integer UPG_VRYKUL_DEVOUR                               = 'R0BI'
    constant integer UPG_VRYKUL_SPIKED_SHELL                         = 'R0BG'
    constant integer UPG_VRYKUL_VALKYR_DARK                          = 'R0BL'
    constant integer UPG_VRYKUL_VALKYR_GOLDEN                        = 'R0BK'
    constant integer UPG_VRYKUL_RUNECARVER                           = 'R0BS'
    constant integer UPG_VRYKUL_LUMBER                               = 'R0BJ'
    constant integer UPG_VRYKUL_HALLS_OF_VALOR                       = 'R0BH' // special building
    constant integer UPG_VRYKUL_CREATURE_ATTACK                      = 'R0BP'
    constant integer UPG_VRYKUL_CREATURE_SKIN                        = 'R0BQ'
    constant integer UPG_VRYKUL_IRON_SWORDS                          = 'R0BN'
    constant integer UPG_VRYKUL_IRON_PLATING                         = 'R0BO'
    constant integer UPG_VRYKUL_RESISTANT_SKIN                       = 'R0BM'
    constant integer UPG_VRYKUL_GIANTS                               = 'R0BR'
    constant integer UPG_VRYKUL_ULTRAVISION                          = 'R0BT'

    constant integer VRYKUL_WARRIOR                                  = 'h0IK' // footman
    constant integer VRYKUL_SPEAR_CARRIER                            = 'h0IM' // rifleman
    constant integer VRYKUL_MAMMOTH_RIDER                            = 'h0IL' // knight
    constant integer VRYKUL_PROTO_DRAKE                              = 'n0BZ' // gryphon rider
    constant integer VRYKUL_VALKYR_GOLDEN                            = 'n0EW' // priest
    constant integer VRYKUL_VALKYR_DARK                              = 'n0EV' // sorceress
    constant integer VRYKUL_UNDEAD_VRYKUL                            = 'n0F1'
    constant integer VRYKUL_RUNECARVER                               = 'h0IP'
    constant integer VRYKUL_ARMORED_WOLF                             = 'n0EZ'
    constant integer VRYKUL_MAMMOTH                                  = 'n0F0'
    constant integer VRYKUL_GIANT_POLAR_BEAR                         = 'n0F6'
    constant integer VRYKUL_RAKKAR_SHIP                              = 'h0IO'

    constant integer VRYKUL_WORKER                                   = 'h0ID'

    constant integer VRYKUL_CITIZEN_MALE                             = 'n0F4'
    constant integer VRYKUL_CITIZEN_FEMALE                           = 'n0F5'
    constant integer VRYKUL_CHILD                                    = 'n0OE'
    constant integer VRYKUL_PET                                      = 'n0C7'
    constant integer VRYKUL_HOUSING                                  = 'h0PC'

    // Tuskarr
    constant integer TUSKARR_FROZEN_HALL                             = 'o05N' // tier 1
    constant integer TUSKARR_FROZEN_STRONGHOLD                       = 'o05Y' // tier 2
    constant integer TUSKARR_FROZEN_FORTRESS                         = 'o05Z' // tier 3
    constant integer TUSKARR_ALTAR_OF_ICE                            = 'o05O' // altar
    constant integer TUSKARR_BLOCK_OF_ICE                            = 'o060' // scout/watch tower base
    constant integer TUSKARR_ICE_WALL                                = 'o061' // cannon tower
    constant integer TUSKARR_SPIDER_SHRINE                           = 'o062' // guard tower
    constant integer TUSKARR_FROST_SNOWMAN                           = 'o063' // arcane tower
    constant integer TUSKARR_HUNTERS_REST                            = 'o05Q' // beastiary/workshop
    constant integer TUSKARR_ICE_CUTTERS_LODGE                       = 'o05W' // arcane sanctuary
    constant integer TUSKARR_DECORATED_CAVERN                        = 'o05V' // tauren totem
    constant integer TUSKARR_ICY_SPIRE                               = 'o05X' // lumber mill/blacksmith
    constant integer TUSKARR_IGLOO_BARRACKS                          = 'o05S' // barracks
    constant integer TUSKARR_NORTHERN_VENDOR_SHOP                    = 'o05U' // shop
    constant integer TUSKARR_IGLOO                                   = 'o05P' // farm
    constant integer TUSKARR_TUSKARR_SHIPYARD                        = 'o064'
    constant integer TUSKARR_BURIAL_PLACE                            = 'n0FY' // special building

    constant integer UPG_TUSKARR_BACKPACK                            = 'R0CC'
    constant integer UPG_TUSKARR_BEAST_PROTECTION                    = 'R0CH'
    constant integer UPG_TUSKARR_CLANS                               = 'R0CL'
    constant integer UPG_TUSKARR_CLEAVING_ATTACK                     = 'R0CQ'
    constant integer UPG_TUSKARR_CRITICAL_STRIKE                     = 'R0CT'
    constant integer UPG_TUSKARR_DEVOUR                              = 'R0CM'
    constant integer UPG_TUSKARR_ELITE_ARMORED_POLAR_BEAR            = 'R0CP'
    constant integer UPG_TUSKARR_ENSNARE                             = 'R0CR'
    constant integer UPG_TUSKARR_ETHERAL_BEASTS                      = 'R0CI'
    constant integer UPG_TUSKARR_FROST_IMMUNITY                      = 'R0CE'
    constant integer UPG_TUSKARR_IMPROVED_FISHING                    = 'R0CG'
    constant integer UPG_TUSKARR_MAGIC_SENTRY                        = 'R0CJ'
    constant integer UPG_TUSKARR_SHAMAN_ADEPT_TRAINING               = 'R0CN'
    constant integer UPG_TUSKARR_TUSKARR_ARMOR                       = 'R0CF'
    constant integer UPG_TUSKARR_HARPOONS                            = 'R0CK'
    constant integer UPG_TUSKARR_HEALER_ADEPT_TRAINING               = 'R0CO'
    constant integer UPG_TUSKARR_TUSKARR_WEAPONS                     = 'R0CD'
    constant integer UPG_TUSKARR_WAR_STOMP                           = 'R0CS'
    constant integer UPG_TUSKARR_BURIAL_PLACE                        = 'R0CU' // special building

    constant integer TUSKARR_WORKER                                  = 'o05M' // worker
    constant integer TUSKARR_GIANT_SNOWY_OWL                         = 'n0FJ' // gryphon
    constant integer TUSKARR_GIANT_FROST_WOLF                        = 'n0FI'
    constant integer TUSKARR_ICETUSK_MAMMOTH                         = 'n0FK' // siege engine
    constant integer TUSKARR_POLAR_BEAR                              = 'n0FL' // sieg engine
    constant integer TUSKARR_ELITE_ARMORED_POLAR_BEAR                = 'n0FX' // elite siege engine
    constant integer TUSKARR_CHIEFTAIN                               = 'n0FF' // tauren
    constant integer TUSKARR_FIGHTER                                 = 'n0FD' // footman
    constant integer TUSKARR_SPEARMAN                                = 'o0FE' // rifleman
    constant integer TUSKARR_MAMMOTH_RIDER                           = 'o05T' // knight
    constant integer TUSKARR_HEALER                                  = 'n0FM' // priest
    constant integer TUSKARR_SHAMAN                                  = 'o05R' // sorceress
    constant integer TUSKARR_FISHING_BOAT                            = 'h0PU'

    constant integer TUSKARR_PET_SEAL                                = 'n0FH'
    constant integer TUSKARR_CITIZEN_FEMALE                          = 'n0FN'
    constant integer TUSKARR_CITIZEN_MALE                            = 'n0FG'
    constant integer TUSKARR_CHILD                                   = 'n07E'
    constant integer TUSKARR_HOUSING                                 = 'h0PT'

    // Nerubian
    constant integer NERUBIAN_TIER_1                                 = 'u01Q'
    constant integer NERUBIAN_TIER_1_BURROWED                        = 'u01R'
    constant integer NERUBIAN_TIER_2                                 = 'u023'
    constant integer NERUBIAN_TIER_2_BURROWED                        = 'u02N'
    constant integer NERUBIAN_TIER_3                                 = 'u024'
    constant integer NERUBIAN_TIER_3_BURROWED                        = 'u02O'
    constant integer NERUBIAN_ALTAR                                  = 'u01U'
    constant integer NERUBIAN_ALTAR_BURROWED                         = 'u02G'
    constant integer NERUBIAN_ANCIENT_SHRINE                         = 'u02B' // sanctuary
    constant integer NERUBIAN_ANCIENT_SHRINE_BURROWED                = 'u02P'
    constant integer NERUBIAN_HATCHERY                               = 'u029' // mill/forge
    constant integer NERUBIAN_HATCHERY_BURROWED                      = 'u02Q'
    constant integer NERUBIAN_TOWER                                  = 'u02A' // watch tower
    constant integer NERUBIAN_TOWER_BURROWED                         = 'u02F'
    constant integer NERUBIAN_TUNNEL                                 = 'u028' // sacrifical pit
    constant integer NERUBIAN_ZIGGURAT                               = 'u01S' // farm
    constant integer NERUBIAN_ZIGGURAT_BURROWED                      = 'u01T'
    constant integer NERUBIAN_NEST                                   = 'u02D' // slaughterhouse
    constant integer NERUBIAN_NEST_BURROWED                          = 'u02L'
    constant integer NERUBIAN_SPAWNING_GROUND                        = 'u025' // boneyard
    constant integer NERUBIAN_SPAWNING_GROUND_BURROWED               = 'u02J'
    constant integer NERUBIAN_SPAWNING_PIT                           = 'u01Z' // barracks
    constant integer NERUBIAN_SPAWNING_PIT_BURROWED                  = 'u02M'
    constant integer NERUBIAN_VAULT_OF_RELICS                        = 'u026' // shop
    constant integer NERUBIAN_VAULT_OF_RELICS_BURROWED               = 'u02K'
    constant integer NERUBIAN_AZJOL_NERUB                            = 'n0EH' // special building
    constant integer NERUBIAN_SHIPYARD                               = 'u037'

    constant integer UPG_NERUBIAN_ANCIENT_POWER                      = 'R0BC' // skeletal mastery
    constant integer UPG_NERUBIAN_AZJOL_NERUB                        = 'R0B5' // special building
    constant integer UPG_NERUBIAN_BACKPACK                           = 'R0B3'
    constant integer UPG_NERUBIAN_COCOON                             = 'R0B1'
    constant integer UPG_NERUBIAN_CORROSIVE_BREATH                   = 'R0BD'
    constant integer UPG_NERUBIAN_IMPROVED_ANCIENT_ARCHITECTURE      = 'R0B9'
    constant integer UPG_NERUBIAN_ARMOR                              = 'R0B7'
    constant integer UPG_NERUBIAN_WEAPONS                            = 'R0B6'
    constant integer UPG_NERUBIAN_WINGS                              = 'R0B8'
    constant integer UPG_NERUBIAN_SEER                               = 'R0BA'
    constant integer UPG_NERUBIAN_WEBSPINNER                         = 'R0BB'
    constant integer UPG_NERUBIAN_SPAWN_SPIDERLINGS                  = 'R0B2'
    constant integer UPG_NERUBIAN_SPIDER_EGG                         = 'R0B4'
    constant integer UPG_NERUBIAN_SPIDER_POISON                      = 'R0AJ'
    constant integer UPG_NERUBIAN_WEB                                = 'R0AK'

    constant integer NERUBIAN_WORKER                                 = 'u01P'
    constant integer NERUBIAN_WORKER_BURROWED                        = 'u02R'
    constant integer NERUBIAN_CRYPT_DRONE                            = 'u021'
    constant integer NERUBIAN_CRYPT_DRONE_COCOON                     = 'u022'
    constant integer NERUBIAN_CRYPT_FIEND                            = 'u020'
    constant integer NERUBIAN_CRYPT_FIEND_BURROWED                   = 'u02E'
    constant integer NERUBIAN_FLYING_BOMBARDER                       = 'u02C'
    constant integer NERUBIAN_QUEEN                                  = 'n0EB'
    constant integer NERUBIAN_QUEEN_BURROWED                         = 'n0ER'
    constant integer NERUBIAN_SEER                                   = 'n0EF'
    constant integer NERUBIAN_SEER_BURROWED                          = 'n0EQ'
    constant integer NERUBIAN_SPEAR_THROWER                          = 'n0EI'
    constant integer NERUBIAN_SPEAR_THROWER_BURROWED                 = 'n0EP'
    constant integer NERUBIAN_SPIDER_LORD                            = 'n0EG'
    constant integer NERUBIAN_SPIDER_LORD_BURROWED                   = 'n0EO'
    constant integer NERUBIAN_WARRIOR                                = 'n0E8' // footman
    constant integer NERUBIAN_WARRIOR_BURROWED                       = 'n0EN'
    constant integer NERUBIAN_WEBSPINNER                             = 'n0EJ'
    constant integer NERUBIAN_WEBSPINNER_BURROWED                    = 'n0EM'

    constant integer NERUBIAN_CITIZEN_MALE                           = 'n0E9'
    constant integer NERUBIAN_CITIZEN_FEMALE                         = 'n0EA'
    constant integer NERUBIAN_CHILD                                  = 'n065'
    constant integer NERUBIAN_PET                                    = 'n0EC'
    constant integer NERUBIAN_HOUSING                                = 'h0OX'
    constant integer NERUBIAN_HOUSING_BURROWED                       = 'h0P1'

    // Murloc
    constant integer MURLOC_TIER_1                                   = 'n0FP'
    constant integer MURLOC_TIER_2                                   = 'n0G6'
    constant integer MURLOC_TIER_3                                   = 'n0G5'
    constant integer MURLOC_ALTAR                                    = 'n0FZ'
    constant integer MURLOC_SHOP                                     = 'h0PZ'
    constant integer MURLOC_HUT                                      = 'o067'
    constant integer MURLOC_BLADEMAKING_HUT                          = 'o06A' // Forge
    constant integer MURLOC_BARRACKS                                 = 'n0FQ'
    constant integer MURLOC_LUMBER_KEEP                              = 'o068'
    constant integer MURLOC_FISHER                                   = 'o069' // special building
    constant integer MURLOC_HATCHLING_GROUNDS                        = 'n0G1' // beastiary
    constant integer MURLOC_SORCERER_DEN                             = 'n0G0' // sanctuary
    constant integer MURLOC_BONE_CHIPPER                             = 'n0JW' // tower

    constant integer UPG_MURLOC_BACKPACK                             = 'R0CV'
    constant integer UPG_MURLOC_DAMAGE                               = 'R0G8'
    constant integer UPG_MURLOC_ARMOR                                = 'R0G9'
    constant integer UPG_MURLOC_BUBBLE_MAGE                          = 'R0CY'
    constant integer UPG_MURLOC_SHADOW_CASTER                        = 'R0CZ'
    constant integer UPG_MURLOC_CULTIST                              = 'R0GE'
    constant integer UPG_MURLOC_RIVER_BANK                           = 'R0D0'
    constant integer UPG_MURLOC_EGGS                                 = 'R0CX'
    constant integer UPG_MURLOC_SWARMING                             = 'R0D1'
    constant integer UPG_MURLOC_PULVERIZE                            = 'R0HZ'
    constant integer UPG_MURLOC_SIEGE_DRAGON_TURTLE                  = 'R0I1'
    constant integer UPG_MURLOC_FISHER                               = 'R0CW' // special building

    constant integer MURLOC_WORKER                                   = 'n0FO'
    constant integer MURLOC_TIDESRUNNER                              = 'n0FR' // footman
    constant integer MURLOC_HUNTER                                   = 'n0G3' // rifleman
    constant integer MURLOC_FLESH_EATER                              = 'n0G2' // knight
    constant integer MURLOC_BUBBLE_MAGE                              = 'n0G7' // sorceress
    constant integer MURLOC_SHADOWCASTER                             = 'n0G9' // priest
    constant integer MURLOC_CULTIST                                  = 'n0JB' // spellbreaker
    constant integer MURLOC_DRAGON_TURTLE                            = 'n0FS' // catapult
    constant integer MURLOC_SNAP_DRAGON                              = 'n0AR' // mortar
    constant integer MURLOC_COUATL                                   =  'n0BA' // weak air
    constant integer MURLOC_SEA_GIANT                                = 'n0G8' // tauren

    constant integer MURLOC_CITIZEN_MALE                             = 'n0G4'
    constant integer MURLOC_CITIZEN_FEMALE                           = 'n0JV'
    constant integer MURLOC_CHILD                                    = 'n09J'
    constant integer MURLOC_PET                                      = 'n05K'
    constant integer MURLOC_HOUSING                                  = 'h0Q0'

    // Ogre
    constant integer OGRE_TIER_1                                     = 'o06C'
    constant integer OGRE_TIER_2                                     = 'o073'
    constant integer OGRE_TIER_3                                     = 'o074'
    constant integer OGRE_ALTAR                                      = 'o07B'
    constant integer OGRE_MAGI_LODGE                                 = 'o076' // sanctuary
    constant integer OGRE_FORGE                                      = 'o079' // mill/forge
    constant integer OGRE_BOULDER_TOWER                              = 'n0HR' // watch tower
    constant integer OGRE_ADVANCED_BOULDER_TOWER                     = 'n0HS' // arcane tower
    constant integer OGRE_TENT                                       = 'o06S' // farm
    constant integer OGRE_BEASTIARY                                  = 'o078' // slaughterhouse
    constant integer OGRE_ARENA                                      = 'o075' // boneyard
    constant integer OGRE_CAVE                                       = 'o06R' // barracks
    constant integer OGRE_DRAENOR_MERCHANT                           = 'o07A' // shop
    constant integer OGRE_STONEMAUL_CAMP                             = 'o07D' // special building

    constant integer UPG_OGRE_AMBUSH                                 = 'R0EA'
    constant integer UPG_OGRE_BACKPACK                               = 'R0D4'
    constant integer UPG_OGRE_BREATH_OF_FIRE                         = 'R0EE'
    constant integer UPG_OGRE_DEMOLISH                               = 'R0EI'
    constant integer UPG_OGRE_ENSNARE                                = 'R0E6'
    constant integer UPG_OGRE_LIGHTNING_ATTACK                       = 'R0EJ'
    constant integer UPG_OGRE_NECROMANCER                            = 'R0EF'
    constant integer UPG_OGRE_ARMOR                                  = 'R0E5'
    constant integer UPG_OGRE_MELEE                                  = 'R0E4'
    constant integer UPG_OGRE_MAGI                                   = 'R0EB'
    constant integer UPG_OGRE_RANGED                                 = 'R0ED'
    constant integer UPG_OGRE_STRENGTH                               = 'R0E9'
    constant integer UPG_OGRE_WARLOCK                                = 'R0EC'
    constant integer UPG_OGRE_PULVERIZE                              = 'R0E7'
    constant integer UPG_OGRE_REINCARNATION                          = 'R0EH'
    constant integer UPG_OGRE_RESISTANT_SKIN                         = 'R0E8'
    constant integer UPG_OGRE_ROAR                                   = 'R0EL'
    constant integer UPG_OGRE_SUMMON_BEAR                            = 'R0EK'
    constant integer UPG_OGRE_TAUNT                                  = 'R0EG'
    constant integer UPG_OGRE_WAR_STOMP                              = 'R0EO'
    constant integer UPG_OGRE_STONEMAUL_CAMP                         = 'R0EN'
    constant integer UPG_OGRE_GRONN_CLUBS                            = 'R0F3'

    constant integer OGRE_OGRE_SLAVE                                 = 'o06B' // worker
    constant integer OGRE_OGRE_WARRIOR                               = 'n0GN' // footman
    constant integer OGRE_OGRE_STONE_THROWER                         = 'n0GM' // rifleman
    constant integer OGRE_OGRE_HUNTER                                = 'n0HQ' // raider/rifleman 2
    constant integer OGRE_BRONZE_DRAKE                               = 'n0HP' // wind rider
    constant integer OGRE_ZEPPELIN                                   = 'n0HX' // zeppelin
    constant integer OGRE_CLEFTHOOF                                  = 'o077' // clefthoof
    constant integer OGRE_OGRE_DRUMMER                               = 'n0GL' // knight
    constant integer OGRE_OGRE_FIRE_BREATHER                         = 'n0HV' // knight 2
    constant integer OGRE_OGRE_MAGI                                  = 'n0HN' // sorceress
    constant integer OGRE_OGRE_WARLOCK                               = 'n0HO' // priest
    constant integer OGRE_OGRE_NECROMANCER                           = 'n0HW' // spell breaker
    constant integer OGRE_OGRE_LORD                                  = 'n0HM' // tauren
    constant integer OGRE_MOKNATHAL                                  = 'n07E' // tauren 2
    constant integer OGRE_GRONN                                      = 'n0I4' // tauren 3
    constant integer OGRE_GRONN_WAR_CLUB                             = 'n0I5' // tauren 3

    constant integer OGRE_KORGALL                                    = 'n071' // special unit
    constant integer OGRE_STONEMAUL_OGRE                             = 'n0C3' // special unit
    constant integer OGRE_STONEMAUL_MAGI                             = 'n08K' // special unit

    constant integer OGRE_CHILD                                      = 'n0IZ'
    constant integer OGRE_PET                                        = 'n0LQ'
    constant integer OGRE_CITIZEN_MALE                               = 'n0GF'
    constant integer OGRE_CITIZEN_FEMALE                             = 'n0GG'
    constant integer OGRE_HOUSING                                    = 'h0QC'

    constant integer OGRE_SHIPYARD                                   = 'o07C'

    // Eredar
    constant integer EREDAR_TIER_1                                   = 'n0IO'
    constant integer EREDAR_TIER_2                                   = 'n0JJ'
    constant integer EREDAR_TIER_3                                   = 'n0JK'
    constant integer EREDAR_BARRACKS                                 = 'h0U8' // barracks
    constant integer EREDAR_ARGUNITE_MILL                            = 'h0UK' // lumber mill
    constant integer EREDAR_FORGE                                    = 'h0U6' // forge
    constant integer EREDAR_MANARI_CRYSTAL                           = 'h0U7' // sanctuary
    constant integer EREDAR_SPIRE                                    = 'h0U5' // watch tower
    constant integer EREDAR_ALTAR                                    = 'h0UD'
    constant integer EREDAR_SHOP                                     = 'h0UC'
    constant integer EREDAR_WORKSHOP                                 = 'o08C'
    constant integer EREDAR_PYLON                                    = 'o08B' // farm
    constant integer EREDAR_EXODAR                                   = 'o08N' // special building

    constant integer UPG_EREDAR_BACKPACK                             = 'R0G3'
    constant integer UPG_EREDAR_DEFEND                               = 'R0G4'
    constant integer UPG_EREDAR_ARKONITE_DEFENSE                     = 'R0G7' // masonry
    constant integer UPG_EREDAR_SORCERESS                            = 'R00E'
    constant integer UPG_EREDAR_EXODAR                               = 'R0G5'

    constant integer EREDAR_ARTIFICER                                = 'n0IN' // worker
    constant integer EREDAR_PEACEKEEPER                              = 'h0U9' // footman
    constant integer EREDAR_RANGARI                                  = 'n0JE' // rifleman
    constant integer EREDAR_OUTRIDER                                 = 'h0UA' // knight
    constant integer EREDAR_ELEKK_KNIGHT                             = 'h0UB' // kodo beast
    constant integer EREDAR_NETHER_RAY                               = 'n0JH' // gryphon rider
    constant integer EREDAR_SUCCUBUS                                 = 'n0JD' // sorceress
    constant integer EREDAR_SORCERER                                 = 'n0JC' // priest
    constant integer EREDAR_VIGILANT                                 = 'n0JG' // tauren
    constant integer EREDAR_SIEGEBREAKER                             = 'n0JF' // catapult

    constant integer EREDAR_PET                                      = 'n0JN'
    constant integer EREDAR_CITIZEN_MALE                             = 'n0JO'
    constant integer EREDAR_CITIZEN_FEMALE                           = 'n0JP'
    constant integer EREDAR_HOUSING                                  = 'h0UE'

    // Fel Orc
    constant integer FEL_ORC_TIER_1                                  = 'o08R'
    constant integer FEL_ORC_TIER_2                                  = 'o09A'
    constant integer FEL_ORC_TIER_3                                  = 'o09F'
    constant integer FEL_ORC_ALTAR                                   = 'o09D'
    constant integer FEL_ORC_BARRACKS                                = 'o097'
    constant integer FEL_ORC_BEASTIARY                               = 'o09C'
    constant integer FEL_ORC_SHOP                                    = 'o09B'
    constant integer FEL_ORC_WAR_MILL                                = 'o099'
    constant integer FEL_ORC_WARLOCK_TEMPLE                          = 'o096'
    constant integer FEL_ORC_WATCH_TOWER                             = 'o09E'
    constant integer FEL_ORC_DEMON_GATE                              = 'n0KO'
    constant integer FEL_ORC_RED_DRAGON_ROOST                        = 'n0KP'
    constant integer FEL_ORC_PIG_FARM                                = 'n0K3' // farm
    constant integer FEL_ORC_HELLFIRE_CITADEL                        = 'o09G' // special building
    constant integer FEL_ORC_SHIPYARD                                = 'o09X'

    constant integer UPG_FEL_ORC_BACKPACK                            = 'R0GG'
    constant integer UPG_FEL_ORC_BURNING_OIL                         = 'R0H1'
    constant integer UPG_FEL_ORC_DEMON_POWER                         = 'R0H4'
    constant integer UPG_FEL_ORC_ELDER                               = 'R0GT' // Shaman
    constant integer UPG_FEL_ORC_WARLOCK                             = 'R0GU' // Witch Doctor
    constant integer UPG_FEL_ORC_CULTIST                             = 'R0GR' // Spirit Walker
    constant integer UPG_FEL_ORC_ENSNARE                             = 'R0GZ'
    constant integer UPG_FEL_ORC_FEL                                 = 'R0GS'
    constant integer UPG_FEL_ORC_HELLFIRE_CITADEL                    = 'R0GV'
    constant integer UPG_FEL_ORC_IMPROVED_CROSSBOWS                  = 'R0H3'
    constant integer UPG_FEL_ORC_MARKSMANSHIP                        = 'R0H2'
    constant integer UPG_FEL_ORC_ARMOR                               = 'R0GW'
    constant integer UPG_FEL_ORC_MELEE                               = 'R0GX'
    constant integer UPG_FEL_ORC_RANGED                              = 'R0GY'
    constant integer UPG_FEL_ORC_WAR_DRUMS                           = 'R0H0'
    constant integer UPG_FEL_ORC_PIGGERY                             = 'R0H5'

    constant integer FEL_ORC_PEON                                    = 'n0JZ' // worker
    constant integer FEL_ORC_GRUNT                                   = 'n0KN' // footman
    constant integer FEL_ORC_CROSSBOWMAN                             = 'o08T' // rifleman
    constant integer FEL_ORC_ELDER                                   = 'n0K2' // Shaman
    constant integer FEL_ORC_WARLOCK                                 = 'o0K1' // Witch Doctor
    constant integer FEL_ORC_CULTIST                                 = 'n0K0' // Spirit Walker
    constant integer FEL_ORC_KODO_BEAST                              = 'n0KQ'
    constant integer FEL_ORC_RAIDER                                  = 'n0KR'
    constant integer FEL_ORC_RED_DRAGON                              = 'n0KU'
    constant integer FEL_ORC_LANCER                                  = 'o08S'
    constant integer FEL_ORC_WAR_MACHINE                             = 'o098'

    constant integer FEL_ORC_PET                                     = 'n00T'
    constant integer FEL_ORC_CHILD                                   = 'n0LN'
    constant integer FEL_ORC_CITIZEN_MALE                            = 'n0KS'
    constant integer FEL_ORC_CITIZEN_FEMALE                          = 'n0KT'
    constant integer FEL_ORC_HOUSING                                 = 'h0US'

    // Faceless One
    constant integer FACELESS_ONE_TIER_1                             = 'o08V'
    constant integer FACELESS_ONE_TIER_2                             = 'o092'
    constant integer FACELESS_ONE_TIER_3                             = 'o093'
    constant integer FACELESS_ONE_ALTAR                              = 'n0KD'
    constant integer FACELESS_ONE_LIBRARY                            = 'o08Z' // arcane sanctuary
    constant integer FACELESS_ONE_CAVERN                             = 'o08W' // aviary
    constant integer FACELESS_ONE_POOL                               = 'o08X' // workshop
    constant integer FACELESS_ONE_PRISON                             = 'o094' // blacksmith/lumber mill
    constant integer FACELESS_ONE_COLONY                             = 'n0K9' // barracks
    constant integer FACELESS_ONE_TENTACLE                           = 'n0K8' // farm
    constant integer FACELESS_ONE_TENTACLE_PIT                       = 'n0K6' // watch tower
    constant integer FACELESS_ONE_SHOP                               = 'o08Y' // shop
    constant integer FACELESS_ONE_FORGOTTEN_ONE                      = 'n0K7' // special building

    constant integer UPG_FACELESS_ONE_BACKPACK                       = 'R0GH'
    constant integer UPG_FACELESS_ONE_DAMAGE                         = 'R0GL'
    constant integer UPG_FACELESS_ONE_ARMOR                          = 'R0GM'
    constant integer UPG_FACELESS_ONE_CULTIST                        = 'R0GN'
    constant integer UPG_FACELESS_ONE_FORGOTTEN_ONE                  = 'R0GI'
    constant integer UPG_FACELESS_ONE_TENTACLE                       = 'R0GJ'
    constant integer UPG_FACELESS_ONE_WITCH                          = 'R0GO'

    constant integer FACELESS_ONE_WORKER                             = 'o08U'
    constant integer FACELESS_ONE_AQIR                               = 'n0KC'
    constant integer FACELESS_ONE_BERSERKER                          = 'n0KE'
    constant integer FACELESS_ONE_RIDER                              = 'h0UO'
    constant integer FACELESS_ONE_KING                               = 'n0KI'
    constant integer FACELESS_ONE_TRICKSTER                          = 'n0KH'
    constant integer FACELESS_ONE_UNBROCKEN_DARKHUNTER               = 'n0KA'
    constant integer FACELESS_ONE_BONE_THROWER                       = 'o090'
    constant integer FACELESS_ONE_WITCH                              = 'u033'
    constant integer FACELESS_ONE_CULTIST                            = 'u034'
    constant integer FACELESS_ONE_BALLISTA                           = 'o091'
    constant integer FACELESS_ONE_NIGHTMARE_WEAVER                   = 'o095'

    constant integer FACELESS_ONE_PET                                = 'n0EC'
    constant integer FACELESS_ONE_CHILD                              = 'n0KF'
    constant integer FACELESS_ONE_CITIZEN_FEMALE                     = 'n0KG'
    constant integer FACELESS_ONE_CITIZEN_MALE                       = 'n0KB'
    constant integer FACELESS_ONE_HOUSING                            = 'h0UP'

    // Satyr
    constant integer SATYR_TIER_1                                    = 'n0GX'
    constant integer SATYR_TIER_2                                    = 'n0GY'
    constant integer SATYR_TIER_3                                    = 'n0GZ'
    constant integer SATYR_ALTAR                                     = 'e025'
    constant integer SATYR_MOON_WELL                                 = 'n0H1' // farm
    constant integer SATYR_ANCIENT_OF_LORE                           = 'e021'
    constant integer SATYR_ANCIENT_OF_WIND                           = 'e022'
    constant integer SATYR_HUNTERS_HALL                              = 'e01Z' // forge
    constant integer SATYR_ANCIENT_OF_WONDERS                        = 'e024' // shop
    constant integer SATYR_ANCIENT_OF_WAR                            = 'n0GV' // barracks
    constant integer SATYR_ANCIENT_PROTECTOR                         = 'n0GW' // tower
    constant integer SATYR_DEMON_GATE                                = 'n0H9' // aviary
    constant integer SATYR_MINE                                      = 'e020'

    constant integer UPG_SATYR_BACKPACK                              = 'R0DX'
    constant integer UPG_SATYR_STR_MOON                              = 'R0GB'
    constant integer UPG_SATYR_MOON_ARMOR                            = 'R0GA'
    constant integer UPG_SATYR_SLUDGE_FLINGER                        = 'R0GC'
    constant integer UPG_SATYR_CORRUPTED_ANCIENT_PROTECTORS          = 'R0IJ'

    constant integer SATYR_WORKER                                    = 'e01Y'
    constant integer SATYR_SATYR                                     = 'n0L6' // footman
    constant integer SATYR_TRICKSTER                                 = 'n0L5' // archer
    constant integer SATYR_GIANT_SKELETON_WARRIOR                    = 'n0L7' // knight
    constant integer SATYR_GREEN_DRAKE                               = 'n0HE'
    constant integer SATYR_CORRUPTED_TREANT                          = 'n0H8'
    constant integer SATYR_GHOST                                     = 'n0HB'
    constant integer SATYR_SATYR_SHADOWDANCER                        = 'n0HD'
    constant integer SATYR_SATYR_HELLCALLER                          = 'n0HL'
    constant integer SATYR_SLUDGE_FLINGER                            = 'n0HC'

    constant integer SATYR_PET                                       = 'n0N6'
    constant integer SATYR_CITIZEN_MALE                              = 'n0KX'
    constant integer SATYR_CITIZEN_FEMALE                            = 'n0KY'
    constant integer SATYR_CHILD                                     = 'n0N5'
    constant integer SATYR_HOUSING                                   = 'e02A'

    // Centaur
    constant integer CENTAUR_TIER_1                                  = 'o06V'
    constant integer CENTAUR_TIER_2                                  = 'o0AI'
    constant integer CENTAUR_TIER_3                                  = 'o0AJ'
    constant integer CENTAUR_TENT                                    = 'o06W' // farm
    constant integer CENTAUR_ALTAR                                   = 'o0AG'
    constant integer CENTAUR_BARRACKS                                = 'o0A8'
    constant integer CENTAUR_MILL                                    = 'o0AF'
    constant integer CENTAUR_SHOP                                    = 'o0AD'
    constant integer CENTAUR_LODGE                                   = 'o0A9'
    constant integer CENTAUR_ROOST                                   = 'o0AA'
    constant integer CENTAUR_KHAN_TENT                               = 'o0AC'
    constant integer CENTAUR_TOWER                                   = 'o0AE'
    constant integer CENTAUR_SPECIAL_BUILDING                        = 'n0MJ'

    constant integer UPG_CENTAUR_BACKPACK                            = 'R0I4'
    constant integer UPG_CENTAUR_DIVINER                             = 'R0I7'
    constant integer UPG_CENTAUR_HORSE_SHOES                         = 'R0I6'
    constant integer UPG_CENTAUR_REINCARNATION                       = 'R0I5'
    constant integer UPG_CENTAUR_SPECIAL_BUILDING                    = 'R0I9'
    constant integer UPG_CENTAUR_SORCERER                            = 'R0I8'
    constant integer UPG_CENTAUR_SEARING_ARROWS                      = 'R0IA'
    constant integer UPG_CENTAUR_MELEE                               = 'R0IC'
    constant integer UPG_CENTAUR_RANGED                              = 'R0ID'
    constant integer UPG_CENTAUR_ARMOR                               = 'R0IB'
    constant integer UPG_CENTAUR_RIDE_DOWN                           = 'R0IE'
    constant integer UPG_CENTAUR_TRUE_SIGHT                          = 'R0IG'
    constant integer UPG_CENTAUR_SLEEP                               = 'R0IF'

    constant integer CENTAUR_WORKER                                  = 'n0HF'
    constant integer CENTAUR_DRUDGE                                  = 'n0MA' // footman
    constant integer CENTAUR_ARCHER                                  = 'n0MB' // rifleman
    constant integer CENTAUR_OUTRUNNER                               = 'n0MC' // knight
    constant integer CENTAUR_DIVINER                                 = 'n0MH' // priest
    constant integer CENTAUR_SORCERER                                = 'n0MG' // sorcerer
    constant integer CENTAUR_EAGLE                                   = 'o0AB' // wyvern rider
    constant integer CENTAUR_HARPY                                   = 'n0MK' // bat rider
    constant integer CENTAUR_KHAN                                    = 'n0MI' // tauren

    constant integer CENTAUR_PET                                     = 'n0C7'
    constant integer CENTAUR_CITIZEN_MALE                            = 'n0MD'
    constant integer CENTAUR_CITIZEN_FEMALE                          = 'n0ME'
    constant integer CENTAUR_CHILD                                   = 'n0MF'
    constant integer CENTAUR_HOUSING                                 = 'h0Y2'

    // Gnoll
    constant integer GNOLL_TIER_1                                    = 'o06X'
    constant integer GNOLL_TIER_2                                    = 'o0BE'
    constant integer GNOLL_TIER_3                                    = 'o0BF'
    constant integer GNOLL_HUT                                       = 'o0B9' // farm
    constant integer GNOLL_KENNEL                                    = 'o0BC' // barracks
    constant integer GNOLL_ALTAR                                     = 'o0BB' // altar
    constant integer GNOLL_LUMBERYARD                                = 'o0BA' // mill
    constant integer GNOLL_ELEMENTAL_GROVE                           = 'o0BD' // arcane sanctum
    constant integer GNOLL_SAVAGE_TOWER                              = 'o0BG' // watch tower
    constant integer GNOLL_SHOP                                      = 'o0BH' // shop
    constant integer GNOLL_FORGE                                     = 'o0BI' // blacksmith
    constant integer GNOLL_BATTLE_ARENA                              = 'o030' // aviary

    constant integer UPG_GNOLL_BACKPACK                              = 'R0IX'
    constant integer UPG_GNOLL_ENVENOMED_WEAPONS                     = 'R01A'
    constant integer UPG_GNOLL_ENSLAVEMENT                           = 'R028'
    constant integer UPG_GNOLL_BARREL_FORM                           = 'R05B'

    constant integer GNOLL_WORKER                                    = 'o06Y'
    constant integer GNOLL_BRUTE                                     = 'n033' // footman
    constant integer GNOLL_ASSASSIN                                  = 'n034' // rifleman
    constant integer GNOLL_OVERSEER                                  = 'n035' // knight
    constant integer GNOLL_TREASURE_HUNTER                           = 'o020' // sorceress
    constant integer GNOLL_MYSTWEAVER                                = 'o027' // priest
    constant integer GNOLL_WARHAWK                                   = 'o028' // gryphon rider
    constant integer GNOLL_WARLORD                                   = 'n03N' // tauren
    constant integer GNOLL_ROCKBREAKER                               = 'n07F' // siege engine

    constant integer GNOLL_PET                                       = 'n0C7'
    constant integer GNOLL_CITIZEN_MALE                              = 'n0NV'
    constant integer GNOLL_CITIZEN_FEMALE                            = 'n0NW'
    constant integer GNOLL_CHILD                                     = 'n0NX'
    constant integer GNOLL_HOUSING                                   = 'h0FQ'

    // Kobold
    constant integer KOBOLD_TIER_1                                   = 'o070'
    constant integer KOBOLD_TIER_2                                   = 'o09Y'
    constant integer KOBOLD_TIER_3                                   = 'o09Z'
    constant integer KOBOLD_CAVERN                                   = 'o0A5' // farm
    constant integer KOBOLD_ALTAR                                    = 'o0A0'
    constant integer KOBOLD_BARRACKS                                 = 'o09S'
    constant integer KOBOLD_MILL                                     = 'o0A2'
    constant integer KOBOLD_SHOP                                     = 'o09S'
    constant integer KOBOLD_LODGE                                    = 'o0A4'
    constant integer KOBOLD_TUNNEL                                   = 'u03F'
    constant integer KOBOLD_BEASTIARY                                = 'o0B5'
    constant integer KOBOLD_SHIPYARD                                 = 'o0B6'
    constant integer KOBOLD_BOULDER_TOWER                            = 'o0B7'
    constant integer KOBOLD_ADVANCED_BOULDER_TOWER                   = 'o0B8'
    constant integer KOBOLD_MINES                                    = 'n09N' // special building

    constant integer UPG_KOBOLD_BACKPACK                             = 'R0DX'
    constant integer UPG_KOBOLD_BURROW                               = 'R0GA'
    constant integer UPG_KOBOLD_CANDLES                              = 'R0GA'
    constant integer UPG_KOBOLD_MELEE                                = 'R0GA'
    constant integer UPG_KOBOLD_ARMOR                                = 'R0GA'
    constant integer UPG_KOBOLD_GEOMANCER                            = 'R0GA'
    constant integer UPG_KOBOLD_MINING                               = 'R0IU'
    constant integer UPG_KOBOLD_GOLD_COINS                           = 'R0IV'
    constant integer UPG_KOBOLD_MINES                                = 'R0IW'

    constant integer KOBOLD_WORKER                                   = 'o06Z'
    constant integer KOBOLD_WARRIOR                                  = 'n0LI' // footman
    constant integer KOBOLD_HUNTER                                   = 'n0AD' // rifleman
    constant integer KOBOLD_TUNNELER                                 = 'n0LJ' // knight
    constant integer KOBOLD_TUNNELER_BURROWED                        = 'n0LK'
    constant integer KOBOLD_GEOMANCER                                = 'n09B' // priest
    constant integer KOBOLD_MUSHROOM_CASTER                          = 'n0AJ' // sorcress

    constant integer KOBOLD_CITIZEN_MALE                             = 'n09C'
    constant integer KOBOLD_CITIZEN_FEMALE                           = 'n0A3'
    constant integer KOBOLD_CHILD                                    = 'n0MP'
    constant integer KOBOLD_PET                                      = 'n0A9'
    constant integer KOBOLD_HOUSING                                  = 'h0X4'

    // Quillboar
    constant integer QUILLBOAR_TIER_1                                = 'o071'
    constant integer QUILLBOAR_TIER_2                                = 'o0B0'
    constant integer QUILLBOAR_TIER_3                                = 'o0B1'
    constant integer QUILLBOAR_TRAINING_CAMP                         = 'o0AQ' // barracks
    constant integer QUILLBOAR_HUT                                   = 'o0AS' // farm
    constant integer QUILLBOAR_FORGE                                 = 'o0AT' // war mill
    constant integer QUILLBOAR_ALTAR                                 = 'o0AU' // altar
    constant integer QUILLBOAR_HOUSE_OF_ANCESTRY                     = 'o0AV' // arcane sanctum
    constant integer QUILLBOAR_SHOP                                  = 'o0AW' // shop
    constant integer QUILLBOAR_THORNY_SPIRE                          = 'o0AX' // watch tower
    constant integer QUILLBOAR_ANIMAL_BATTLE_GROUNDS                 = 'o0B2'
    constant integer QUILLBOAR_SACRIFICIAL_GROUNDS                   = 'o0B3'

    constant integer UPG_QUILLBOAR_BACKPACK                          = 'R0IK'
    constant integer UPG_QUILLBOAR_MEDICINE_MAN                      = 'R0IL'
    constant integer UPG_QUILLBOAR_MYSTIC                            = 'R0IP'
    constant integer UPG_QUILLBOAR_NECROMANCER                       = 'R0IQ'
    constant integer UPG_QUILLBOAR_QUIL_SPRAY                        = 'R0IM'
    constant integer UPG_QUILLBOAR_QUILLS                            = 'R0IN'
    constant integer UPG_QUILLBOAR_THORNS_AURA                       = 'R0IO'
    constant integer UPG_QUILLBOAR_MELEE                             = 'R0IS'
    constant integer UPG_QUILLBOAR_RANGED                            = 'R0IT'
    constant integer UPG_QUILLBOAR_ARMOR                             = 'R0IR'

    constant integer QUILLBOAR_WORKER                                = 'o072'
    constant integer QUILLBOAR_QUILLBOAR                             = 'n0NM' // footman
    constant integer QUILLBOAR_HUNTER                                = 'n0NQ' // rifleman
    constant integer QUILLBOAR_RAIDER                                = 'o0AR' // knight
    constant integer QUILLBOAR_MEDICINE_MAN                          = 'o0AZ' // priest
    constant integer QUILLBOAR_MYSTIC                                = 'o0AY' // sorceress
    constant integer QUILLBOAR_NECROMANCER                           = 'o0B4' // necromancer
    constant integer QUILLBOAR_QUILBEAST                             = 'n0NR' // siege engine
    constant integer QUILLBOAR_CHIEFTAIN                             = 'n0NS' // tauren
    constant integer QUILLBOAR_HARPY_ROGUE                           = 'n0NT' // gryphon
    constant integer QUILLBOAR_HARPY_WINDWITCH                       = 'n0NU' // dragon hawk

    constant integer QUILLBOAR_CITIZEN_MALE                          = 'n0NN'
    constant integer QUILLBOAR_CITIZEN_FEMALE                        = 'n0NO'
    constant integer QUILLBOAR_CHILD                                 = 'n0NP'
    constant integer QUILLBOAR_PET                                   = 'n00U'
    constant integer QUILLBOAR_HOUSING                               = 'h0YN'

    constant integer QUILLBOAR_SKELETAL_RAZORMANE                    = 'u03K'

    // Bandit
    constant integer BANDIT_TIER_1                                   = 'h05X'
    constant integer ITEM_TINY_BANDIT_TIER_1                         = 'I08C'
    constant integer BANDIT_TIER_2                                   = 'h05Y'
    constant integer ITEM_TINY_BANDIT_TIER_2                         = 'I08I'
    constant integer BANDIT_TIER_3                                   = 'h05Z'
    constant integer ITEM_TINY_BANDIT_TIER_3                         = 'I08J'
    constant integer BANDIT_BARRACKS                                 = 'h060'
    constant integer ITEM_TINY_BANDIT_BARRACKS                       = 'I08K'
    constant integer BANDIT_CHURCH                                   = 'h072'
    constant integer ITEM_TINY_BANDIT_CHURCH                         = 'I08L'
    constant integer BANDIT_MILL                                     = 'h075'
    constant integer ITEM_TINY_BANDIT_MILL                           = 'I08M'
    constant integer BANDIT_BLACKSMITH                               = 'h07I'
    constant integer ITEM_TINY_BANDIT_BLACKSMITH                     = 'I08N'
    constant integer BANDIT_MARKET                                   = 'h076' // shop
    constant integer ITEM_TINY_BANDIT_MARKET                         = 'I08P'
    constant integer BANDIT_PRISON                                   = 'h079' // workshop
    constant integer ITEM_TINY_BANDIT_PRISON                         = 'I08Q'
    constant integer BANDIT_TENT                                     = 'h07A' // farm
    constant integer ITEM_TINY_BANDIT_TENT                           = 'I0AO'
    constant integer BANDIT_AVIARY                                   = 'h07D' // aviary
    constant integer ITEM_TINY_BANDIT_AVIARY                         = 'I0AQ'
    constant integer BANDIT_ALTAR                                    = 'h07E' // altar
    constant integer ITEM_TINY_BANDIT_ALTAR                          = 'I0AR'
    constant integer BANDIT_WATCH_TOWER                              = 'h07F' // guard tower
    constant integer ITEM_TINY_BANDIT_WATCH_TOWER                    = 'I0BB'
    constant integer BANDIT_THIEVES_GUILD                            = 'h07J' // special building
    constant integer ITEM_TINY_BANDIT_THIEVES_GUILD                  = 'I0DD'
    constant integer BANDIT_SHIPYARD                                 = 'h07O'
    constant integer ITEM_TINY_BANDIT_SHIPYARD                       = 'I0E0'

    constant integer UPG_BANDIT_BACKPACK                             = 'R05C'
    constant integer UPG_BANDIT_ENSNARE                              = 'R05D'
    constant integer UPG_BANDIT_SHADOW_MELD                          = 'R05E'
    constant integer UPG_BANDIT_ROB                                  = 'R05F'
    constant integer UPG_BANDIT_ENVENOMED_WEAPONS                    = 'R05G'
    constant integer UPG_BANDIT_ENSLAVEMENT                          = 'R06K'
    constant integer UPG_BANDIT_WIZARD                               = 'R073'
    constant integer UPG_BANDIT_HERETIC                              = 'R074'
    constant integer UPG_BANDIT_SLAVE_MASTER                         = 'R07G'
    constant integer UPG_BANDIT_ARMOR                                = 'R075'
    constant integer UPG_BANDIT_MELEE                                = 'R076'
    constant integer UPG_BANDIT_RANGED                               = 'R077'
    constant integer UPG_BANDIT_WOOD                                 = 'R079'
    constant integer UPG_BANDIT_FEATHER_ATTACK                       = 'R07A'
    constant integer UPG_BANDIT_TRUE_SIGHT                           = 'R07B'
    constant integer UPG_BANDIT_STORM_HAMMERS                        = 'R07D'
    constant integer UPG_BANDIT_RIDE_DOWN                            = 'R07E'
    constant integer UPG_BANDIT_RESISTANT_SKIN                       = 'R07F' // tier 2
    constant integer UPG_BANDIT_THIEVES_GUILD                        = 'R078'

    constant integer BANDIT_WORKER                                   = 'h05V'
    constant integer BANDIT_BANDIT                                   = 'n07M' // footman
    constant integer BANDIT_BRIGAND                                  = 'n07L' // rifleman
    constant integer BANDIT_BANDIT_LORD                              = 'n07K' // knight
    constant integer BANDIT_WIZARD                                   = 'h077' // sorceress
    constant integer BANDIT_HERETIC                                  = 'h07K' // priest
    constant integer BANDIT_SLAVE_MASTER                             = 'h07P' // spellbreaker
    constant integer BANDIT_CARGE_CART                               = 'h078' // siege engine
    constant integer BANDIT_GRYPHON_RAIDER                           = 'h07M' // gryphon
    constant integer BANDIT_CROW                                     = 'n092' // dragonhawk
    constant integer BANDIT_FLYING_SPEAR_THROWER                     = 'h07Q'
    constant integer BANDIT_AMBAL                                    = 'n093' // mortar
    constant integer BANDIT_CROSSBOWMAN                              = 'n094' // flying machine
    constant integer SLAVE                                           = 'h05T' // Gnoll/Bandit/Enslavement
    constant integer BANDIT_DOG                                      = 'o033'

    constant integer BANDIT_CITIZEN_MALE                             = 'n08X'
    constant integer BANDIT_CITIZEN_FEMALE                           = 'n08C'
    constant integer BANDIT_CHILD                                    = 'n091'
    constant integer BANDIT_PET                                      = 'n0C7'
    constant integer BANDIT_HOUSING                                  = 'h07L'
    constant integer ITEM_TINY_BANDIT_HOUSING                        = 'I0DE'

    // Dungeon
    constant integer DUNGEON_TIER_1                                  = 'o03M'
    constant integer DUNGEON_TIER_2                                  = 'o03R'
    constant integer DUNGEON_TIER_3                                  = 'o03S'
    constant integer DUNGEON_CAGE                                    = 'o03N' // farm
    constant integer DUNGEON_BARRACKS                                = 'o03O' // barracks
    constant integer DUNGEON_BRAZIER                                 = 'o03P' // arcane sanctum
    constant integer DUNGEON_TORTURE_CHAMBER                         = 'o03V' // mill/blacksmith
    constant integer DUNGEON_PRISON                                  = 'o03Q' // workshop
    constant integer DUNGEON_ALTAR                                   = 'o03U' // altar
    constant integer DUNGEON_SHOP                                    = 'o03T' // shop
    constant integer DUNGEON_DRAGON_ROOST                            = 'o03W' // aviary
    constant integer DUNGEON_SPIKES                                  = 'o03X' // watch tower
    constant integer DUNGEON_SHIPYARD                                = 'u01O'
    constant integer DUNGEON_THRONE                                  = 'o03Y' // special building

    constant integer ITEM_DUNGEON_CAGE                               = 'I0K1'
    constant integer ITEM_DUNGEON_TIER_2                             = 'I0K4'
    constant integer ITEM_DUNGEON_TIER_3                             = 'I0K3'
    constant integer ITEM_DUNGEON_BARRACKS                           = 'I0K5'
    constant integer ITEM_DUNGEON_MILL                               = 'I0K9'
    constant integer ITEM_DUNGEON_ALTAR                              = 'I0KO'
    constant integer ITEM_DUNGEON_SHOP                               = 'I0KP'
    constant integer ITEM_DUNGEON_SPIKES                             = 'I0KY'
    constant integer ITEM_DUNGEON_BRAZIER                            = 'I0TY'
    constant integer ITEM_DUNGEON_PRISON                             = 'I0N2'
    constant integer ITEM_DUNGEON_DRAGON_ROOST                       = 'I0N3'
    constant integer ITEM_DUNGEON_HOUSING                            = 'I0N9'
    constant integer ITEM_DUNGEON_THRONE                             = 'I0NA'
    constant integer ITEM_DUNGEON_SHIPYARD                           = 'I0TX'

    constant integer UPG_DUNGEON_BACKPACK                            = 'R07H'
    constant integer UPG_DUNGEON_MELEE                               = 'R07W'
    constant integer UPG_DUNGEON_ARMOR                               = 'R07X'
    constant integer UPG_DUNGEON_RANGED                              = 'R07Y'
    constant integer UPG_DUNGEON_EAT_TREE                            = 'R07I'
    constant integer UPG_DUNGEON_BURNING_ARROWS                      = 'R07J'
    constant integer UPG_DUNGEON_GHOST                               = 'R07L'
    constant integer UPG_DUNGEON_FIRE_REVENANT                       = 'R07M'
    constant integer UPG_DUNGEON_HERETIC                             = 'R07N'
    constant integer UPG_DUNGEON_SKELETON_BONES                      = 'R07O'
    constant integer UPG_DUNGEON_CREATE_CORPSE                       = 'R07P'
    constant integer UPG_DUNGEON_CAPTURE                             = 'R07Q'
    constant integer UPG_DUNGEON_DEVOUR                              = 'R07R'
    constant integer UPG_DUNGEON_BERSERK                             = 'R07S'
    constant integer UPG_DUNGEON_SLEEP_FORM                          = 'R07T'
    constant integer UPG_DUNGEON_WAR_STOMP                           = 'R07U'
    constant integer UPG_DUNGEON_SPIKES                              = 'R07V'
    constant integer UPG_DUNGEON_RESISTANT_SKIN                      = 'R07Z'
    constant integer UPG_DUNGEON_THRONE                              = 'R07K' // special building

    constant integer DUNGEON_WORKER                                  = 'o03L'
    constant integer DUNGEON_SKELETON_WARRIOR                        = 'n09K' // footman
    constant integer DUNGEON_SKELETON_ARCHER                         = 'n09M' // archer
    constant integer DUNGEON_SKELETON_BERSERKER                      = 'n09U' // knight
    constant integer DUNGEON_GHOST                                   = 'n09R' // sorceress
    constant integer DUNGEON_FIRE_REVENANT                           = 'n09T' // priest
    constant integer DUNGEON_HERETIC                                 = 'h07Z' // spell breaker
    constant integer DUNGEON_SALAMANDER                              = 'n09Y' // siege engine
    constant integer DUNGEON_SLUDGE                                  = 'n0A0' // mortar
    constant integer DUNGEON_WAR_GOLEM                               = 'n0A1' // flying machine
    constant integer DUNGEON_WAR_GOLEM_M                             = 'n05C'
    constant integer DUNGEON_WILDKIN                                 = 'n0AC' // dragon hawk
    constant integer DUNGEON_LORD                                    = 'n0A5' // tauren special unit limited to 4
    constant integer DUNGEON_RED_DRAGON                              = 'n0A6' // gryphon
    constant integer DUNGEON_PRISONER                                = 'n0AK'
    constant integer DUNGEON_PRISONER_CORPSE                         = 'n0AO'

    constant integer DUNGEON_CITIZEN_MALE                            = 'n0A4'
    constant integer DUNGEON_CITIZEN_FEMALE                          = 'n0A7'
    constant integer DUNGEON_CHILD                                   = 'n0A8'
    constant integer DUNGEON_PET                                     = 'n0A9' // rat
    constant integer DUNGEON_HOUSING                                 = 'h07X'

    // Dragonkin
    constant integer DRAGONKIN_TIER_1                                = 'o08P'
    constant integer DRAGONKIN_TIER_2                                = 'o041'
    constant integer DRAGONKIN_TIER_3                                = 'o044'
    constant integer DRAGONKIN_ALTAR                                 = 'o08Q'
    constant integer DRAGONKIN_BARRACKS                              = 'o0AO'
    constant integer DRAGONKIN_NEST                                  = 'o046' // farm
    constant integer DRAGONKIN_QUARRY                                = 'o047' // mill
    constant integer DRAGONKIN_FORGE                                 = 'o04C' // blacksmith
    constant integer DRAGONKIN_ARCANE_TEMPLE                         = 'o048' // arcane sanctuary
    constant integer DRAGONKIN_ARENA                                 = 'o049' // workshop
    constant integer DRAGONKIN_ROOST                                 = 'o04A' // aviary
    constant integer DRAGONKIN_TOWER                                 = 'o04B'
    constant integer DRAGONKIN_SHOP                                  = 'o045'
    constant integer DRAGONKIN_WYRMREST_TEMPLE                       = 'o0BV' // special building
    constant integer DRAGONKIN_SHIPYARD                              = 'o04E'

    constant integer UPG_DRAGONKIN_BACKPACK                          = 'R0GF'
    constant integer UPG_DRAGONKIN_SPELL_DAMAGE_REDUCTION            = 'R080'
    constant integer UPG_DRAGONKIN_RESISTANT_SKIN                    = 'R081'
    constant integer UPG_DRAGONKIN_FIRE_ATTACK                       = 'R082'
    constant integer UPG_DRAGONKIN_WYRMREST_TEMPLE                   = 'R084' // special building

    constant integer DRAGONKIN_WORKER                                = 'o08O'
    constant integer DRAGONKIN_FOOTMAN                               = 'n0NL'
    constant integer DRAGONKIN_RIFLEMAN                              = 'o0AP'
    constant integer DRAGONKIN_KNIGHT                                = 'n0BO'
    constant integer DRAGONKIN_BLACK_DRAGON                          = 'n0B0'
    constant integer DRAGONKIN_DRAGON_PRIEST                         = 'o04D'

    constant integer DRAGONKIN_CITIZEN_MALE                          = 'n0B1'
    constant integer DRAGONKIN_CITIZEN_FEMALE                        = 'n0B2'
    constant integer DRAGONKIN_CHILD                                 = 'n0B3'
    constant integer DRAGONKIN_PET                                   = 'n0B4'
    constant integer DRAGONKIN_HOUSING                               = 'h082'

    // Village
    constant integer VILLAGE_TIER_1                                  = 'h08F'
    constant integer VILLAGE_TIER_2                                  = 'h08U'
    constant integer VILLAGE_TIER_3                                  = 'h08V'
    constant integer VILLAGE_TAVERN                                  = 'h08J' // altar
    constant integer VILLAGE_OUTPOST                                 = 'h08K' // scout tower
    constant integer VILLAGE_BELL_TOWER                              = 'h08T' // guard tower
    constant integer VILLAGE_SHOP                                    = 'h08L'
    constant integer VILLAGE_INN                                     = 'h08M' // farm
    constant integer VILLAGE_STABLES                                 = 'h08N' // barracks
    constant integer VILLAGE_BARN                                    = 'h08O' // workshop
    constant integer VILLAGE_ANIMAL_PEN                              = 'h08P' // arcane sanctuary
    constant integer VILLAGE_WIND_MILL                               = 'h08Q' // aviary
    constant integer VILLAGE_GRANARY                                 = 'h08R' // lumber mill
    constant integer VILLAGE_FRUIT_STAND                             = 'h08S' // blacksmith
    constant integer VILLAGE_SHIPYARD                                = 'h0AL'

    constant integer VILLAGE_WORKER                                  = 'h08G'

    constant integer VILLAGE_HOUSING                                 = 'h08W'
    constant integer VILLAGE_PET                                     = 'n08F'

    // WoW Reforged abilities
    // Schools of Magic

    // Holy Magic
    constant integer ABILITY_HOLY_MAGIC                              = 'A115'
    constant integer ABILITY_HEAL                                    = 'Anhe'
    constant integer ABILITY_INNFER_FIRE                             = 'ACif'
    constant integer ABILITY_HOLY_LIGHT                              = 'A13W'
    constant integer ABILITY_DIVINE_SHIELD                           = 'A1NY'
    constant integer ABILITY_HEALING_WAVE                            = 'Leav'

    // Arcane Magic
    constant integer ABILITY_ARCANE_MAGIC                            = 'A11B'
    constant integer ABILITY_BANISH                                  = 'ACbn'
    constant integer ABILITY_SPELL_STEAL                             = 'Asps'
    constant integer ABILITY_SPELL_CONTROL_MAGIC                     = 'A11C'
    constant integer ABILITY_SPELL_FEEDBACK                          = 'Afbk'
    constant integer ABILITY_SPELL_BLINK                             = 'A005'
    constant integer ABILITY_SPELL_MANA_SHIELD                       = 'ACmf'
    constant integer ABILITY_SPELL_SIPHON_MANA                       = 'ACsm'
    constant integer ABILITY_SPELL_DISPEL_MAGIC                      = 'Adsm'
    constant integer ABILITY_SPELL_BRILLIANCE_AURA                   = 'ACba'
    constant integer ABILITY_SPELL_MASS_TELEPORT                     = 'A11F'
    constant integer ABILITY_SPELL_POLYMORPH                         = 'ACpy'

    // Dark Magic
    constant integer ABILITY_DARK_MAGIC                              = 'A16N'
    constant integer ABILITY_CURSE                                   = 'ACcs'
    constant integer ABILITY_RAISE_DEAD                              = 'ACrd'
    constant integer ABILITY_UNHOLY_FRENZY                           = 'ACuf'
    constant integer ABILITY_BLACK_ARROW                             = 'ACbk'
    constant integer ABILITY_DEATH_COIL                              = 'ACdc'

    // Fire Magic
    constant integer ABILITY_FIRE_MAGIC                              = 'A1O5'
    constant integer ABILITY_FIREBOLT                                = 'ACfb'
    constant integer ABILITY_IMMOLATION                              = 'ACim'
    constant integer ABILITY_RAIN_OF_FIRE                            = 'ACrg'
    constant integer ABILITY_FLAME_STRIKE                            = 'ACfs'
    constant integer ABILITY_VOLCANO                                 = 'A112'

    // Water Magic
    constant integer ABILITY_WATER_MAGIC                             = 'A16Q'
    constant integer ABILITY_CRUSHING_WAVE                           = 'ACcv'
    constant integer ABILITY_CHAIN_LIGHTNING                         = 'ACcl'
    constant integer ABILITY_SUMMON_SEA_ELEMENTAL                    = 'ACwe'
    constant integer ABILITY_BLIZZARD                                = 'ACbz'

    // Earth Magic
    constant integer ABILITY_EARTH_MAGIC                             = 'A26D'
    constant integer ABILITY_STORM_BOLT                              = 'A26F'
    constant integer ABILITY_FAR_SIGHT                               = 'A26G'
    constant integer ABILITY_SUMMON_EARTH_ELEMENTAL                  = 'A26H'
    constant integer ABILITY_SUMMON_GOLEM                            = 'A26I'
    constant integer ABILITY_BLOODLUST                               = 'ACbl'
    constant integer ABILITY_EARTH_QUAKE                             = 'S00U'
    constant integer ABILITY_AVATAR                                  = 'A26J'
    constant integer ABILITY_REINCARNATION                           = 'ACrn'

    // WoW Reforged heroes
    constant integer DEATH_KNIGHT_SHADOW_WORD_DEATH                  = 'A01Q'

    // Human
    constant integer WIZARD                                          = 'H00W'
    constant integer DARK_KNIGHT                                     = 'H0BS'
    constant integer PEASANT_HERO                                    = 'H0KV'
    constant integer CAPTAIN                                         = 'H0VB'
    constant integer ARTHAS                                          = 'H0AI'
    constant integer ARTHAS_WIELDING_FROSTMOURNE                     = 'H0AJ'
    constant integer UTHER                                           = 'H0A5'
    constant integer KHADGAR                                         = 'H03M'
    constant integer MEDIVH                                          = 'H018'
    constant integer LORD_GARITHOS                                   = 'Hlgr'
    constant integer ANDUIN_WRYNN                                    = 'H0QW'
    constant integer ANDUIN_WRYNN_M                                  = 'H0RW'
    constant integer ANDUIN_LOTHAR                                   = 'H0QX'
    constant integer VARIAN_WRYNN                                    = 'H0RR'
    // Dwarf
    constant integer MORTAR_TEAM                                     = 'H0JK'
    constant integer DWARF_MAGE                                      = 'H03L'
    constant integer ELITE_RIFLEMAN                                  = 'H0JQ'
    constant integer ELITE_RIFLEMAN_M                                = 'H0JR'
    constant integer SIEGE_ENGINE                                    = 'H0QV'
    constant integer BARD                                            = 'H0YK'
    constant integer GRYPHON_RIDER                                   = 'H0S1'
    // Blood Elf
    constant integer SPELLBREAKER_HERO                               = 'H0K7'
    constant integer PHOENIX                                         = 'H0YC'
    constant integer ANASTERIAN_SUNSTRIDER                           = 'Hssa'
    constant integer KAEL_HERO                                       = 'H02C'
    // High Elf
    constant integer RANGER                                          = 'H03Y'
    constant integer SORCERESS_HERO                                  = 'H0B2'
    constant integer PRIEST_HERO                                     = 'H068'
    constant integer SYLVANAS_WINDRUNNER                             = 'Hvwd'
    constant integer SYLVANAS_WINDRUNNER_M                           = 'H04K'
    constant integer THALORIEN_DAWNSEEKER                            = 'Hddt'
    // Orc
    constant integer WARLOCK                                         = 'O02O'
    constant integer PEON_HERO                                       = 'H0OG'
    constant integer KODO_BEAST_HERO                                 = 'O08G'
    constant integer RAIDER_HERO                                     = 'O09O'
    constant integer SHAMAN_HERO                                     = 'O0AK'
    constant integer THRALL_HERO                                     = 'O02R'
    constant integer GROMMASH_HELLSCREAM                             = 'O02T'
    constant integer GROMMASH_HELLSCREAM_M                           = 'O02U'
    constant integer DREKTHAR                                        = 'O00D'
    constant integer BLACKHAND                                       = 'O01V'
    constant integer NERZHUL                                         = 'O01T'
    constant integer NERZHUL_M                                       = 'O01U'
    constant integer GULDAN                                          = 'Ogld'
    constant integer DUROTAN                                         = 'O07H'
    constant integer GARONA                                          = 'O06U'
    constant integer ORGRIM_DOOMHAMMER                               = 'O07I'
    constant integer SAMURO                                          = 'Osam'
    // Undead
    constant integer DARK_RANGER                                     = 'Nbrn'
    constant integer NECROMANCER_HERO                                = 'U013'
    constant integer ABOMINATION_HERO                                = 'U01G'
    constant integer BANSHEE_HERO                                    = 'U01F'
    constant integer ACOLYTE_HERO                                    = 'H0P2'
    constant integer ACOLYTE_HERO_M                                  = 'H0P3'
    constant integer OBSIDIAN_STATUE_HERO                            = 'U02U'
    constant integer OBSIDIAN_STATUE_HERO_M                          = 'U02V'
    constant integer ARTHAS_UNDEAD                                   = 'U01C'
    constant integer KELTHUZAD                                       = 'U01B'
    constant integer KELTHUZAD_LICH                                  = 'U00J'
    constant integer MALGANIS_HERO                                   = 'U01E'
    constant integer SYLVANAS_UNDEAD                                 = 'U00L'
    constant integer LICH_KING                                       = 'U00N'
    // Nerubian
    constant integer NERUBIAN_QUEEN_HERO                             = 'U027'
    constant integer NERUBIAN_QUEEN_HERO_BURROWED                    = 'U03H'
    constant integer ANUBARAK_HERO                                   = 'U01D'
    constant integer ANUBARAK_HERO_BURROWED                          = 'U03I'
    constant integer CRYPT_LORD_BURROWED                             = 'U03G'
    // Night Elf
    constant integer RANGER_NIGHT_ELF                                = 'H0YI'
    constant integer MOUNTAIN_GIANT_HERO                             = 'E00G'
    constant integer DRUID_OF_THE_CLAW                               = 'E00T'
    constant integer DRUID_OF_THE_CLAW_M                             = 'E00U'
    constant integer DRUID_OF_THE_TALON                              = 'E00W'
    constant integer DRUID_OF_THE_TALON_M                            = 'E00V'
    constant integer DRYAD_HERO                                      = 'E02C'
    constant integer WISP_HERO                                       = 'E01I'
    constant integer ANCIENT_OF_LORE_HERO                            = 'E02B'
    constant integer FURION                                          = 'E000'
    constant integer MALFURION                                       = 'Emns'
    constant integer ILLIDAN_HERO                                    = 'E010'
    constant integer ILLIDAN_HERO_M                                  = 'E00B'
    constant integer ILLIDAN_EVIL                                    = 'E00A'
    constant integer ILLIDAN_EVIL_M                                  = 'Eevm'
    constant integer TYRANDE_HERO                                    = 'E00Y'
    constant integer MAIEV_HERO                                      = 'E00X'
    constant integer SHANDRIS_FEATHER_MOON                           = 'H0YD'
    constant integer KEEPER_OF_THE_GROVE_GHOST                       = 'E00Z'
    constant integer CENARIUS_HERO                                   = 'E00H'
    constant integer ARCHDRUID                                       = 'E01K'
    constant integer DRUID_FORM_AQUATIC                              = 'E01L'
    constant integer DRUID_FORM_BEAR                                 = 'E01T'
    constant integer DRUID_FORM_CAT                                  = 'E01S'
    constant integer DRUID_FORM_CROW                                 = 'E01U'
    constant integer DRUID_FORM_FLIGHT                               = 'E01N'
    constant integer DRUID_FORM_SPIDER                               = 'E01P'
    constant integer DRUID_FORM_STAG                                 = 'E01Q'
    constant integer DRUID_FORM_TREE                                 = 'E01O'
    constant integer DRUID_FORM_WILDKIN                              = 'E01M'
    constant integer DRUID_FORM_WOLF                                 = 'E01R'
    constant integer PRIESTESS_OF_THE_MOON_OWL                       = 'E01J'
    constant integer MALORNE                                         = 'E028'
    constant integer CHIMAERA_HERO                                   = 'E02F'
    // Goblin
    constant integer ALCHEMIST                                       = 'Nalc'
    constant integer TINKER                                          = 'Ntin'
    constant integer TINKER_M                                        = 'Nrob'
    constant integer ROBO_GOBLIN                                     = 'ANrg'
    constant integer FLAME_SHREDDER                                  = 'N0BE'
    constant integer GOBLIN_SHREDDER_HERO                            = 'N07D'
    constant integer GOBLIN_GUNNER                                   = 'N06V'
    constant integer GOBLIN_PRINCE                                   = 'N09E'
    constant integer GOBLIN_PRINCE_M                                 = 'N09F'
    constant integer GOBLIN_HEAVY_TANK_HERO                          = 'N06N'
    constant integer GOBLIN_WAR_ZEPPELIN_HERO                        = 'N06M'
    // Naga
    constant integer NAGA_ROYAL_GUARD_HERO                           = 'N0BG'
    constant integer NAGA_SIREN_HERO                                 = 'N0NC'
    constant integer LADY_VASHJ                                      = 'H02B'
    // Gnome
    constant integer GNOME_ENGINEER_HERO                             = 'N0CS'
    constant integer GNOME_WARLOCK_HERO                              = 'O055'
    // Pandaren
    constant integer BREWMASTER                                      = 'Npbm'
    constant integer IRON_FIST                                       = 'E011'
    constant integer SHADO_PAN                                       = 'O032'
    constant integer MONK                                            = 'N032'
    constant integer CHEN_STORMSTOUT                                 = 'N01F'
    // Troll
    constant integer WITCH_DOCTOR_HERO                               = 'O04Y'
    constant integer TROLL_WARLORD                                   = 'N0OH'
    constant integer ROKHAN                                          = 'O00B'
    // Tauren
    constant integer SPIRIT_WALKER_HERO                              = 'O04L'
    constant integer SPIRIT_WALKER_HERO_M                            = 'O04M'
    constant integer CAIRNE_BLOODHOOF                                = 'O02S'
    // Demon
    constant integer PIT_LORD_NEUTRAL                                = 'Nplh'
    constant integer EREDAR_WARLOCK_NEUTRAL                          = 'U00M'
    constant integer SUCCUBUS                                        = 'N0AT'
    constant integer DOOM_GUARD                                      = 'N0CB'
    constant integer FEL_BEAST                                       = 'N04O'
    constant integer INFERNAL_HERO                                   = 'N0HT'
    constant integer JAILER                                          = 'U032'
    constant integer MOARG_OVERLORD                                  = 'N0JL'
    constant integer ARCHIMONDE                                      = 'Uwar'
    constant integer MANNOROTH                                       = 'Nman'
    constant integer KIL_JAEDEN                                      = 'N0FA'
    constant integer TICHONDRIUS_HERO                                = 'Utic'
    constant integer DOOM_LORD                                       = 'N0LG'
    // Draenei
    constant integer ELDER_SAGE                                      = 'N01K'
    constant integer VINDICATOR                                      = 'H0KM'
    constant integer VELEN                                           = 'H0JV'
    // Furbolg
    constant integer FURBOLG_URSA_WARRIOR_HERO                       = 'E00E'
    constant integer FURBOLG_URSA_WARRIOR_HERO_M                     = 'E00F'
    // Dalaran
    constant integer ARCH_SORCERESS                                  = 'H0V3'
    constant integer AEGWYNN                                         = 'H08E'
    // Kul Tiras
    constant integer HYDROMANCER                                     = 'H06F'
    constant integer TIDESAGE                                        = 'H0UN'
    constant integer JAINA_HERO                                      = 'H0A4'
    constant integer ADMIRAL_PROUDMOORE                              = 'Hapm'
    constant integer ADMIRAL_PROUDMOORE_M                            = 'H01O'
    // Stormwind
    constant integer LION_RIDER                                      = 'H0UL'
    constant integer BISHOP                                          = 'H08H'
    // Vrykul
    constant integer THANE                                           = 'H0IQ'
    constant integer FLAMEBINDER                                     = 'H0IS'
    constant integer WOLF_RIDER                                      = 'O04G'
    constant integer DARK_VALKYR                                     = 'N0LE'
    constant integer GOLDEN_VALKYR                                   = 'N0LF'
    // Worgen
    constant integer DEATHCLAW                                       = 'H0J1'
    constant integer WORGEN_DEATH_KNIGHT                             = 'U01K'
    constant integer GENN_GREYMANE                                   = 'H0PN'
    constant integer GENN_GREYMANE_M                                 = 'H0PO'
    // Tuskarr
    constant integer HERO_TUSKARR_CHIEFTAIN                          = 'N0FC'
    // Murloc
    constant integer MURLOC_SORCERER                                 = 'Nmsr'
    // Ogre
    constant integer OGRE_LORD                                       = 'N0D1'
    constant integer OGRE_MAGI_HERO                                  = 'O07J'
    constant integer GRONN                                           = 'N0JU'
    constant integer BEASTMASTER                                     = 'Nbst'
    constant integer REXXAR                                          = 'O00C'
    // Eredar
    constant integer EREDAR_ANNIHILATOR                              = 'N0JX'
    // Fel Orc
    constant integer FEL_BLADEMASTER                                 = 'N01T'
    constant integer FEL_WARLOCK                                     = 'O09I'
    constant integer FEL_WARLORD                                     = 'O09J'
    constant integer FEL_CROSSBOWMAN                                 = 'O09L'
    constant integer FEL_RAIDER                                      = 'O09P'
    constant integer FEL_PEON                                        = 'H0UU'
    constant integer FEL_KODO_BEAST                                  = 'O0BT'
    constant integer FEL_GROMMASH_HELLSCREAM                         = 'O0BX'
    constant integer KARGATH_BLADEFIST                               = 'O09K'
    // Faceless One
    constant integer UNBROKEN                                        = 'N0K5'
    constant integer GENERAL_VEZAX                                   = 'N0KM'
    // Satyr
    constant integer SATYR_HELLCALLER                                = 'N0H0'
    constant integer SATYR_TRICKSTER_HERO                            = 'N0L8'
    // Centaur
    constant integer CENTAUR_KHAN_HERO                               = 'N0D2'
    // Gnoll
    constant integer GNOLL_ALPHA                                     = 'N0HG'
    // Kobold
    constant integer GEOMANCER                                       = 'N0HH'
    constant integer GEOMANCER_BURROWED                              = 'N0MY'
    // Quillboar
    constant integer RAZORMANE_CHIEFTAIN                             = 'O01R'
    // Bandit
    constant integer BANDIT_LORD                                     = 'H07B'
    constant integer ASSASSIN                                        = 'H07C'
    constant integer THIEF                                           = 'H0Y0'
    constant integer DARK_WIZARD                                     = 'H05U'
    // Dragonkin
    constant integer EVOKER                                          = 'H0SY'
    constant integer EVOKER_M                                        = 'H0SZ'
    constant integer DRAGONSPAWN                                     = 'N0JY'
    // Neutral
    constant integer FIRELORD                                        = 'Nfir'
    constant integer SEA_GIANT                                       = 'N0GH'
    constant integer REVENANT                                        = 'U02X'
    constant integer REVENANT_DEEPLORD                               = 'U03J'
    constant integer GIANT_SKELETON                                  = 'U02W'
    constant integer SIEGE_GOLEM                                     = 'N0HY'
    constant integer MAGNATAUR_DESTROYER                             = 'N0HU'
    constant integer BERSERK_WILDKIN                                 = 'N0HK'
    constant integer ICECROWN_OVERLORD                               = 'N0K4'
    constant integer ANCIENT_HYDRA                                   = 'O09N'
    constant integer BROOD_MOTHER                                    = 'N0LD'
    constant integer ANCIENT_SASQUATCH                               = 'O09Q'
    constant integer ANCIENT_WENDIGO                                 = 'O09R'
    constant integer ENRANGED_JUNGLE_STALKER                         = 'O0BW'
    constant integer SLUDGE_MONSTROSITY                              = 'O0A1'
    constant integer SALAMANDER_LORD                                 = 'N0AE'
    constant integer HARPY_QUEEN                                     = 'N0HJ'
    constant integer RED_DRAGON_HERO                                 = 'N02W'
    // Account specific
    constant integer BARADE                                          = 'H0V4'

    // bosses
    constant integer SMOLDERON                                       = 'N0DR'
    constant integer DENATHRIUS                                      = 'U03L'

    // AI commands
    constant integer COMMAND_ATTACK_PLAYERS_ON                       = 1
    constant integer COMMAND_ATTACK_PLAYERS_OFF                      = 2
    constant integer COMMAND_GIVE_GOLD                               = 3
    constant integer COMMAND_GIVE_LUMBER                             = 4
    constant integer COMMAND_SHIPS_ON                                = 5
    constant integer COMMAND_SHIPS_OFF                               = 6
    constant integer COMMAND_EXPANSIONS                              = 7
    constant integer COMMAND_INFO                                    = 8
    constant integer COMMAND_ATTACK_TARGET_ON                        = 9
    constant integer COMMAND_ATTACK_TARGET_OFF                       = 10
    constant integer COMMAND_ATTACK_TARGET_X                         = 11
    constant integer COMMAND_ATTACK_TARGET_Y                         = 12
    constant integer COMMAND_DISABLED_ON                             = 13
    constant integer COMMAND_DISABLED_OFF                            = 14
    constant integer COMMAND_EASY                                    = 15
    constant integer COMMAND_NORMAL                                  = 16
    constant integer COMMAND_HARD                                    = 17
    constant integer COMMAND_INSANE                                  = 18
    constant integer COMMAND_ZEPPELINS                               = 19
    constant integer COMMAND_TRACE_ON                                = 20
    constant integer COMMAND_TRACE_OFF                               = 21
    constant integer COMMAND_SHREDDERS                               = 22
endglobals

//============================================================================
// MathAPI
native Deg2Rad  takes real degrees returns real
native Rad2Deg  takes real radians returns real

native Sin      takes real radians returns real
native Cos      takes real radians returns real
native Tan      takes real radians returns real

// Expect values between -1 and 1...returns 0 for invalid input
native Asin     takes real y returns real
native Acos     takes real x returns real

native Atan     takes real x returns real

// Returns 0 if x and y are both 0
native Atan2    takes real y, real x returns real

// Returns 0 if x <= 0
native SquareRoot takes real x returns real

// computes x to the y power
// y == 0.0             => 1
// x ==0.0 and y < 0    => 0
//
native Pow      takes real x, real power returns real

constant native MathRound takes real r returns integer

//============================================================================
// String Utility API
native I2R  takes integer i returns real
native R2I  takes real r returns integer
native I2S  takes integer i returns string
native R2S  takes real r returns string
native R2SW takes real r, integer width, integer precision returns string
native S2I  takes string s returns integer
native S2R  takes string s returns real
native GetHandleId takes handle h returns integer
native SubString takes string source, integer start, integer end returns string
native StringLength takes string s returns integer
native StringCase takes string source, boolean upper returns string
native StringHash takes string s returns integer

native GetLocalizedString takes string source returns string
native GetLocalizedHotkey takes string source returns integer

//============================================================================
// Map Setup API
//
//  These are native functions for describing the map configuration
//  these funcs should only be used in the "config" function of
//  a map script. The functions should also be called in this order
//  ( i.e. call SetPlayers before SetPlayerColor...
//

native SetMapName           takes string name returns nothing
native SetMapDescription    takes string description returns nothing

native SetTeams             takes integer teamcount returns nothing
native SetPlayers           takes integer playercount returns nothing

native DefineStartLocation          takes integer whichStartLoc, real x, real y returns nothing
native DefineStartLocationLoc       takes integer whichStartLoc, location whichLocation returns nothing
native SetStartLocPrioCount         takes integer whichStartLoc, integer prioSlotCount returns nothing
native SetStartLocPrio              takes integer whichStartLoc, integer prioSlotIndex, integer otherStartLocIndex, startlocprio priority returns nothing
native GetStartLocPrioSlot          takes integer whichStartLoc, integer prioSlotIndex returns integer
native GetStartLocPrio              takes integer whichStartLoc, integer prioSlotIndex returns startlocprio
native SetEnemyStartLocPrioCount    takes integer whichStartLoc, integer prioSlotCount returns nothing
native SetEnemyStartLocPrio         takes integer whichStartLoc, integer prioSlotIndex, integer otherStartLocIndex, startlocprio priority returns nothing

native SetGameTypeSupported takes gametype whichGameType, boolean value returns nothing
native SetMapFlag           takes mapflag whichMapFlag, boolean value returns nothing
native SetGamePlacement     takes placement whichPlacementType returns nothing
native SetGameSpeed         takes gamespeed whichspeed returns nothing
native SetGameDifficulty    takes gamedifficulty whichdifficulty returns nothing
native SetResourceDensity   takes mapdensity whichdensity returns nothing
native SetCreatureDensity   takes mapdensity whichdensity returns nothing

native GetTeams             takes nothing returns integer
native GetPlayers           takes nothing returns integer

native IsGameTypeSupported  takes gametype whichGameType returns boolean
native GetGameTypeSelected  takes nothing returns gametype
native IsMapFlagSet         takes mapflag whichMapFlag returns boolean

constant native GetGamePlacement     takes nothing returns placement
constant native GetGameSpeed         takes nothing returns gamespeed
constant native GetGameDifficulty    takes nothing returns gamedifficulty
constant native GetResourceDensity   takes nothing returns mapdensity
constant native GetCreatureDensity   takes nothing returns mapdensity
constant native GetStartLocationX    takes integer whichStartLocation returns real
constant native GetStartLocationY    takes integer whichStartLocation returns real
constant native GetStartLocationLoc  takes integer whichStartLocation returns location


native SetPlayerTeam            takes player whichPlayer, integer whichTeam returns nothing
native SetPlayerStartLocation   takes player whichPlayer, integer startLocIndex returns nothing
// forces player to have the specified start loc and marks the start loc as occupied
// which removes it from consideration for subsequently placed players
// ( i.e. you can use this to put people in a fixed loc and then
//   use random placement for any unplaced players etc )
native ForcePlayerStartLocation takes player whichPlayer, integer startLocIndex returns nothing
native SetPlayerColor           takes player whichPlayer, playercolor color returns nothing
native SetPlayerAlliance        takes player sourcePlayer, player otherPlayer, alliancetype whichAllianceSetting, boolean value returns nothing
native SetPlayerTaxRate         takes player sourcePlayer, player otherPlayer, playerstate whichResource, integer rate returns nothing
native SetPlayerRacePreference  takes player whichPlayer, racepreference whichRacePreference returns nothing
native SetPlayerRaceSelectable  takes player whichPlayer, boolean value returns nothing
native SetPlayerController      takes player whichPlayer, mapcontrol controlType returns nothing
native SetPlayerName            takes player whichPlayer, string name returns nothing

native SetPlayerOnScoreScreen   takes player whichPlayer, boolean flag returns nothing

native GetPlayerTeam            takes player whichPlayer returns integer
native GetPlayerStartLocation   takes player whichPlayer returns integer
native GetPlayerColor           takes player whichPlayer returns playercolor
native GetPlayerSelectable      takes player whichPlayer returns boolean
native GetPlayerController      takes player whichPlayer returns mapcontrol
native GetPlayerSlotState       takes player whichPlayer returns playerslotstate
native GetPlayerTaxRate         takes player sourcePlayer, player otherPlayer, playerstate whichResource returns integer
native IsPlayerRacePrefSet      takes player whichPlayer, racepreference pref returns boolean
native GetPlayerName            takes player whichPlayer returns string

//============================================================================
// Timer API
//
native CreateTimer          takes nothing returns timer
native DestroyTimer         takes timer whichTimer returns nothing
native TimerStart           takes timer whichTimer, real timeout, boolean periodic, code handlerFunc returns nothing
native TimerGetElapsed      takes timer whichTimer returns real
native TimerGetRemaining    takes timer whichTimer returns real
native TimerGetTimeout      takes timer whichTimer returns real
native PauseTimer           takes timer whichTimer returns nothing
native ResumeTimer          takes timer whichTimer returns nothing
native GetExpiredTimer      takes nothing returns timer

//============================================================================
// Group API
//
native CreateGroup                          takes nothing returns group
native DestroyGroup                         takes group whichGroup returns nothing
native GroupAddUnit                         takes group whichGroup, unit whichUnit returns boolean
native GroupRemoveUnit                      takes group whichGroup, unit whichUnit returns boolean
native BlzGroupAddGroupFast                 takes group whichGroup, group addGroup returns integer
native BlzGroupRemoveGroupFast              takes group whichGroup, group removeGroup returns integer
native GroupClear                           takes group whichGroup returns nothing
native BlzGroupGetSize                      takes group whichGroup returns integer
native BlzGroupUnitAt                       takes group whichGroup, integer index returns unit
native GroupEnumUnitsOfType                 takes group whichGroup, string unitname, boolexpr filter returns nothing
native GroupEnumUnitsOfPlayer               takes group whichGroup, player whichPlayer, boolexpr filter returns nothing
native GroupEnumUnitsOfTypeCounted          takes group whichGroup, string unitname, boolexpr filter, integer countLimit returns nothing
native GroupEnumUnitsInRect                 takes group whichGroup, rect r, boolexpr filter returns nothing
native GroupEnumUnitsInRectCounted          takes group whichGroup, rect r, boolexpr filter, integer countLimit returns nothing
native GroupEnumUnitsInRange                takes group whichGroup, real x, real y, real radius, boolexpr filter returns nothing
native GroupEnumUnitsInRangeOfLoc           takes group whichGroup, location whichLocation, real radius, boolexpr filter returns nothing
native GroupEnumUnitsInRangeCounted         takes group whichGroup, real x, real y, real radius, boolexpr filter, integer countLimit returns nothing
native GroupEnumUnitsInRangeOfLocCounted    takes group whichGroup, location whichLocation, real radius, boolexpr filter, integer countLimit returns nothing
native GroupEnumUnitsSelected               takes group whichGroup, player whichPlayer, boolexpr filter returns nothing

native GroupImmediateOrder                  takes group whichGroup, string order returns boolean
native GroupImmediateOrderById              takes group whichGroup, integer order returns boolean
native GroupPointOrder                      takes group whichGroup, string order, real x, real y returns boolean
native GroupPointOrderLoc                   takes group whichGroup, string order, location whichLocation returns boolean
native GroupPointOrderById                  takes group whichGroup, integer order, real x, real y returns boolean
native GroupPointOrderByIdLoc               takes group whichGroup, integer order, location whichLocation returns boolean
native GroupTargetOrder                     takes group whichGroup, string order, widget targetWidget returns boolean
native GroupTargetOrderById                 takes group whichGroup, integer order, widget targetWidget returns boolean

// This will be difficult to support with potentially disjoint, cell-based regions
// as it would involve enumerating all the cells that are covered by a particularregion
// a better implementation would be a trigger that adds relevant units as they enter
// and removes them if they leave...
native ForGroup                 takes group whichGroup, code callback returns nothing
native FirstOfGroup             takes group whichGroup returns unit

//============================================================================
// Force API
//
native CreateForce              takes nothing returns force
native DestroyForce             takes force whichForce returns nothing
native ForceAddPlayer           takes force whichForce, player whichPlayer returns nothing
native ForceRemovePlayer        takes force whichForce, player whichPlayer returns nothing
native BlzForceHasPlayer        takes force whichForce, player whichPlayer returns boolean
native ForceClear               takes force whichForce returns nothing
native ForceEnumPlayers         takes force whichForce, boolexpr filter returns nothing
native ForceEnumPlayersCounted  takes force whichForce, boolexpr filter, integer countLimit returns nothing
native ForceEnumAllies          takes force whichForce, player whichPlayer, boolexpr filter returns nothing
native ForceEnumEnemies         takes force whichForce, player whichPlayer, boolexpr filter returns nothing
native ForForce                 takes force whichForce, code callback returns nothing

//============================================================================
// Region and Location API
//
native Rect                     takes real minx, real miny, real maxx, real maxy returns rect
native RectFromLoc              takes location min, location max returns rect
native RemoveRect               takes rect whichRect returns nothing
native SetRect                  takes rect whichRect, real minx, real miny, real maxx, real maxy returns nothing
native SetRectFromLoc           takes rect whichRect, location min, location max returns nothing
native MoveRectTo               takes rect whichRect, real newCenterX, real newCenterY returns nothing
native MoveRectToLoc            takes rect whichRect, location newCenterLoc returns nothing

native GetRectCenterX           takes rect whichRect returns real
native GetRectCenterY           takes rect whichRect returns real
native GetRectMinX              takes rect whichRect returns real
native GetRectMinY              takes rect whichRect returns real
native GetRectMaxX              takes rect whichRect returns real
native GetRectMaxY              takes rect whichRect returns real

// Barade: Never call in a globals block during initlization. The game will crash when saving it and it sometimes leads to a game lagging forever.
native CreateRegion             takes nothing returns region
native RemoveRegion             takes region whichRegion returns nothing

native RegionAddRect            takes region whichRegion, rect r returns nothing
native RegionClearRect          takes region whichRegion, rect r returns nothing

native RegionAddCell           takes region whichRegion, real x, real y returns nothing
native RegionAddCellAtLoc      takes region whichRegion, location whichLocation returns nothing
native RegionClearCell         takes region whichRegion, real x, real y returns nothing
native RegionClearCellAtLoc    takes region whichRegion, location whichLocation returns nothing

native Location                 takes real x, real y returns location
native RemoveLocation           takes location whichLocation returns nothing
native MoveLocation             takes location whichLocation, real newX, real newY returns nothing
native GetLocationX             takes location whichLocation returns real
native GetLocationY             takes location whichLocation returns real

// This function is asynchronous. The values it returns are not guaranteed synchronous between each player.
//  If you attempt to use it in a synchronous manner, it may cause a desync.
native GetLocationZ             takes location whichLocation returns real

native IsUnitInRegion               takes region whichRegion, unit whichUnit returns boolean
native IsPointInRegion              takes region whichRegion, real x, real y returns boolean
native IsLocationInRegion           takes region whichRegion, location whichLocation returns boolean

// Returns full map bounds, including unplayable borders, in world coordinates
native GetWorldBounds           takes nothing returns rect

//============================================================================
// Native trigger interface
//
native CreateTrigger    takes nothing returns trigger
native DestroyTrigger   takes trigger whichTrigger returns nothing
native ResetTrigger     takes trigger whichTrigger returns nothing
native EnableTrigger    takes trigger whichTrigger returns nothing
native DisableTrigger   takes trigger whichTrigger returns nothing
native IsTriggerEnabled takes trigger whichTrigger returns boolean

native TriggerWaitOnSleeps   takes trigger whichTrigger, boolean flag returns nothing
native IsTriggerWaitOnSleeps takes trigger whichTrigger returns boolean

constant native GetFilterUnit       takes nothing returns unit
constant native GetEnumUnit         takes nothing returns unit

constant native GetFilterDestructable   takes nothing returns destructable
constant native GetEnumDestructable     takes nothing returns destructable

constant native GetFilterItem           takes nothing returns item
constant native GetEnumItem             takes nothing returns item

constant native ParseTags               takes string taggedString returns string

constant native GetFilterPlayer     takes nothing returns player
constant native GetEnumPlayer       takes nothing returns player

constant native GetTriggeringTrigger    takes nothing returns trigger
constant native GetTriggerEventId       takes nothing returns eventid
constant native GetTriggerEvalCount     takes trigger whichTrigger returns integer
constant native GetTriggerExecCount     takes trigger whichTrigger returns integer

native ExecuteFunc          takes string funcName returns nothing

//============================================================================
// Boolean Expr API ( for compositing trigger conditions and unit filter funcs...)
//============================================================================
native And              takes boolexpr operandA, boolexpr operandB returns boolexpr
native Or               takes boolexpr operandA, boolexpr operandB returns boolexpr
native Not              takes boolexpr operand returns boolexpr
native Condition        takes code func returns conditionfunc
native DestroyCondition takes conditionfunc c returns nothing
native Filter           takes code func returns filterfunc
native DestroyFilter    takes filterfunc f returns nothing
native DestroyBoolExpr  takes boolexpr e returns nothing

//============================================================================
// Trigger Game Event API
//============================================================================

native TriggerRegisterVariableEvent takes trigger whichTrigger, string varName, limitop opcode, real limitval returns event

    // EVENT_GAME_VARIABLE_LIMIT
    //constant native string GetTriggeringVariableName takes nothing returns string

// Creates it's own timer and triggers when it expires
native TriggerRegisterTimerEvent takes trigger whichTrigger, real timeout, boolean periodic returns event

// Triggers when the timer you tell it about expires
native TriggerRegisterTimerExpireEvent takes trigger whichTrigger, timer t returns event

native TriggerRegisterGameStateEvent takes trigger whichTrigger, gamestate whichState, limitop opcode, real limitval returns event

native TriggerRegisterDialogEvent       takes trigger whichTrigger, dialog whichDialog returns event
native TriggerRegisterDialogButtonEvent takes trigger whichTrigger, button whichButton returns event

//  EVENT_GAME_STATE_LIMIT
constant native GetEventGameState takes nothing returns gamestate

native TriggerRegisterGameEvent takes trigger whichTrigger, gameevent whichGameEvent returns event

// EVENT_GAME_VICTORY
constant native GetWinningPlayer takes nothing returns player


native TriggerRegisterEnterRegion takes trigger whichTrigger, region whichRegion, boolexpr filter returns event

// EVENT_GAME_ENTER_REGION
constant native GetTriggeringRegion takes nothing returns region
constant native GetEnteringUnit takes nothing returns unit

// EVENT_GAME_LEAVE_REGION

native TriggerRegisterLeaveRegion takes trigger whichTrigger, region whichRegion, boolexpr filter returns event
constant native GetLeavingUnit takes nothing returns unit

native TriggerRegisterTrackableHitEvent takes trigger whichTrigger, trackable t returns event
native TriggerRegisterTrackableTrackEvent takes trigger whichTrigger, trackable t returns event

// EVENT_COMMAND_BUTTON_CLICK
native TriggerRegisterCommandEvent takes trigger whichTrigger, integer whichAbility, string order returns event
native TriggerRegisterUpgradeCommandEvent takes trigger whichTrigger, integer whichUpgrade returns event

// EVENT_GAME_TRACKABLE_HIT
// EVENT_GAME_TRACKABLE_TRACK
constant native GetTriggeringTrackable takes nothing returns trackable

// EVENT_DIALOG_BUTTON_CLICK
constant native GetClickedButton takes nothing returns button
constant native GetClickedDialog    takes nothing returns dialog

// EVENT_GAME_TOURNAMENT_FINISH_SOON
constant native GetTournamentFinishSoonTimeRemaining takes nothing returns real
constant native GetTournamentFinishNowRule takes nothing returns integer
constant native GetTournamentFinishNowPlayer takes nothing returns player
constant native GetTournamentScore takes player whichPlayer returns integer

// EVENT_GAME_SAVE
constant native GetSaveBasicFilename takes nothing returns string

//============================================================================
// Trigger Player Based Event API
//============================================================================

native TriggerRegisterPlayerEvent takes trigger whichTrigger, player  whichPlayer, playerevent whichPlayerEvent returns event

// EVENT_PLAYER_DEFEAT
// EVENT_PLAYER_VICTORY
constant native GetTriggerPlayer takes nothing returns player

native TriggerRegisterPlayerUnitEvent takes trigger whichTrigger, player whichPlayer, playerunitevent whichPlayerUnitEvent, boolexpr filter returns event

// EVENT_PLAYER_HERO_LEVEL
// EVENT_UNIT_HERO_LEVEL
constant native GetLevelingUnit takes nothing returns unit

// EVENT_PLAYER_HERO_SKILL
// EVENT_UNIT_HERO_SKILL
constant native GetLearningUnit      takes nothing returns unit
constant native GetLearnedSkill      takes nothing returns integer
constant native GetLearnedSkillLevel takes nothing returns integer

// EVENT_PLAYER_HERO_REVIVABLE
constant native GetRevivableUnit takes nothing returns unit

// EVENT_PLAYER_HERO_REVIVE_START
// EVENT_PLAYER_HERO_REVIVE_CANCEL
// EVENT_PLAYER_HERO_REVIVE_FINISH
// EVENT_UNIT_HERO_REVIVE_START
// EVENT_UNIT_HERO_REVIVE_CANCEL
// EVENT_UNIT_HERO_REVIVE_FINISH
constant native GetRevivingUnit takes nothing returns unit

// EVENT_PLAYER_UNIT_ATTACKED
constant native GetAttacker takes nothing returns unit

// EVENT_PLAYER_UNIT_RESCUED
constant native GetRescuer  takes nothing returns unit

// EVENT_PLAYER_UNIT_DEATH
constant native GetDyingUnit takes nothing returns unit
constant native GetKillingUnit takes nothing returns unit

// EVENT_PLAYER_UNIT_DECAY
constant native GetDecayingUnit takes nothing returns unit

// EVENT_PLAYER_UNIT_SELECTED
//constant native GetSelectedUnit takes nothing returns unit

// EVENT_PLAYER_UNIT_CONSTRUCT_START
constant native GetConstructingStructure takes nothing returns unit

// EVENT_PLAYER_UNIT_CONSTRUCT_FINISH
// EVENT_PLAYER_UNIT_CONSTRUCT_CANCEL
constant native GetCancelledStructure takes nothing returns unit
constant native GetConstructedStructure takes nothing returns unit

// EVENT_PLAYER_UNIT_RESEARCH_START
// EVENT_PLAYER_UNIT_RESEARCH_CANCEL
// EVENT_PLAYER_UNIT_RESEARCH_FINISH
constant native GetResearchingUnit takes nothing returns unit
constant native GetResearched takes nothing returns integer

// EVENT_PLAYER_UNIT_TRAIN_START
// EVENT_PLAYER_UNIT_TRAIN_CANCEL
constant native GetTrainedUnitType takes nothing returns integer

// EVENT_PLAYER_UNIT_TRAIN_FINISH
constant native GetTrainedUnit takes nothing returns unit

// EVENT_PLAYER_UNIT_DETECTED
constant native GetDetectedUnit takes nothing returns unit

// EVENT_PLAYER_UNIT_SUMMONED
constant native GetSummoningUnit    takes nothing returns unit
constant native GetSummonedUnit     takes nothing returns unit

// EVENT_PLAYER_UNIT_LOADED
constant native GetTransportUnit    takes nothing returns unit
constant native GetLoadedUnit       takes nothing returns unit

// EVENT_PLAYER_UNIT_SELL
constant native GetSellingUnit      takes nothing returns unit
constant native GetSoldUnit         takes nothing returns unit
constant native GetBuyingUnit       takes nothing returns unit

// EVENT_PLAYER_UNIT_SELL_ITEM
constant native GetSoldItem         takes nothing returns item

// EVENT_PLAYER_UNIT_CHANGE_OWNER
constant native GetChangingUnit             takes nothing returns unit
constant native GetChangingUnitPrevOwner    takes nothing returns player

// EVENT_PLAYER_UNIT_DROP_ITEM
// EVENT_PLAYER_UNIT_PICKUP_ITEM
// EVENT_PLAYER_UNIT_USE_ITEM
constant native GetManipulatingUnit takes nothing returns unit
constant native GetManipulatedItem  takes nothing returns item

// For EVENT_PLAYER_UNIT_PICKUP_ITEM, returns the item absorbing the picked up item in case it is stacking.
// Returns null if the item was a powerup and not a stacking item.
constant native BlzGetAbsorbingItem takes nothing returns item
constant native BlzGetManipulatedItemWasAbsorbed takes nothing returns boolean

// EVENT_PLAYER_UNIT_STACK_ITEM
// Source is the item that is losing charges, Target is the item getting charges.
constant native BlzGetStackingItemSource takes nothing returns item
constant native BlzGetStackingItemTarget takes nothing returns item
constant native BlzGetStackingItemTargetPreviousCharges takes nothing returns integer

// EVENT_PLAYER_UNIT_ISSUED_ORDER
constant native GetOrderedUnit takes nothing returns unit
constant native GetIssuedOrderId takes nothing returns integer

// EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER
constant native GetOrderPointX takes nothing returns real
constant native GetOrderPointY takes nothing returns real
constant native GetOrderPointLoc takes nothing returns location

// EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER
constant native GetOrderTarget              takes nothing returns widget
constant native GetOrderTargetDestructable  takes nothing returns destructable
constant native GetOrderTargetItem          takes nothing returns item
constant native GetOrderTargetUnit          takes nothing returns unit

// EVENT_UNIT_SPELL_CHANNEL
// EVENT_UNIT_SPELL_CAST
// EVENT_UNIT_SPELL_EFFECT
// EVENT_UNIT_SPELL_FINISH
// EVENT_UNIT_SPELL_ENDCAST
// EVENT_PLAYER_UNIT_SPELL_CHANNEL
// EVENT_PLAYER_UNIT_SPELL_CAST
// EVENT_PLAYER_UNIT_SPELL_EFFECT
// EVENT_PLAYER_UNIT_SPELL_FINISH
// EVENT_PLAYER_UNIT_SPELL_ENDCAST
constant native GetSpellAbilityUnit         takes nothing returns unit
constant native GetSpellAbilityId           takes nothing returns integer
constant native GetSpellAbility             takes nothing returns ability
constant native GetSpellTargetLoc           takes nothing returns location
constant native GetSpellTargetX				takes nothing returns real
constant native GetSpellTargetY				takes nothing returns real
constant native GetSpellTargetDestructable  takes nothing returns destructable
constant native GetSpellTargetItem          takes nothing returns item
constant native GetSpellTargetUnit          takes nothing returns unit

native TriggerRegisterPlayerAllianceChange takes trigger whichTrigger, player whichPlayer, alliancetype whichAlliance returns event
native TriggerRegisterPlayerStateEvent takes trigger whichTrigger, player whichPlayer, playerstate whichState, limitop opcode, real limitval returns event

// EVENT_PLAYER_STATE_LIMIT
constant native GetEventPlayerState takes nothing returns playerstate

native TriggerRegisterPlayerChatEvent takes trigger whichTrigger, player whichPlayer, string chatMessageToDetect, boolean exactMatchOnly returns event

// EVENT_PLAYER_CHAT

// returns the actual string they typed in ( same as what you registered for
// if you required exact match )
constant native GetEventPlayerChatString takes nothing returns string

// returns the string that you registered for
constant native GetEventPlayerChatStringMatched takes nothing returns string

native TriggerRegisterDeathEvent takes trigger whichTrigger, widget whichWidget returns event

//============================================================================
// Trigger Unit Based Event API
//============================================================================

// returns handle to unit which triggered the most recent event when called from
// within a trigger action function...returns null handle when used incorrectly

constant native GetTriggerUnit takes nothing returns unit

native TriggerRegisterUnitStateEvent takes trigger whichTrigger, unit whichUnit, unitstate whichState, limitop opcode, real limitval returns event

// EVENT_UNIT_STATE_LIMIT
constant native GetEventUnitState takes nothing returns unitstate

native TriggerRegisterUnitEvent takes trigger whichTrigger, unit whichUnit, unitevent whichEvent returns event

// EVENT_UNIT_DAMAGED
constant native GetEventDamage takes nothing returns real
constant native GetEventDamageSource takes nothing returns unit

// EVENT_UNIT_DEATH
// EVENT_UNIT_DECAY
// Use the GetDyingUnit and GetDecayingUnit funcs above

// EVENT_UNIT_DETECTED
constant native GetEventDetectingPlayer takes nothing returns player

native TriggerRegisterFilterUnitEvent takes trigger whichTrigger, unit whichUnit, unitevent whichEvent, boolexpr filter returns event

// EVENT_UNIT_ACQUIRED_TARGET
// EVENT_UNIT_TARGET_IN_RANGE
constant native GetEventTargetUnit takes nothing returns unit

// EVENT_UNIT_ATTACKED
// Use GetAttacker from the Player Unit Event API Below...

// EVENT_UNIT_RESCUEDED
// Use GetRescuer from the Player Unit Event API Below...

// EVENT_UNIT_CONSTRUCT_CANCEL
// EVENT_UNIT_CONSTRUCT_FINISH

// See the Player Unit Construction Event API above for event info funcs

// EVENT_UNIT_TRAIN_START
// EVENT_UNIT_TRAIN_CANCELLED
// EVENT_UNIT_TRAIN_FINISH

// See the Player Unit Training Event API above for event info funcs

// EVENT_UNIT_SELL

// See the Player Unit Sell Event API above for event info funcs

// EVENT_UNIT_DROP_ITEM
// EVENT_UNIT_PICKUP_ITEM
// EVENT_UNIT_USE_ITEM
// See the Player Unit/Item manipulation Event API above for event info funcs

// EVENT_UNIT_STACK_ITEM
// See the Player Unit/Item stack Event API above for event info funcs

// EVENT_UNIT_ISSUED_ORDER
// EVENT_UNIT_ISSUED_POINT_ORDER
// EVENT_UNIT_ISSUED_TARGET_ORDER

// See the Player Unit Order Event API above for event info funcs

native TriggerRegisterUnitInRange takes trigger whichTrigger, unit whichUnit, real range, boolexpr filter returns event

native TriggerAddCondition    takes trigger whichTrigger, boolexpr condition returns triggercondition
native TriggerRemoveCondition takes trigger whichTrigger, triggercondition whichCondition returns nothing
native TriggerClearConditions takes trigger whichTrigger returns nothing

native TriggerAddAction     takes trigger whichTrigger, code actionFunc returns triggeraction
native TriggerRemoveAction  takes trigger whichTrigger, triggeraction whichAction returns nothing
native TriggerClearActions  takes trigger whichTrigger returns nothing
native TriggerSleepAction   takes real timeout returns nothing
native TriggerWaitForSound  takes sound s, real offset returns nothing
native TriggerEvaluate      takes trigger whichTrigger returns boolean
native TriggerExecute       takes trigger whichTrigger returns nothing
native TriggerExecuteWait   takes trigger whichTrigger returns nothing
native TriggerSyncStart     takes nothing returns nothing
native TriggerSyncReady     takes nothing returns nothing

//============================================================================
// Widget API
native  GetWidgetLife   takes widget whichWidget returns real
native  SetWidgetLife   takes widget whichWidget, real newLife returns nothing
native  GetWidgetX      takes widget whichWidget returns real
native  GetWidgetY      takes widget whichWidget returns real
constant native GetTriggerWidget takes nothing returns widget

//============================================================================
// Destructable Object API
// Facing arguments are specified in degrees
native          CreateDestructable          takes integer objectid, real x, real y, real face, real scale, integer variation returns destructable
native          CreateDestructableZ         takes integer objectid, real x, real y, real z, real face, real scale, integer variation returns destructable
native          CreateDeadDestructable      takes integer objectid, real x, real y, real face, real scale, integer variation returns destructable
native          CreateDeadDestructableZ     takes integer objectid, real x, real y, real z, real face, real scale, integer variation returns destructable
native          RemoveDestructable          takes destructable d returns nothing
native          KillDestructable            takes destructable d returns nothing
native          SetDestructableInvulnerable takes destructable d, boolean flag returns nothing
native          IsDestructableInvulnerable  takes destructable d returns boolean
native          EnumDestructablesInRect     takes rect r, boolexpr filter, code actionFunc returns nothing
native          GetDestructableTypeId       takes destructable d returns integer
native          GetDestructableX            takes destructable d returns real
native          GetDestructableY            takes destructable d returns real
native          SetDestructableLife         takes destructable d, real life returns nothing
native          GetDestructableLife         takes destructable d returns real
native          SetDestructableMaxLife      takes destructable d, real max returns nothing
native          GetDestructableMaxLife      takes destructable d returns real
native          DestructableRestoreLife     takes destructable d, real life, boolean birth returns nothing
native          QueueDestructableAnimation  takes destructable d, string whichAnimation returns nothing
native          SetDestructableAnimation    takes destructable d, string whichAnimation returns nothing
native          SetDestructableAnimationSpeed takes destructable d, real speedFactor returns nothing
native          ShowDestructable            takes destructable d, boolean flag returns nothing
native          GetDestructableOccluderHeight takes destructable d returns real
native          SetDestructableOccluderHeight takes destructable d, real height returns nothing
native          GetDestructableName         takes destructable d returns string
constant native GetTriggerDestructable takes nothing returns destructable

//============================================================================
// Item API
native          CreateItem      takes integer itemid, real x, real y returns item
native          RemoveItem      takes item whichItem returns nothing
native          GetItemPlayer   takes item whichItem returns player
native          GetItemTypeId   takes item i returns integer
native          GetItemX        takes item i returns real
native          GetItemY        takes item i returns real
native          SetItemPosition takes item i, real x, real y returns nothing
native          SetItemDropOnDeath  takes item whichItem, boolean flag returns nothing
native          SetItemDroppable takes item i, boolean flag returns nothing
native          SetItemPawnable takes item i, boolean flag returns nothing
native          SetItemPlayer    takes item whichItem, player whichPlayer, boolean changeColor returns nothing
native          SetItemInvulnerable takes item whichItem, boolean flag returns nothing
native          IsItemInvulnerable  takes item whichItem returns boolean
native          SetItemVisible  takes item whichItem, boolean show returns nothing
native          IsItemVisible   takes item whichItem returns boolean
native          IsItemOwned     takes item whichItem returns boolean
native          IsItemPowerup   takes item whichItem returns boolean
native          IsItemSellable  takes item whichItem returns boolean
native          IsItemPawnable  takes item whichItem returns boolean
native          IsItemIdPowerup takes integer itemId returns boolean
native          IsItemIdSellable takes integer itemId returns boolean
native          IsItemIdPawnable takes integer itemId returns boolean
native          EnumItemsInRect     takes rect r, boolexpr filter, code actionFunc returns nothing
native          GetItemLevel    takes item whichItem returns integer
native          GetItemType     takes item whichItem returns itemtype
native          SetItemDropID   takes item whichItem, integer unitId returns nothing
constant native GetItemName     takes item whichItem returns string
native          GetItemCharges  takes item whichItem returns integer
native          SetItemCharges  takes item whichItem, integer charges returns nothing
native          GetItemUserData takes item whichItem returns integer
native          SetItemUserData takes item whichItem, integer data returns nothing

//============================================================================
// Unit API
// Facing arguments are specified in degrees
native          CreateUnit              takes player id, integer unitid, real x, real y, real face returns unit
native          CreateUnitByName        takes player whichPlayer, string unitname, real x, real y, real face returns unit
native          CreateUnitAtLoc         takes player id, integer unitid, location whichLocation, real face returns unit
native          CreateUnitAtLocByName   takes player id, string unitname, location whichLocation, real face returns unit
native          CreateCorpse            takes player whichPlayer, integer unitid, real x, real y, real face returns unit

native          KillUnit            takes unit whichUnit returns nothing
native          RemoveUnit          takes unit whichUnit returns nothing
native          ShowUnit            takes unit whichUnit, boolean show returns nothing

native          SetUnitState        takes unit whichUnit, unitstate whichUnitState, real newVal returns nothing
native          SetUnitX            takes unit whichUnit, real newX returns nothing
native          SetUnitY            takes unit whichUnit, real newY returns nothing
native          SetUnitPosition     takes unit whichUnit, real newX, real newY returns nothing
native          SetUnitPositionLoc  takes unit whichUnit, location whichLocation returns nothing
native          SetUnitFacing       takes unit whichUnit, real facingAngle returns nothing
native          SetUnitFacingTimed  takes unit whichUnit, real facingAngle, real duration returns nothing
native          SetUnitMoveSpeed    takes unit whichUnit, real newSpeed returns nothing
native          SetUnitFlyHeight    takes unit whichUnit, real newHeight, real rate returns nothing
native          SetUnitTurnSpeed    takes unit whichUnit, real newTurnSpeed returns nothing
native          SetUnitPropWindow   takes unit whichUnit, real newPropWindowAngle returns nothing
native          SetUnitAcquireRange takes unit whichUnit, real newAcquireRange returns nothing
native          SetUnitCreepGuard   takes unit whichUnit, boolean creepGuard returns nothing

native          GetUnitAcquireRange     takes unit whichUnit returns real
native          GetUnitTurnSpeed        takes unit whichUnit returns real
native          GetUnitPropWindow       takes unit whichUnit returns real
native          GetUnitFlyHeight        takes unit whichUnit returns real

native          GetUnitDefaultAcquireRange      takes unit whichUnit returns real
native          GetUnitDefaultTurnSpeed         takes unit whichUnit returns real
native          GetUnitDefaultPropWindow        takes unit whichUnit returns real
native          GetUnitDefaultFlyHeight         takes unit whichUnit returns real

native          SetUnitOwner        takes unit whichUnit, player whichPlayer, boolean changeColor returns nothing
native          SetUnitColor        takes unit whichUnit, playercolor whichColor returns nothing

native          SetUnitScale        takes unit whichUnit, real scaleX, real scaleY, real scaleZ returns nothing
native          SetUnitTimeScale    takes unit whichUnit, real timeScale returns nothing
native          SetUnitBlendTime    takes unit whichUnit, real blendTime returns nothing
native          SetUnitVertexColor  takes unit whichUnit, integer red, integer green, integer blue, integer alpha returns nothing

native          QueueUnitAnimation          takes unit whichUnit, string whichAnimation returns nothing
native          SetUnitAnimation            takes unit whichUnit, string whichAnimation returns nothing
native          SetUnitAnimationByIndex     takes unit whichUnit, integer whichAnimation returns nothing
native          SetUnitAnimationWithRarity  takes unit whichUnit, string whichAnimation, raritycontrol rarity returns nothing
native          AddUnitAnimationProperties  takes unit whichUnit, string animProperties, boolean add returns nothing

native          SetUnitLookAt       takes unit whichUnit, string whichBone, unit lookAtTarget, real offsetX, real offsetY, real offsetZ returns nothing
native          ResetUnitLookAt     takes unit whichUnit returns nothing

native          SetUnitRescuable    takes unit whichUnit, player byWhichPlayer, boolean flag returns nothing
native          SetUnitRescueRange  takes unit whichUnit, real range returns nothing

native          SetHeroStr          takes unit whichHero, integer newStr, boolean permanent returns nothing
native          SetHeroAgi          takes unit whichHero, integer newAgi, boolean permanent returns nothing
native          SetHeroInt          takes unit whichHero, integer newInt, boolean permanent returns nothing

native          GetHeroStr          takes unit whichHero, boolean includeBonuses returns integer
native          GetHeroAgi          takes unit whichHero, boolean includeBonuses returns integer
native          GetHeroInt          takes unit whichHero, boolean includeBonuses returns integer

native          UnitStripHeroLevel  takes unit whichHero, integer howManyLevels returns boolean

native          GetHeroXP           takes unit whichHero returns integer
native          SetHeroXP           takes unit whichHero, integer newXpVal,  boolean showEyeCandy returns nothing

native          GetHeroSkillPoints      takes unit whichHero returns integer
native          UnitModifySkillPoints   takes unit whichHero, integer skillPointDelta returns boolean

native          AddHeroXP           takes unit whichHero, integer xpToAdd,   boolean showEyeCandy returns nothing
native          SetHeroLevel        takes unit whichHero, integer level,  boolean showEyeCandy returns nothing
constant native GetHeroLevel        takes unit whichHero returns integer
constant native GetUnitLevel        takes unit whichUnit returns integer
native          GetHeroProperName   takes unit whichHero returns string
native          SuspendHeroXP       takes unit whichHero, boolean flag returns nothing
native          IsSuspendedXP       takes unit whichHero returns boolean
native          SelectHeroSkill     takes unit whichHero, integer abilcode returns nothing
native          GetUnitAbilityLevel takes unit whichUnit, integer abilcode returns integer
native          DecUnitAbilityLevel takes unit whichUnit, integer abilcode returns integer
native          IncUnitAbilityLevel takes unit whichUnit, integer abilcode returns integer
native          SetUnitAbilityLevel takes unit whichUnit, integer abilcode, integer level returns integer
native          ReviveHero          takes unit whichHero, real x, real y, boolean doEyecandy returns boolean
native          ReviveHeroLoc       takes unit whichHero, location loc, boolean doEyecandy returns boolean
native          SetUnitExploded     takes unit whichUnit, boolean exploded returns nothing
native          SetUnitInvulnerable takes unit whichUnit, boolean flag returns nothing
native          PauseUnit           takes unit whichUnit, boolean flag returns nothing
native          IsUnitPaused        takes unit whichHero returns boolean
native          SetUnitPathing      takes unit whichUnit, boolean flag returns nothing

native          ClearSelection      takes nothing returns nothing
native          SelectUnit          takes unit whichUnit, boolean flag returns nothing

native          GetUnitPointValue       takes unit whichUnit returns integer
native          GetUnitPointValueByType takes integer unitType returns integer
//native        SetUnitPointValueByType takes integer unitType, integer newPointValue returns nothing

native          UnitAddItem             takes unit whichUnit, item whichItem returns boolean
native          UnitAddItemById         takes unit whichUnit, integer itemId returns item
native          UnitAddItemToSlotById   takes unit whichUnit, integer itemId, integer itemSlot returns boolean
native          UnitRemoveItem          takes unit whichUnit, item whichItem returns nothing
native          UnitRemoveItemFromSlot  takes unit whichUnit, integer itemSlot returns item
native          UnitHasItem             takes unit whichUnit, item whichItem returns boolean
native          UnitItemInSlot          takes unit whichUnit, integer itemSlot returns item
native          UnitInventorySize       takes unit whichUnit returns integer

native          UnitDropItemPoint       takes unit whichUnit, item whichItem, real x, real y returns boolean
native          UnitDropItemSlot        takes unit whichUnit, item whichItem, integer slot returns boolean
native          UnitDropItemTarget      takes unit whichUnit, item whichItem, widget target returns boolean

native          UnitUseItem             takes unit whichUnit, item whichItem returns boolean
native          UnitUseItemPoint        takes unit whichUnit, item whichItem, real x, real y returns boolean
native          UnitUseItemTarget       takes unit whichUnit, item whichItem, widget target returns boolean

constant native GetUnitX            takes unit whichUnit returns real
constant native GetUnitY            takes unit whichUnit returns real
constant native GetUnitLoc          takes unit whichUnit returns location
constant native GetUnitFacing       takes unit whichUnit returns real
constant native GetUnitMoveSpeed    takes unit whichUnit returns real
constant native GetUnitDefaultMoveSpeed takes unit whichUnit returns real
constant native GetUnitState        takes unit whichUnit, unitstate whichUnitState returns real
constant native GetOwningPlayer     takes unit whichUnit returns player
constant native GetUnitTypeId       takes unit whichUnit returns integer
constant native GetUnitRace         takes unit whichUnit returns race
constant native GetUnitName         takes unit whichUnit returns string
constant native GetUnitFoodUsed     takes unit whichUnit returns integer
constant native GetUnitFoodMade     takes unit whichUnit returns integer
constant native GetFoodMade         takes integer unitId returns integer
constant native GetFoodUsed         takes integer unitId returns integer
native          SetUnitUseFood      takes unit whichUnit, boolean useFood returns nothing

constant native GetUnitRallyPoint           takes unit whichUnit returns location
constant native GetUnitRallyUnit            takes unit whichUnit returns unit
constant native GetUnitRallyDestructable    takes unit whichUnit returns destructable

constant native IsUnitInGroup       takes unit whichUnit, group whichGroup returns boolean
constant native IsUnitInForce       takes unit whichUnit, force whichForce returns boolean
constant native IsUnitOwnedByPlayer takes unit whichUnit, player whichPlayer returns boolean
constant native IsUnitAlly          takes unit whichUnit, player whichPlayer returns boolean
constant native IsUnitEnemy         takes unit whichUnit, player whichPlayer returns boolean
constant native IsUnitVisible       takes unit whichUnit, player whichPlayer returns boolean
constant native IsUnitDetected      takes unit whichUnit, player whichPlayer returns boolean
constant native IsUnitInvisible     takes unit whichUnit, player whichPlayer returns boolean
constant native IsUnitFogged        takes unit whichUnit, player whichPlayer returns boolean
constant native IsUnitMasked        takes unit whichUnit, player whichPlayer returns boolean
constant native IsUnitSelected      takes unit whichUnit, player whichPlayer returns boolean
constant native IsUnitRace          takes unit whichUnit, race whichRace returns boolean
constant native IsUnitType          takes unit whichUnit, unittype whichUnitType returns boolean
constant native IsUnit              takes unit whichUnit, unit whichSpecifiedUnit returns boolean
constant native IsUnitInRange       takes unit whichUnit, unit otherUnit, real distance returns boolean
constant native IsUnitInRangeXY     takes unit whichUnit, real x, real y, real distance returns boolean
constant native IsUnitInRangeLoc    takes unit whichUnit, location whichLocation, real distance returns boolean
constant native IsUnitHidden        takes unit whichUnit returns boolean
constant native IsUnitIllusion      takes unit whichUnit returns boolean

constant native IsUnitInTransport   takes unit whichUnit, unit whichTransport returns boolean
constant native IsUnitLoaded        takes unit whichUnit returns boolean

constant native IsHeroUnitId        takes integer unitId returns boolean
constant native IsUnitIdType        takes integer unitId, unittype whichUnitType returns boolean

native UnitShareVision              takes unit whichUnit, player whichPlayer, boolean share returns nothing
native UnitSuspendDecay             takes unit whichUnit, boolean suspend returns nothing
native UnitAddType                  takes unit whichUnit, unittype whichUnitType returns boolean
native UnitRemoveType               takes unit whichUnit, unittype whichUnitType returns boolean

native UnitAddAbility               takes unit whichUnit, integer abilityId returns boolean
native UnitRemoveAbility            takes unit whichUnit, integer abilityId returns boolean
native UnitMakeAbilityPermanent     takes unit whichUnit, boolean permanent, integer abilityId returns boolean
native UnitRemoveBuffs              takes unit whichUnit, boolean removePositive, boolean removeNegative returns nothing
native UnitRemoveBuffsEx            takes unit whichUnit, boolean removePositive, boolean removeNegative, boolean magic, boolean physical, boolean timedLife, boolean aura, boolean autoDispel returns nothing
native UnitHasBuffsEx               takes unit whichUnit, boolean removePositive, boolean removeNegative, boolean magic, boolean physical, boolean timedLife, boolean aura, boolean autoDispel returns boolean
native UnitCountBuffsEx             takes unit whichUnit, boolean removePositive, boolean removeNegative, boolean magic, boolean physical, boolean timedLife, boolean aura, boolean autoDispel returns integer
native UnitAddSleep                 takes unit whichUnit, boolean add returns nothing
native UnitCanSleep                 takes unit whichUnit returns boolean
native UnitAddSleepPerm             takes unit whichUnit, boolean add returns nothing
native UnitCanSleepPerm             takes unit whichUnit returns boolean
native UnitIsSleeping               takes unit whichUnit returns boolean
native UnitWakeUp                   takes unit whichUnit returns nothing
native UnitApplyTimedLife           takes unit whichUnit, integer buffId, real duration returns nothing
native UnitIgnoreAlarm              takes unit whichUnit, boolean flag returns boolean
native UnitIgnoreAlarmToggled       takes unit whichUnit returns boolean
native UnitResetCooldown            takes unit whichUnit returns nothing
native UnitSetConstructionProgress  takes unit whichUnit, integer constructionPercentage returns nothing
native UnitSetUpgradeProgress       takes unit whichUnit, integer upgradePercentage returns nothing
native UnitPauseTimedLife           takes unit whichUnit, boolean flag returns nothing
native UnitSetUsesAltIcon           takes unit whichUnit, boolean flag returns nothing

native UnitDamagePoint              takes unit whichUnit, real delay, real radius, real x, real y, real amount, boolean attack, boolean ranged, attacktype attackType, damagetype damageType, weapontype weaponType returns boolean
native UnitDamageTarget             takes unit whichUnit, widget target, real amount, boolean attack, boolean ranged, attacktype attackType, damagetype damageType, weapontype weaponType returns boolean

native IssueImmediateOrder          takes unit whichUnit, string order returns boolean
native IssueImmediateOrderById      takes unit whichUnit, integer order returns boolean
native IssuePointOrder              takes unit whichUnit, string order, real x, real y returns boolean
native IssuePointOrderLoc           takes unit whichUnit, string order, location whichLocation returns boolean
native IssuePointOrderById          takes unit whichUnit, integer order, real x, real y returns boolean
native IssuePointOrderByIdLoc       takes unit whichUnit, integer order, location whichLocation returns boolean
native IssueTargetOrder             takes unit whichUnit, string order, widget targetWidget returns boolean
native IssueTargetOrderById         takes unit whichUnit, integer order, widget targetWidget returns boolean
native IssueInstantPointOrder       takes unit whichUnit, string order, real x, real y, widget instantTargetWidget returns boolean
native IssueInstantPointOrderById   takes unit whichUnit, integer order, real x, real y, widget instantTargetWidget returns boolean
native IssueInstantTargetOrder      takes unit whichUnit, string order, widget targetWidget, widget instantTargetWidget returns boolean
native IssueInstantTargetOrderById  takes unit whichUnit, integer order, widget targetWidget, widget instantTargetWidget returns boolean
native IssueBuildOrder              takes unit whichPeon, string unitToBuild, real x, real y returns boolean
native IssueBuildOrderById          takes unit whichPeon, integer unitId, real x, real y returns boolean

native IssueNeutralImmediateOrder       takes player forWhichPlayer, unit neutralStructure, string unitToBuild returns boolean
native IssueNeutralImmediateOrderById   takes player forWhichPlayer,unit neutralStructure, integer unitId returns boolean
native IssueNeutralPointOrder           takes player forWhichPlayer,unit neutralStructure, string unitToBuild, real x, real y returns boolean
native IssueNeutralPointOrderById       takes player forWhichPlayer,unit neutralStructure, integer unitId, real x, real y returns boolean
native IssueNeutralTargetOrder          takes player forWhichPlayer,unit neutralStructure, string unitToBuild, widget target returns boolean
native IssueNeutralTargetOrderById      takes player forWhichPlayer,unit neutralStructure, integer unitId, widget target returns boolean

native GetUnitCurrentOrder          takes unit whichUnit returns integer

native SetResourceAmount            takes unit whichUnit, integer amount returns nothing
native AddResourceAmount            takes unit whichUnit, integer amount returns nothing
native GetResourceAmount            takes unit whichUnit returns integer

native WaygateGetDestinationX       takes unit waygate returns real
native WaygateGetDestinationY       takes unit waygate returns real
native WaygateSetDestination        takes unit waygate, real x, real y returns nothing
native WaygateActivate              takes unit waygate, boolean activate returns nothing
native WaygateIsActive              takes unit waygate returns boolean

native AddItemToAllStock            takes integer itemId, integer currentStock, integer stockMax returns nothing
native AddItemToStock               takes unit whichUnit, integer itemId, integer currentStock, integer stockMax returns nothing
native AddUnitToAllStock            takes integer unitId, integer currentStock, integer stockMax returns nothing
native AddUnitToStock               takes unit whichUnit, integer unitId, integer currentStock, integer stockMax returns nothing

native RemoveItemFromAllStock       takes integer itemId returns nothing
native RemoveItemFromStock          takes unit whichUnit, integer itemId returns nothing
native RemoveUnitFromAllStock       takes integer unitId returns nothing
native RemoveUnitFromStock          takes unit whichUnit, integer unitId returns nothing

native SetAllItemTypeSlots          takes integer slots returns nothing
native SetAllUnitTypeSlots          takes integer slots returns nothing
native SetItemTypeSlots             takes unit whichUnit, integer slots returns nothing
native SetUnitTypeSlots             takes unit whichUnit, integer slots returns nothing

native GetUnitUserData              takes unit whichUnit returns integer
native SetUnitUserData              takes unit whichUnit, integer data returns nothing

//============================================================================
// Player API
constant native Player              takes integer number returns player
constant native GetLocalPlayer      takes nothing returns player
constant native IsPlayerAlly        takes player whichPlayer, player otherPlayer returns boolean
constant native IsPlayerEnemy       takes player whichPlayer, player otherPlayer returns boolean
constant native IsPlayerInForce     takes player whichPlayer, force whichForce returns boolean
constant native IsPlayerObserver    takes player whichPlayer returns boolean
constant native IsVisibleToPlayer           takes real x, real y, player whichPlayer returns boolean
constant native IsLocationVisibleToPlayer   takes location whichLocation, player whichPlayer returns boolean
constant native IsFoggedToPlayer            takes real x, real y, player whichPlayer returns boolean
constant native IsLocationFoggedToPlayer    takes location whichLocation, player whichPlayer returns boolean
constant native IsMaskedToPlayer            takes real x, real y, player whichPlayer returns boolean
constant native IsLocationMaskedToPlayer    takes location whichLocation, player whichPlayer returns boolean

constant native GetPlayerRace           takes player whichPlayer returns race
constant native GetPlayerId             takes player whichPlayer returns integer
constant native GetPlayerUnitCount      takes player whichPlayer, boolean includeIncomplete returns integer
constant native GetPlayerTypedUnitCount takes player whichPlayer, string unitName, boolean includeIncomplete, boolean includeUpgrades returns integer
constant native GetPlayerStructureCount takes player whichPlayer, boolean includeIncomplete returns integer
constant native GetPlayerState          takes player whichPlayer, playerstate whichPlayerState returns integer
constant native GetPlayerScore          takes player whichPlayer, playerscore whichPlayerScore returns integer
constant native GetPlayerAlliance       takes player sourcePlayer, player otherPlayer, alliancetype whichAllianceSetting returns boolean

constant native GetPlayerHandicap       takes player whichPlayer returns real
constant native GetPlayerHandicapXP     takes player whichPlayer returns real
constant native GetPlayerHandicapReviveTime takes player whichPlayer returns real
constant native GetPlayerHandicapDamage takes player whichPlayer returns real
constant native SetPlayerHandicap       takes player whichPlayer, real handicap returns nothing
constant native SetPlayerHandicapXP     takes player whichPlayer, real handicap returns nothing
constant native SetPlayerHandicapReviveTime takes player whichPlayer, real handicap returns nothing
constant native SetPlayerHandicapDamage takes player whichPlayer, real handicap returns nothing

constant native SetPlayerTechMaxAllowed takes player whichPlayer, integer techid, integer maximum returns nothing
constant native GetPlayerTechMaxAllowed takes player whichPlayer, integer techid returns integer
constant native AddPlayerTechResearched takes player whichPlayer, integer techid, integer levels returns nothing
constant native SetPlayerTechResearched takes player whichPlayer, integer techid, integer setToLevel returns nothing
constant native GetPlayerTechResearched takes player whichPlayer, integer techid, boolean specificonly returns boolean
constant native GetPlayerTechCount      takes player whichPlayer, integer techid, boolean specificonly returns integer

native SetPlayerUnitsOwner takes player whichPlayer, integer newOwner returns nothing
native CripplePlayer takes player whichPlayer, force toWhichPlayers, boolean flag returns nothing

native SetPlayerAbilityAvailable        takes player whichPlayer, integer abilid, boolean avail returns nothing

native SetPlayerState   takes player whichPlayer, playerstate whichPlayerState, integer value returns nothing
native RemovePlayer     takes player whichPlayer, playergameresult gameResult returns nothing

// Used to store hero level data for the scorescreen
// before units are moved to neutral passive in melee games
//
native CachePlayerHeroData takes player whichPlayer returns nothing

//============================================================================
// Fog of War API
native  SetFogStateRect      takes player forWhichPlayer, fogstate whichState, rect where, boolean useSharedVision returns nothing
native  SetFogStateRadius    takes player forWhichPlayer, fogstate whichState, real centerx, real centerY, real radius, boolean useSharedVision returns nothing
native  SetFogStateRadiusLoc takes player forWhichPlayer, fogstate whichState, location center, real radius, boolean useSharedVision returns nothing
native  FogMaskEnable        takes boolean enable returns nothing
native  IsFogMaskEnabled     takes nothing returns boolean
native  FogEnable            takes boolean enable returns nothing
native  IsFogEnabled         takes nothing returns boolean

native CreateFogModifierRect        takes player forWhichPlayer, fogstate whichState, rect where, boolean useSharedVision, boolean afterUnits returns fogmodifier
native CreateFogModifierRadius      takes player forWhichPlayer, fogstate whichState, real centerx, real centerY, real radius, boolean useSharedVision, boolean afterUnits returns fogmodifier
native CreateFogModifierRadiusLoc   takes player forWhichPlayer, fogstate whichState, location center, real radius, boolean useSharedVision, boolean afterUnits returns fogmodifier
native DestroyFogModifier           takes fogmodifier whichFogModifier returns nothing
native FogModifierStart             takes fogmodifier whichFogModifier returns nothing
native FogModifierStop              takes fogmodifier whichFogModifier returns nothing

//============================================================================
// Game API
native VersionGet takes nothing returns version
native VersionCompatible takes version whichVersion returns boolean
native VersionSupported takes version whichVersion returns boolean

native EndGame takes boolean doScoreScreen returns nothing

// Async only!
native          ChangeLevel         takes string newLevel, boolean doScoreScreen returns nothing
native          RestartGame         takes boolean doScoreScreen returns nothing
native          ReloadGame          takes nothing returns nothing
// %%% SetCampaignMenuRace is deprecated.  It must remain to support
// old maps which use it, but all new maps should use SetCampaignMenuRaceEx
native          SetCampaignMenuRace takes race r returns nothing
native          SetCampaignMenuRaceEx takes integer campaignIndex returns nothing
native          ForceCampaignSelectScreen takes nothing returns nothing

native          LoadGame            	takes string saveFileName, boolean doScoreScreen returns nothing
native          SaveGame            	takes string saveFileName returns nothing
native          RenameSaveDirectory 	takes string sourceDirName, string destDirName returns boolean
native          RemoveSaveDirectory 	takes string sourceDirName returns boolean
native          CopySaveGame        	takes string sourceSaveName, string destSaveName returns boolean
native          SaveGameExists      	takes string saveName returns boolean
native          SetMaxCheckpointSaves  	takes integer maxCheckpointSaves returns nothing
native          SaveGameCheckpoint  	takes string saveFileName, boolean showWindow returns nothing
// Barade: I had some issues with this in unit selection events and trigger conditions counting the selected units by a player.
native          SyncSelections      	takes nothing returns nothing
native          SetFloatGameState   	takes fgamestate whichFloatGameState, real value returns nothing
constant native GetFloatGameState   	takes fgamestate whichFloatGameState returns real
native          SetIntegerGameState 	takes igamestate whichIntegerGameState, integer value returns nothing
constant native GetIntegerGameState		takes igamestate whichIntegerGameState returns integer


//============================================================================
// Campaign API
native  SetTutorialCleared      takes boolean cleared returns nothing
native  SetMissionAvailable     takes integer campaignNumber, integer missionNumber, boolean available returns nothing
native  SetCampaignAvailable    takes integer campaignNumber, boolean available  returns nothing
native  SetOpCinematicAvailable takes integer campaignNumber, boolean available  returns nothing
native  SetEdCinematicAvailable takes integer campaignNumber, boolean available  returns nothing
native  GetDefaultDifficulty    takes nothing returns gamedifficulty
native  SetDefaultDifficulty    takes gamedifficulty g returns nothing
native  SetCustomCampaignButtonVisible  takes integer whichButton, boolean visible returns nothing
native  GetCustomCampaignButtonVisible  takes integer whichButton returns boolean
native  DoNotSaveReplay         takes nothing returns nothing

//============================================================================
// Dialog API
native DialogCreate                 takes nothing returns dialog
native DialogDestroy                takes dialog whichDialog returns nothing
native DialogClear                  takes dialog whichDialog returns nothing
native DialogSetMessage             takes dialog whichDialog, string messageText returns nothing
native DialogAddButton              takes dialog whichDialog, string buttonText, integer hotkey returns button
native DialogAddQuitButton          takes dialog whichDialog, boolean doScoreScreen, string buttonText, integer hotkey returns button
native DialogDisplay                takes player whichPlayer, dialog whichDialog, boolean flag returns nothing

// Creates a new or reads in an existing game cache file stored
// in the current campaign profile dir
//
native  ReloadGameCachesFromDisk takes nothing returns boolean

native  InitGameCache    takes string campaignFile returns gamecache
native  SaveGameCache    takes gamecache whichCache returns boolean

native  StoreInteger					takes gamecache cache, string missionKey, string key, integer value returns nothing
native  StoreReal						takes gamecache cache, string missionKey, string key, real value returns nothing
native  StoreBoolean					takes gamecache cache, string missionKey, string key, boolean value returns nothing
native  StoreUnit						takes gamecache cache, string missionKey, string key, unit whichUnit returns boolean
native  StoreString						takes gamecache cache, string missionKey, string key, string value returns boolean

native SyncStoredInteger        takes gamecache cache, string missionKey, string key returns nothing
native SyncStoredReal           takes gamecache cache, string missionKey, string key returns nothing
native SyncStoredBoolean        takes gamecache cache, string missionKey, string key returns nothing
native SyncStoredUnit           takes gamecache cache, string missionKey, string key returns nothing
native SyncStoredString         takes gamecache cache, string missionKey, string key returns nothing

native  HaveStoredInteger					takes gamecache cache, string missionKey, string key returns boolean
native  HaveStoredReal						takes gamecache cache, string missionKey, string key returns boolean
native  HaveStoredBoolean					takes gamecache cache, string missionKey, string key returns boolean
native  HaveStoredUnit						takes gamecache cache, string missionKey, string key returns boolean
native  HaveStoredString					takes gamecache cache, string missionKey, string key returns boolean

native  FlushGameCache						takes gamecache cache returns nothing
native  FlushStoredMission					takes gamecache cache, string missionKey returns nothing
native  FlushStoredInteger					takes gamecache cache, string missionKey, string key returns nothing
native  FlushStoredReal						takes gamecache cache, string missionKey, string key returns nothing
native  FlushStoredBoolean					takes gamecache cache, string missionKey, string key returns nothing
native  FlushStoredUnit						takes gamecache cache, string missionKey, string key returns nothing
native  FlushStoredString					takes gamecache cache, string missionKey, string key returns nothing

// Will return 0 if the specified value's data is not found in the cache
native  GetStoredInteger				takes gamecache cache, string missionKey, string key returns integer
native  GetStoredReal					takes gamecache cache, string missionKey, string key returns real
native  GetStoredBoolean				takes gamecache cache, string missionKey, string key returns boolean
native  GetStoredString					takes gamecache cache, string missionKey, string key returns string
native  RestoreUnit						takes gamecache cache, string missionKey, string key, player forWhichPlayer, real x, real y, real facing returns unit


native  InitHashtable    takes nothing returns hashtable

native  SaveInteger						takes hashtable table, integer parentKey, integer childKey, integer value returns nothing
native  SaveReal						takes hashtable table, integer parentKey, integer childKey, real value returns nothing
native  SaveBoolean						takes hashtable table, integer parentKey, integer childKey, boolean value returns nothing
native  SaveStr							takes hashtable table, integer parentKey, integer childKey, string value returns boolean
native  SavePlayerHandle				takes hashtable table, integer parentKey, integer childKey, player whichPlayer returns boolean
native  SaveWidgetHandle				takes hashtable table, integer parentKey, integer childKey, widget whichWidget returns boolean
native  SaveDestructableHandle			takes hashtable table, integer parentKey, integer childKey, destructable whichDestructable returns boolean
native  SaveItemHandle					takes hashtable table, integer parentKey, integer childKey, item whichItem returns boolean
native  SaveUnitHandle					takes hashtable table, integer parentKey, integer childKey, unit whichUnit returns boolean
native  SaveAbilityHandle				takes hashtable table, integer parentKey, integer childKey, ability whichAbility returns boolean
native  SaveTimerHandle					takes hashtable table, integer parentKey, integer childKey, timer whichTimer returns boolean
native  SaveTriggerHandle				takes hashtable table, integer parentKey, integer childKey, trigger whichTrigger returns boolean
native  SaveTriggerConditionHandle		takes hashtable table, integer parentKey, integer childKey, triggercondition whichTriggercondition returns boolean
native  SaveTriggerActionHandle			takes hashtable table, integer parentKey, integer childKey, triggeraction whichTriggeraction returns boolean
native  SaveTriggerEventHandle			takes hashtable table, integer parentKey, integer childKey, event whichEvent returns boolean
native  SaveForceHandle					takes hashtable table, integer parentKey, integer childKey, force whichForce returns boolean
native  SaveGroupHandle					takes hashtable table, integer parentKey, integer childKey, group whichGroup returns boolean
native  SaveLocationHandle				takes hashtable table, integer parentKey, integer childKey, location whichLocation returns boolean
native  SaveRectHandle					takes hashtable table, integer parentKey, integer childKey, rect whichRect returns boolean
native  SaveBooleanExprHandle			takes hashtable table, integer parentKey, integer childKey, boolexpr whichBoolexpr returns boolean
native  SaveSoundHandle					takes hashtable table, integer parentKey, integer childKey, sound whichSound returns boolean
native  SaveEffectHandle				takes hashtable table, integer parentKey, integer childKey, effect whichEffect returns boolean
native  SaveUnitPoolHandle				takes hashtable table, integer parentKey, integer childKey, unitpool whichUnitpool returns boolean
native  SaveItemPoolHandle				takes hashtable table, integer parentKey, integer childKey, itempool whichItempool returns boolean
native  SaveQuestHandle					takes hashtable table, integer parentKey, integer childKey, quest whichQuest returns boolean
native  SaveQuestItemHandle				takes hashtable table, integer parentKey, integer childKey, questitem whichQuestitem returns boolean
native  SaveDefeatConditionHandle		takes hashtable table, integer parentKey, integer childKey, defeatcondition whichDefeatcondition returns boolean
native  SaveTimerDialogHandle			takes hashtable table, integer parentKey, integer childKey, timerdialog whichTimerdialog returns boolean
native  SaveLeaderboardHandle			takes hashtable table, integer parentKey, integer childKey, leaderboard whichLeaderboard returns boolean
native  SaveMultiboardHandle			takes hashtable table, integer parentKey, integer childKey, multiboard whichMultiboard returns boolean
native  SaveMultiboardItemHandle		takes hashtable table, integer parentKey, integer childKey, multiboarditem whichMultiboarditem returns boolean
native  SaveTrackableHandle				takes hashtable table, integer parentKey, integer childKey, trackable whichTrackable returns boolean
native  SaveDialogHandle				takes hashtable table, integer parentKey, integer childKey, dialog whichDialog returns boolean
native  SaveButtonHandle				takes hashtable table, integer parentKey, integer childKey, button whichButton returns boolean
native  SaveTextTagHandle				takes hashtable table, integer parentKey, integer childKey, texttag whichTexttag returns boolean
native  SaveLightningHandle				takes hashtable table, integer parentKey, integer childKey, lightning whichLightning returns boolean
native  SaveImageHandle					takes hashtable table, integer parentKey, integer childKey, image whichImage returns boolean
native  SaveUbersplatHandle				takes hashtable table, integer parentKey, integer childKey, ubersplat whichUbersplat returns boolean
native  SaveRegionHandle				takes hashtable table, integer parentKey, integer childKey, region whichRegion returns boolean
native  SaveFogStateHandle				takes hashtable table, integer parentKey, integer childKey, fogstate whichFogState returns boolean
native  SaveFogModifierHandle			takes hashtable table, integer parentKey, integer childKey, fogmodifier whichFogModifier returns boolean
native  SaveAgentHandle					takes hashtable table, integer parentKey, integer childKey, agent whichAgent returns boolean
native  SaveHashtableHandle				takes hashtable table, integer parentKey, integer childKey, hashtable whichHashtable returns boolean
native  SaveFrameHandle					takes hashtable table, integer parentKey, integer childKey, framehandle whichFrameHandle returns boolean


native  LoadInteger					takes hashtable table, integer parentKey, integer childKey returns integer
native  LoadReal					takes hashtable table, integer parentKey, integer childKey returns real
native  LoadBoolean				    takes hashtable table, integer parentKey, integer childKey returns boolean
native  LoadStr 					takes hashtable table, integer parentKey, integer childKey returns string
native  LoadPlayerHandle			takes hashtable table, integer parentKey, integer childKey returns player
native  LoadWidgetHandle			takes hashtable table, integer parentKey, integer childKey returns widget
native  LoadDestructableHandle		takes hashtable table, integer parentKey, integer childKey returns destructable
native  LoadItemHandle				takes hashtable table, integer parentKey, integer childKey returns item
native  LoadUnitHandle				takes hashtable table, integer parentKey, integer childKey returns unit
native  LoadAbilityHandle			takes hashtable table, integer parentKey, integer childKey returns ability
native  LoadTimerHandle				takes hashtable table, integer parentKey, integer childKey returns timer
native  LoadTriggerHandle			takes hashtable table, integer parentKey, integer childKey returns trigger
native  LoadTriggerConditionHandle	takes hashtable table, integer parentKey, integer childKey returns triggercondition
native  LoadTriggerActionHandle		takes hashtable table, integer parentKey, integer childKey returns triggeraction
native  LoadTriggerEventHandle		takes hashtable table, integer parentKey, integer childKey returns event
native  LoadForceHandle				takes hashtable table, integer parentKey, integer childKey returns force
native  LoadGroupHandle				takes hashtable table, integer parentKey, integer childKey returns group
native  LoadLocationHandle			takes hashtable table, integer parentKey, integer childKey returns location
native  LoadRectHandle				takes hashtable table, integer parentKey, integer childKey returns rect
native  LoadBooleanExprHandle		takes hashtable table, integer parentKey, integer childKey returns boolexpr
native  LoadSoundHandle				takes hashtable table, integer parentKey, integer childKey returns sound
native  LoadEffectHandle			takes hashtable table, integer parentKey, integer childKey returns effect
native  LoadUnitPoolHandle			takes hashtable table, integer parentKey, integer childKey returns unitpool
native  LoadItemPoolHandle			takes hashtable table, integer parentKey, integer childKey returns itempool
native  LoadQuestHandle				takes hashtable table, integer parentKey, integer childKey returns quest
native  LoadQuestItemHandle			takes hashtable table, integer parentKey, integer childKey returns questitem
native  LoadDefeatConditionHandle	takes hashtable table, integer parentKey, integer childKey returns defeatcondition
native  LoadTimerDialogHandle		takes hashtable table, integer parentKey, integer childKey returns timerdialog
native  LoadLeaderboardHandle		takes hashtable table, integer parentKey, integer childKey returns leaderboard
native  LoadMultiboardHandle		takes hashtable table, integer parentKey, integer childKey returns multiboard
native  LoadMultiboardItemHandle	takes hashtable table, integer parentKey, integer childKey returns multiboarditem
native  LoadTrackableHandle			takes hashtable table, integer parentKey, integer childKey returns trackable
native  LoadDialogHandle			takes hashtable table, integer parentKey, integer childKey returns dialog
native  LoadButtonHandle			takes hashtable table, integer parentKey, integer childKey returns button
native  LoadTextTagHandle			takes hashtable table, integer parentKey, integer childKey returns texttag
native  LoadLightningHandle			takes hashtable table, integer parentKey, integer childKey returns lightning
native  LoadImageHandle				takes hashtable table, integer parentKey, integer childKey returns image
native  LoadUbersplatHandle			takes hashtable table, integer parentKey, integer childKey returns ubersplat
native  LoadRegionHandle			takes hashtable table, integer parentKey, integer childKey returns region
native  LoadFogStateHandle			takes hashtable table, integer parentKey, integer childKey returns fogstate
native  LoadFogModifierHandle		takes hashtable table, integer parentKey, integer childKey returns fogmodifier
native  LoadHashtableHandle			takes hashtable table, integer parentKey, integer childKey returns hashtable
native  LoadFrameHandle				takes hashtable table, integer parentKey, integer childKey returns framehandle

native  HaveSavedInteger					takes hashtable table, integer parentKey, integer childKey returns boolean
native  HaveSavedReal						takes hashtable table, integer parentKey, integer childKey returns boolean
native  HaveSavedBoolean					takes hashtable table, integer parentKey, integer childKey returns boolean
native  HaveSavedString					    takes hashtable table, integer parentKey, integer childKey returns boolean
native  HaveSavedHandle     				takes hashtable table, integer parentKey, integer childKey returns boolean

native  RemoveSavedInteger					takes hashtable table, integer parentKey, integer childKey returns nothing
native  RemoveSavedReal						takes hashtable table, integer parentKey, integer childKey returns nothing
native  RemoveSavedBoolean					takes hashtable table, integer parentKey, integer childKey returns nothing
native  RemoveSavedString					takes hashtable table, integer parentKey, integer childKey returns nothing
native  RemoveSavedHandle					takes hashtable table, integer parentKey, integer childKey returns nothing

native  FlushParentHashtable						takes hashtable table returns nothing
native  FlushChildHashtable					takes hashtable table, integer parentKey returns nothing


//============================================================================
// Randomization API
native GetRandomInt takes integer lowBound, integer highBound returns integer
native GetRandomReal takes real lowBound, real highBound returns real

native CreateUnitPool           takes nothing returns unitpool
native DestroyUnitPool          takes unitpool whichPool returns nothing
native UnitPoolAddUnitType      takes unitpool whichPool, integer unitId, real weight returns nothing
native UnitPoolRemoveUnitType   takes unitpool whichPool, integer unitId returns nothing
native PlaceRandomUnit          takes unitpool whichPool, player forWhichPlayer, real x, real y, real facing returns unit

native CreateItemPool           takes nothing returns itempool
native DestroyItemPool          takes itempool whichItemPool returns nothing
native ItemPoolAddItemType      takes itempool whichItemPool, integer itemId, real weight returns nothing
native ItemPoolRemoveItemType   takes itempool whichItemPool, integer itemId returns nothing
native PlaceRandomItem          takes itempool whichItemPool, real x, real y returns item

// Choose any random unit/item. (NP means Neutral Passive)
native ChooseRandomCreep        takes integer level returns integer
native ChooseRandomNPBuilding   takes nothing returns integer
native ChooseRandomItem         takes integer level returns integer
native ChooseRandomItemEx       takes itemtype whichType, integer level returns integer
native SetRandomSeed            takes integer seed returns nothing

//============================================================================
// Visual API
native SetTerrainFog                takes real a, real b, real c, real d, real e returns nothing
native ResetTerrainFog              takes nothing returns nothing

native SetUnitFog                   takes real a, real b, real c, real d, real e returns nothing
native SetTerrainFogEx              takes integer style, real zstart, real zend, real density, real red, real green, real blue returns nothing
native DisplayTextToPlayer          takes player toPlayer, real x, real y, string message returns nothing
native DisplayTimedTextToPlayer     takes player toPlayer, real x, real y, real duration, string message returns nothing
native DisplayTimedTextFromPlayer   takes player toPlayer, real x, real y, real duration, string message returns nothing
native ClearTextMessages            takes nothing returns nothing
native SetDayNightModels            takes string terrainDNCFile, string unitDNCFile returns nothing
native SetPortraitLight             takes string portraitDNCFile returns nothing
native SetSkyModel                  takes string skyModelFile returns nothing
native EnableUserControl            takes boolean b returns nothing
native EnableUserUI                 takes boolean b returns nothing
native SuspendTimeOfDay             takes boolean b returns nothing
native SetTimeOfDayScale            takes real r returns nothing
native GetTimeOfDayScale            takes nothing returns real
native ShowInterface                takes boolean flag, real fadeDuration returns nothing
native PauseGame                    takes boolean flag returns nothing
native UnitAddIndicator             takes unit whichUnit, integer red, integer green, integer blue, integer alpha returns nothing
native AddIndicator                 takes widget whichWidget, integer red, integer green, integer blue, integer alpha returns nothing
native PingMinimap                  takes real x, real y, real duration returns nothing
native PingMinimapEx                takes real x, real y, real duration, integer red, integer green, integer blue, boolean extraEffects returns nothing
native CreateMinimapIconOnUnit      takes unit whichUnit, integer red, integer green, integer blue, string pingPath, fogstate fogVisibility returns minimapicon
native CreateMinimapIconAtLoc       takes location where, integer red, integer green, integer blue, string pingPath, fogstate fogVisibility returns minimapicon
native CreateMinimapIcon            takes real x, real y, integer red, integer green, integer blue, string pingPath, fogstate fogVisibility returns minimapicon
native SkinManagerGetLocalPath      takes string key returns string
native DestroyMinimapIcon           takes minimapicon pingId returns nothing
native SetMinimapIconVisible        takes minimapicon whichMinimapIcon, boolean visible returns nothing
native SetMinimapIconOrphanDestroy  takes minimapicon whichMinimapIcon, boolean doDestroy returns nothing
native EnableOcclusion              takes boolean flag returns nothing
native SetIntroShotText             takes string introText returns nothing
native SetIntroShotModel            takes string introModelPath returns nothing
native EnableWorldFogBoundary       takes boolean b returns nothing
native PlayModelCinematic           takes string modelName returns nothing
native PlayCinematic                takes string movieName returns nothing
native ForceUIKey                   takes string key returns nothing
native ForceUICancel                takes nothing returns nothing
native DisplayLoadDialog            takes nothing returns nothing
native SetAltMinimapIcon            takes string iconPath returns nothing
native DisableRestartMission        takes boolean flag returns nothing

native CreateTextTag                takes nothing returns texttag
native DestroyTextTag               takes texttag t returns nothing
native SetTextTagText               takes texttag t, string s, real height returns nothing
native SetTextTagPos                takes texttag t, real x, real y, real heightOffset returns nothing
native SetTextTagPosUnit            takes texttag t, unit whichUnit, real heightOffset returns nothing
native SetTextTagColor              takes texttag t, integer red, integer green, integer blue, integer alpha returns nothing
native SetTextTagVelocity           takes texttag t, real xvel, real yvel returns nothing
native SetTextTagVisibility         takes texttag t, boolean flag returns nothing
native SetTextTagSuspended          takes texttag t, boolean flag returns nothing
native SetTextTagPermanent          takes texttag t, boolean flag returns nothing
native SetTextTagAge                takes texttag t, real age returns nothing
native SetTextTagLifespan           takes texttag t, real lifespan returns nothing
native SetTextTagFadepoint          takes texttag t, real fadepoint returns nothing

native SetReservedLocalHeroButtons  takes integer reserved returns nothing
native GetAllyColorFilterState      takes nothing returns integer
native SetAllyColorFilterState      takes integer state returns nothing
native GetCreepCampFilterState      takes nothing returns boolean
native SetCreepCampFilterState      takes boolean state returns nothing
native EnableMinimapFilterButtons   takes boolean enableAlly, boolean enableCreep returns nothing
native EnableDragSelect             takes boolean state, boolean ui returns nothing
native EnablePreSelect              takes boolean state, boolean ui returns nothing
native EnableSelect                 takes boolean state, boolean ui returns nothing

//============================================================================
// Trackable API
native CreateTrackable      takes string trackableModelPath, real x, real y, real facing returns trackable

//============================================================================
// Quest API
native CreateQuest          takes nothing returns quest
native DestroyQuest         takes quest whichQuest returns nothing
native QuestSetTitle        takes quest whichQuest, string title returns nothing
native QuestSetDescription  takes quest whichQuest, string description returns nothing
native QuestSetIconPath     takes quest whichQuest, string iconPath returns nothing

native QuestSetRequired     takes quest whichQuest, boolean required   returns nothing
native QuestSetCompleted    takes quest whichQuest, boolean completed  returns nothing
native QuestSetDiscovered   takes quest whichQuest, boolean discovered returns nothing
native QuestSetFailed       takes quest whichQuest, boolean failed     returns nothing
native QuestSetEnabled      takes quest whichQuest, boolean enabled    returns nothing

native IsQuestRequired     takes quest whichQuest returns boolean
native IsQuestCompleted    takes quest whichQuest returns boolean
native IsQuestDiscovered   takes quest whichQuest returns boolean
native IsQuestFailed       takes quest whichQuest returns boolean
native IsQuestEnabled      takes quest whichQuest returns boolean

native QuestCreateItem          takes quest whichQuest returns questitem
native QuestItemSetDescription  takes questitem whichQuestItem, string description returns nothing
native QuestItemSetCompleted    takes questitem whichQuestItem, boolean completed returns nothing

native IsQuestItemCompleted     takes questitem whichQuestItem returns boolean

native CreateDefeatCondition            takes nothing returns defeatcondition
native DestroyDefeatCondition           takes defeatcondition whichCondition returns nothing
native DefeatConditionSetDescription    takes defeatcondition whichCondition, string description returns nothing

native FlashQuestDialogButton   takes nothing returns nothing
native ForceQuestDialogUpdate   takes nothing returns nothing

//============================================================================
// Timer Dialog API
native CreateTimerDialog                takes timer t returns timerdialog
native DestroyTimerDialog               takes timerdialog whichDialog returns nothing
native TimerDialogSetTitle              takes timerdialog whichDialog, string title returns nothing
native TimerDialogSetTitleColor         takes timerdialog whichDialog, integer red, integer green, integer blue, integer alpha returns nothing
native TimerDialogSetTimeColor          takes timerdialog whichDialog, integer red, integer green, integer blue, integer alpha returns nothing
native TimerDialogSetSpeed              takes timerdialog whichDialog, real speedMultFactor returns nothing
native TimerDialogDisplay               takes timerdialog whichDialog, boolean display returns nothing
native IsTimerDialogDisplayed           takes timerdialog whichDialog returns boolean
native TimerDialogSetRealTimeRemaining  takes timerdialog whichDialog, real timeRemaining returns nothing

//============================================================================
// Leaderboard API

// Create a leaderboard object
native CreateLeaderboard                takes nothing returns leaderboard
native DestroyLeaderboard               takes leaderboard lb returns nothing

native LeaderboardDisplay               takes leaderboard lb, boolean show returns nothing
native IsLeaderboardDisplayed           takes leaderboard lb returns boolean

native LeaderboardGetItemCount          takes leaderboard lb returns integer

native LeaderboardSetSizeByItemCount    takes leaderboard lb, integer count returns nothing
native LeaderboardAddItem               takes leaderboard lb, string label, integer value, player p returns nothing
native LeaderboardRemoveItem            takes leaderboard lb, integer index returns nothing
native LeaderboardRemovePlayerItem      takes leaderboard lb, player p returns nothing
native LeaderboardClear                 takes leaderboard lb returns nothing

native LeaderboardSortItemsByValue      takes leaderboard lb, boolean ascending returns nothing
native LeaderboardSortItemsByPlayer     takes leaderboard lb, boolean ascending returns nothing
native LeaderboardSortItemsByLabel      takes leaderboard lb, boolean ascending returns nothing

native LeaderboardHasPlayerItem         takes leaderboard lb, player p returns boolean
native LeaderboardGetPlayerIndex        takes leaderboard lb, player p returns integer
native LeaderboardSetLabel              takes leaderboard lb, string label returns nothing
native LeaderboardGetLabelText          takes leaderboard lb returns string

native PlayerSetLeaderboard             takes player toPlayer, leaderboard lb returns nothing
native PlayerGetLeaderboard             takes player toPlayer returns leaderboard

native LeaderboardSetLabelColor         takes leaderboard lb, integer red, integer green, integer blue, integer alpha returns nothing
native LeaderboardSetValueColor         takes leaderboard lb, integer red, integer green, integer blue, integer alpha returns nothing
native LeaderboardSetStyle              takes leaderboard lb, boolean showLabel, boolean showNames, boolean showValues, boolean showIcons returns nothing

native LeaderboardSetItemValue          takes leaderboard lb, integer whichItem, integer val returns nothing
native LeaderboardSetItemLabel          takes leaderboard lb, integer whichItem, string val returns nothing
native LeaderboardSetItemStyle          takes leaderboard lb, integer whichItem, boolean showLabel, boolean showValue, boolean showIcon returns nothing
native LeaderboardSetItemLabelColor     takes leaderboard lb, integer whichItem, integer red, integer green, integer blue, integer alpha returns nothing
native LeaderboardSetItemValueColor     takes leaderboard lb, integer whichItem, integer red, integer green, integer blue, integer alpha returns nothing

//============================================================================
// Multiboard API
//============================================================================

// Create a multiboard object
native CreateMultiboard                 takes nothing returns multiboard
native DestroyMultiboard                takes multiboard lb returns nothing

native MultiboardDisplay                takes multiboard lb, boolean show returns nothing
native IsMultiboardDisplayed            takes multiboard lb returns boolean

native MultiboardMinimize               takes multiboard lb, boolean minimize returns nothing
native IsMultiboardMinimized            takes multiboard lb returns boolean
native MultiboardClear                  takes multiboard lb returns nothing

native MultiboardSetTitleText           takes multiboard lb, string label returns nothing
native MultiboardGetTitleText           takes multiboard lb returns string
native MultiboardSetTitleTextColor      takes multiboard lb, integer red, integer green, integer blue, integer alpha returns nothing

native MultiboardGetRowCount            takes multiboard lb returns integer
native MultiboardGetColumnCount         takes multiboard lb returns integer

native MultiboardSetColumnCount         takes multiboard lb, integer count returns nothing
native MultiboardSetRowCount            takes multiboard lb, integer count returns nothing

// broadcast settings to all items
native MultiboardSetItemsStyle          takes multiboard lb, boolean showValues, boolean showIcons returns nothing
native MultiboardSetItemsValue          takes multiboard lb, string value returns nothing
native MultiboardSetItemsValueColor     takes multiboard lb, integer red, integer green, integer blue, integer alpha returns nothing
native MultiboardSetItemsWidth          takes multiboard lb, real width returns nothing
native MultiboardSetItemsIcon           takes multiboard lb, string iconPath returns nothing


// funcs for modifying individual items
native MultiboardGetItem                takes multiboard lb, integer row, integer column returns multiboarditem
native MultiboardReleaseItem            takes multiboarditem mbi returns nothing

native MultiboardSetItemStyle           takes multiboarditem mbi, boolean showValue, boolean showIcon returns nothing
native MultiboardSetItemValue           takes multiboarditem mbi, string val returns nothing
native MultiboardSetItemValueColor      takes multiboarditem mbi, integer red, integer green, integer blue, integer alpha returns nothing
native MultiboardSetItemWidth           takes multiboarditem mbi, real width returns nothing
native MultiboardSetItemIcon            takes multiboarditem mbi, string iconFileName returns nothing

// meant to unequivocally suspend display of existing and
// subsequently displayed multiboards
//
native MultiboardSuppressDisplay        takes boolean flag returns nothing

//============================================================================
// Camera API
native SetCameraPosition            takes real x, real y returns nothing
native SetCameraQuickPosition       takes real x, real y returns nothing
native SetCameraBounds              takes real x1, real y1, real x2, real y2, real x3, real y3, real x4, real y4 returns nothing
native StopCamera                   takes nothing returns nothing
native ResetToGameCamera            takes real duration returns nothing
native PanCameraTo                  takes real x, real y returns nothing
native PanCameraToTimed             takes real x, real y, real duration returns nothing
native PanCameraToWithZ             takes real x, real y, real zOffsetDest returns nothing
native PanCameraToTimedWithZ        takes real x, real y, real zOffsetDest, real duration returns nothing
native SetCinematicCamera           takes string cameraModelFile returns nothing
native SetCameraRotateMode          takes real x, real y, real radiansToSweep, real duration returns nothing
native SetCameraField               takes camerafield whichField, real value, real duration returns nothing
native AdjustCameraField            takes camerafield whichField, real offset, real duration returns nothing
native SetCameraTargetController    takes unit whichUnit, real xoffset, real yoffset, boolean inheritOrientation returns nothing
native SetCameraOrientController    takes unit whichUnit, real xoffset, real yoffset returns nothing

native CreateCameraSetup                    takes nothing returns camerasetup
native CameraSetupSetField                  takes camerasetup whichSetup, camerafield whichField, real value, real duration returns nothing
native CameraSetupGetField                  takes camerasetup whichSetup, camerafield whichField returns real
native CameraSetupSetDestPosition           takes camerasetup whichSetup, real x, real y, real duration returns nothing
native CameraSetupGetDestPositionLoc        takes camerasetup whichSetup returns location
native CameraSetupGetDestPositionX          takes camerasetup whichSetup returns real
native CameraSetupGetDestPositionY          takes camerasetup whichSetup returns real
native CameraSetupApply                     takes camerasetup whichSetup, boolean doPan, boolean panTimed returns nothing
native CameraSetupApplyWithZ                takes camerasetup whichSetup, real zDestOffset returns nothing
native CameraSetupApplyForceDuration        takes camerasetup whichSetup, boolean doPan, real forceDuration returns nothing
native CameraSetupApplyForceDurationWithZ   takes camerasetup whichSetup, real zDestOffset, real forceDuration returns nothing
native BlzCameraSetupSetLabel               takes camerasetup whichSetup, string label returns nothing
native BlzCameraSetupGetLabel               takes camerasetup whichSetup returns string

native CameraSetTargetNoise             takes real mag, real velocity returns nothing
native CameraSetSourceNoise             takes real mag, real velocity returns nothing

native CameraSetTargetNoiseEx           takes real mag, real velocity, boolean vertOnly returns nothing
native CameraSetSourceNoiseEx           takes real mag, real velocity, boolean vertOnly returns nothing

native CameraSetSmoothingFactor         takes real factor returns nothing

native CameraSetFocalDistance			takes real distance returns nothing
native CameraSetDepthOfFieldScale       takes real scale returns nothing

native SetCineFilterTexture             takes string filename returns nothing
native SetCineFilterBlendMode           takes blendmode whichMode returns nothing
native SetCineFilterTexMapFlags         takes texmapflags whichFlags returns nothing
native SetCineFilterStartUV             takes real minu, real minv, real maxu, real maxv returns nothing
native SetCineFilterEndUV               takes real minu, real minv, real maxu, real maxv returns nothing
native SetCineFilterStartColor          takes integer red, integer green, integer blue, integer alpha returns nothing
native SetCineFilterEndColor            takes integer red, integer green, integer blue, integer alpha returns nothing
native SetCineFilterDuration            takes real duration returns nothing
native DisplayCineFilter                takes boolean flag returns nothing
native IsCineFilterDisplayed            takes nothing returns boolean

native SetCinematicScene                takes integer portraitUnitId, playercolor color, string speakerTitle, string text, real sceneDuration, real voiceoverDuration returns nothing
native EndCinematicScene                takes nothing returns nothing
native ForceCinematicSubtitles          takes boolean flag returns nothing
native SetCinematicAudio                takes boolean cinematicAudio returns nothing

native GetCameraMargin                  takes integer whichMargin returns real

// These return values for the local players camera only...
constant native GetCameraBoundMinX          takes nothing returns real
constant native GetCameraBoundMinY          takes nothing returns real
constant native GetCameraBoundMaxX          takes nothing returns real
constant native GetCameraBoundMaxY          takes nothing returns real
constant native GetCameraField              takes camerafield whichField returns real
constant native GetCameraTargetPositionX    takes nothing returns real
constant native GetCameraTargetPositionY    takes nothing returns real
constant native GetCameraTargetPositionZ    takes nothing returns real
constant native GetCameraTargetPositionLoc  takes nothing returns location
constant native GetCameraEyePositionX       takes nothing returns real
constant native GetCameraEyePositionY       takes nothing returns real
constant native GetCameraEyePositionZ       takes nothing returns real
constant native GetCameraEyePositionLoc     takes nothing returns location

//============================================================================
// Sound API
//
native NewSoundEnvironment          takes string environmentName returns nothing

native CreateSound                  takes string fileName, boolean looping, boolean is3D, boolean stopwhenoutofrange, integer fadeInRate, integer fadeOutRate, string eaxSetting returns sound
native CreateSoundFilenameWithLabel takes string fileName, boolean looping, boolean is3D, boolean stopwhenoutofrange, integer fadeInRate, integer fadeOutRate, string SLKEntryName returns sound
native CreateSoundFromLabel         takes string soundLabel, boolean looping, boolean is3D, boolean stopwhenoutofrange, integer fadeInRate, integer fadeOutRate returns sound
native CreateMIDISound              takes string soundLabel, integer fadeInRate, integer fadeOutRate returns sound

native SetSoundParamsFromLabel      takes sound soundHandle, string soundLabel returns nothing
native SetSoundDistanceCutoff       takes sound soundHandle, real cutoff returns nothing
native SetSoundChannel              takes sound soundHandle, integer channel returns nothing
native SetSoundVolume               takes sound soundHandle, integer volume returns nothing
native SetSoundPitch                takes sound soundHandle, real pitch returns nothing

// the following method must be called immediately after calling "StartSound"
native SetSoundPlayPosition         takes sound soundHandle, integer millisecs returns nothing

// these calls are only valid if the sound was created with 3d enabled
native SetSoundDistances            takes sound soundHandle, real minDist, real maxDist returns nothing
native SetSoundConeAngles           takes sound soundHandle, real inside, real outside, integer outsideVolume returns nothing
native SetSoundConeOrientation      takes sound soundHandle, real x, real y, real z returns nothing
native SetSoundPosition             takes sound soundHandle, real x, real y, real z returns nothing
native SetSoundVelocity             takes sound soundHandle, real x, real y, real z returns nothing
native AttachSoundToUnit            takes sound soundHandle, unit whichUnit returns nothing

native StartSound                   takes sound soundHandle returns nothing
native StartSoundEx                 takes sound soundHandle, boolean fadeIn returns nothing
native StopSound                    takes sound soundHandle, boolean killWhenDone, boolean fadeOut returns nothing
native KillSoundWhenDone            takes sound soundHandle returns nothing

// Music Interface. Note that if music is disabled, these calls do nothing
native SetMapMusic                  takes string musicName, boolean random, integer index returns nothing
native ClearMapMusic                takes nothing returns nothing

native PlayMusic                    takes string musicName returns nothing
native PlayMusicEx                  takes string musicName, integer frommsecs, integer fadeinmsecs returns nothing
native StopMusic                    takes boolean fadeOut returns nothing
native ResumeMusic                  takes nothing returns nothing

native PlayThematicMusic            takes string musicFileName returns nothing
native PlayThematicMusicEx          takes string musicFileName, integer frommsecs returns nothing
native EndThematicMusic             takes nothing returns nothing

native SetMusicVolume               takes integer volume returns nothing
native SetMusicPlayPosition         takes integer millisecs returns nothing
native SetThematicMusicVolume       takes integer volume returns nothing
native SetThematicMusicPlayPosition takes integer millisecs returns nothing

// other music and sound calls
native SetSoundDuration             takes sound soundHandle, integer duration returns nothing
native GetSoundDuration             takes sound soundHandle returns integer
native GetSoundFileDuration         takes string musicFileName returns integer

native VolumeGroupSetVolume         takes volumegroup vgroup, real scale returns nothing
native VolumeGroupReset             takes nothing returns nothing

native GetSoundIsPlaying            takes sound soundHandle returns boolean
native GetSoundIsLoading            takes sound soundHandle returns boolean

native RegisterStackedSound         takes sound soundHandle, boolean byPosition, real rectwidth, real rectheight returns nothing
native UnregisterStackedSound       takes sound soundHandle, boolean byPosition, real rectwidth, real rectheight returns nothing

native SetSoundFacialAnimationLabel takes sound soundHandle, string animationLabel returns boolean
native SetSoundFacialAnimationGroupLabel takes sound soundHandle, string groupLabel returns boolean
native SetSoundFacialAnimationSetFilepath takes sound soundHandle, string animationSetFilepath returns boolean

//Subtitle support that is attached to the soundHandle rather than as disperate data with the legacy UI
native SetDialogueSpeakerNameKey    takes sound soundHandle, string speakerName returns boolean
native GetDialogueSpeakerNameKey    takes sound soundHandle returns string
native SetDialogueTextKey           takes sound soundHandle, string dialogueText returns boolean
native GetDialogueTextKey           takes sound soundHandle returns string

//============================================================================
// Effects API
//
native AddWeatherEffect             takes rect where, integer effectID returns weathereffect
native RemoveWeatherEffect          takes weathereffect whichEffect returns nothing
native EnableWeatherEffect          takes weathereffect whichEffect, boolean enable returns nothing

native TerrainDeformCrater          takes real x, real y, real radius, real depth, integer duration, boolean permanent returns terraindeformation
native TerrainDeformRipple          takes real x, real y, real radius, real depth, integer duration, integer count, real spaceWaves, real timeWaves, real radiusStartPct, boolean limitNeg returns terraindeformation
native TerrainDeformWave            takes real x, real y, real dirX, real dirY, real distance, real speed, real radius, real depth, integer trailTime, integer count returns terraindeformation
native TerrainDeformRandom          takes real x, real y, real radius, real minDelta, real maxDelta, integer duration, integer updateInterval returns terraindeformation
native TerrainDeformStop            takes terraindeformation deformation, integer duration returns nothing
native TerrainDeformStopAll         takes nothing returns nothing

native AddSpecialEffect             takes string modelName, real x, real y returns effect
native AddSpecialEffectLoc          takes string modelName, location where returns effect
native AddSpecialEffectTarget       takes string modelName, widget targetWidget, string attachPointName returns effect
native DestroyEffect                takes effect whichEffect returns nothing

native AddSpellEffect               takes string abilityString, effecttype t, real x, real y returns effect
native AddSpellEffectLoc            takes string abilityString, effecttype t,location where returns effect
native AddSpellEffectById           takes integer abilityId, effecttype t,real x, real y returns effect
native AddSpellEffectByIdLoc        takes integer abilityId, effecttype t,location where returns effect
native AddSpellEffectTarget         takes string modelName, effecttype t, widget targetWidget, string attachPoint returns effect
native AddSpellEffectTargetById     takes integer abilityId, effecttype t, widget targetWidget, string attachPoint returns effect

native AddLightning                 takes string codeName, boolean checkVisibility, real x1, real y1, real x2, real y2 returns lightning
native AddLightningEx               takes string codeName, boolean checkVisibility, real x1, real y1, real z1, real x2, real y2, real z2 returns lightning
native DestroyLightning             takes lightning whichBolt returns boolean
native MoveLightning                takes lightning whichBolt, boolean checkVisibility, real x1, real y1, real x2, real y2 returns boolean
native MoveLightningEx              takes lightning whichBolt, boolean checkVisibility, real x1, real y1, real z1, real x2, real y2, real z2 returns boolean
native GetLightningColorA           takes lightning whichBolt returns real
native GetLightningColorR           takes lightning whichBolt returns real
native GetLightningColorG           takes lightning whichBolt returns real
native GetLightningColorB           takes lightning whichBolt returns real
native SetLightningColor            takes lightning whichBolt, real r, real g, real b, real a returns boolean

native GetAbilityEffect             takes string abilityString, effecttype t, integer index returns string
native GetAbilityEffectById         takes integer abilityId, effecttype t, integer index returns string
native GetAbilitySound              takes string abilityString, soundtype t returns string
native GetAbilitySoundById          takes integer abilityId, soundtype t returns string

//============================================================================
// Terrain API
//
native GetTerrainCliffLevel         takes real x, real y returns integer
native SetWaterBaseColor            takes integer red, integer green, integer blue, integer alpha returns nothing
native SetWaterDeforms              takes boolean val returns nothing
native GetTerrainType               takes real x, real y returns integer
native GetTerrainVariance           takes real x, real y returns integer
native SetTerrainType               takes real x, real y, integer terrainType, integer variation, integer area, integer shape returns nothing
native IsTerrainPathable            takes real x, real y, pathingtype t returns boolean
native SetTerrainPathable           takes real x, real y, pathingtype t, boolean flag returns nothing

//============================================================================
// Image API
//
native CreateImage                  takes string file, real sizeX, real sizeY, real sizeZ, real posX, real posY, real posZ, real originX, real originY, real originZ, integer imageType returns image
native DestroyImage                 takes image whichImage returns nothing
native ShowImage                    takes image whichImage, boolean flag returns nothing
native SetImageConstantHeight       takes image whichImage, boolean flag, real height returns nothing
native SetImagePosition             takes image whichImage, real x, real y, real z returns nothing
native SetImageColor                takes image whichImage, integer red, integer green, integer blue, integer alpha returns nothing
native SetImageRender               takes image whichImage, boolean flag returns nothing
native SetImageRenderAlways         takes image whichImage, boolean flag returns nothing
native SetImageAboveWater           takes image whichImage, boolean flag, boolean useWaterAlpha returns nothing
native SetImageType                 takes image whichImage, integer imageType returns nothing

//============================================================================
// Ubersplat API
//
native CreateUbersplat              takes real x, real y, string name, integer red, integer green, integer blue, integer alpha, boolean forcePaused, boolean noBirthTime returns ubersplat
native DestroyUbersplat             takes ubersplat whichSplat returns nothing
native ResetUbersplat               takes ubersplat whichSplat returns nothing
native FinishUbersplat              takes ubersplat whichSplat returns nothing
native ShowUbersplat                takes ubersplat whichSplat, boolean flag returns nothing
native SetUbersplatRender           takes ubersplat whichSplat, boolean flag returns nothing
native SetUbersplatRenderAlways     takes ubersplat whichSplat, boolean flag returns nothing

//============================================================================
// Blight API
//
native SetBlight                takes player whichPlayer, real x, real y, real radius, boolean addBlight returns nothing
native SetBlightRect            takes player whichPlayer, rect r, boolean addBlight returns nothing
native SetBlightPoint           takes player whichPlayer, real x, real y, boolean addBlight returns nothing
native SetBlightLoc             takes player whichPlayer, location whichLocation, real radius, boolean addBlight returns nothing
native CreateBlightedGoldmine   takes player id, real x, real y, real face returns unit
native IsPointBlighted          takes real x, real y returns boolean

//============================================================================
// Doodad API
//
native SetDoodadAnimation       takes real x, real y, real radius, integer doodadID, boolean nearestOnly, string animName, boolean animRandom returns nothing
native SetDoodadAnimationRect   takes rect r, integer doodadID, string animName, boolean animRandom returns nothing

//============================================================================
// Computer AI interface
//
native StartMeleeAI         takes player num, string script                 returns nothing
native StartCampaignAI      takes player num, string script                 returns nothing
native CommandAI            takes player num, integer command, integer data returns nothing
native PauseCompAI          takes player p,   boolean pause                 returns nothing
native GetAIDifficulty      takes player num                                returns aidifficulty

native RemoveGuardPosition  takes unit hUnit                                returns nothing
native RecycleGuardPosition takes unit hUnit                                returns nothing
native RemoveAllGuardPositions takes player num                             returns nothing

//============================================================================
native Cheat            takes string cheatStr returns nothing
native IsNoVictoryCheat takes nothing returns boolean
native IsNoDefeatCheat  takes nothing returns boolean

native Preload          takes string filename returns nothing
native PreloadEnd       takes real timeout returns nothing

native PreloadStart     takes nothing returns nothing
native PreloadRefresh   takes nothing returns nothing
native PreloadEndEx     takes nothing returns nothing

native PreloadGenClear  takes nothing returns nothing
native PreloadGenStart  takes nothing returns nothing
native PreloadGenEnd    takes string filename returns nothing
native Preloader        takes string filename returns nothing


//============================================================================
//Machinima API
//============================================================================
native BlzHideCinematicPanels                     takes boolean enable returns nothing


// Automation Test
native AutomationSetTestType                    takes string testType returns nothing
native AutomationTestStart                      takes string testName returns nothing
native AutomationTestEnd                        takes nothing returns nothing
native AutomationTestingFinished                takes nothing returns nothing

// JAPI Functions
native BlzGetTriggerPlayerMouseX                   takes nothing returns real
native BlzGetTriggerPlayerMouseY                   takes nothing returns real
native BlzGetTriggerPlayerMousePosition            takes nothing returns location
native BlzGetTriggerPlayerMouseButton              takes nothing returns mousebuttontype
native BlzSetAbilityTooltip                        takes integer abilCode, string tooltip, integer level returns nothing
native BlzSetAbilityActivatedTooltip               takes integer abilCode, string tooltip, integer level returns nothing
native BlzSetAbilityExtendedTooltip                takes integer abilCode, string extendedTooltip, integer level returns nothing
native BlzSetAbilityActivatedExtendedTooltip       takes integer abilCode, string extendedTooltip, integer level returns nothing
native BlzSetAbilityResearchTooltip                takes integer abilCode, string researchTooltip, integer level returns nothing
native BlzSetAbilityResearchExtendedTooltip        takes integer abilCode, string researchExtendedTooltip, integer level returns nothing
native BlzGetAbilityTooltip                        takes integer abilCode, integer level returns string
native BlzGetAbilityActivatedTooltip               takes integer abilCode, integer level returns string
native BlzGetAbilityExtendedTooltip                takes integer abilCode, integer level returns string
native BlzGetAbilityActivatedExtendedTooltip       takes integer abilCode, integer level returns string
native BlzGetAbilityResearchTooltip                takes integer abilCode, integer level returns string
native BlzGetAbilityResearchExtendedTooltip        takes integer abilCode, integer level returns string
native BlzSetAbilityIcon                           takes integer abilCode, string iconPath returns nothing
native BlzGetAbilityIcon                           takes integer abilCode returns string
native BlzSetAbilityActivatedIcon                  takes integer abilCode, string iconPath returns nothing
native BlzGetAbilityActivatedIcon                  takes integer abilCode returns string
native BlzGetAbilityPosX                           takes integer abilCode returns integer
native BlzGetAbilityPosY                           takes integer abilCode returns integer
native BlzSetAbilityPosX                           takes integer abilCode, integer x returns nothing
native BlzSetAbilityPosY                           takes integer abilCode, integer y returns nothing
native BlzGetAbilityActivatedPosX                  takes integer abilCode returns integer
native BlzGetAbilityActivatedPosY                  takes integer abilCode returns integer
native BlzSetAbilityActivatedPosX                  takes integer abilCode, integer x returns nothing
native BlzSetAbilityActivatedPosY                  takes integer abilCode, integer y returns nothing
native BlzGetUnitMaxHP                             takes unit whichUnit returns integer
native BlzSetUnitMaxHP                             takes unit whichUnit, integer hp returns nothing
native BlzGetUnitMaxMana                           takes unit whichUnit returns integer
native BlzSetUnitMaxMana                           takes unit whichUnit, integer mana returns nothing
native BlzSetItemName                              takes item whichItem, string name returns nothing
native BlzSetItemDescription                       takes item whichItem, string description returns nothing
native BlzGetItemDescription                       takes item whichItem returns string
native BlzSetItemTooltip                           takes item whichItem, string tooltip returns nothing
native BlzGetItemTooltip                           takes item whichItem returns string
native BlzSetItemExtendedTooltip                   takes item whichItem, string extendedTooltip returns nothing
native BlzGetItemExtendedTooltip                   takes item whichItem returns string
native BlzSetItemIconPath                          takes item whichItem, string iconPath returns nothing
native BlzGetItemIconPath                          takes item whichItem returns string
native BlzSetUnitName                              takes unit whichUnit, string name returns nothing
native BlzSetHeroProperName                        takes unit whichUnit, string heroProperName returns nothing
native BlzGetUnitBaseDamage                        takes unit whichUnit, integer weaponIndex returns integer
native BlzSetUnitBaseDamage                        takes unit whichUnit, integer baseDamage, integer weaponIndex returns nothing
native BlzGetUnitDiceNumber                        takes unit whichUnit, integer weaponIndex returns integer
native BlzSetUnitDiceNumber                        takes unit whichUnit, integer diceNumber, integer weaponIndex returns nothing
native BlzGetUnitDiceSides                         takes unit whichUnit, integer weaponIndex returns integer
native BlzSetUnitDiceSides                         takes unit whichUnit, integer diceSides, integer weaponIndex returns nothing
native BlzGetUnitAttackCooldown                    takes unit whichUnit, integer weaponIndex returns real
native BlzSetUnitAttackCooldown                    takes unit whichUnit, real cooldown, integer weaponIndex returns nothing
native BlzSetSpecialEffectColorByPlayer            takes effect whichEffect, player whichPlayer returns nothing
native BlzSetSpecialEffectColor                    takes effect whichEffect, integer r, integer g, integer b returns nothing
native BlzSetSpecialEffectAlpha                    takes effect whichEffect, integer alpha returns nothing
native BlzSetSpecialEffectScale                    takes effect whichEffect, real scale returns nothing
native BlzSetSpecialEffectPosition                 takes effect whichEffect, real x, real y, real z returns nothing
native BlzSetSpecialEffectHeight                   takes effect whichEffect, real height returns nothing
native BlzSetSpecialEffectTimeScale                takes effect whichEffect, real timeScale returns nothing
native BlzSetSpecialEffectTime                     takes effect whichEffect, real time returns nothing
native BlzSetSpecialEffectOrientation              takes effect whichEffect, real yaw, real pitch, real roll returns nothing
native BlzSetSpecialEffectYaw                      takes effect whichEffect, real yaw returns nothing
native BlzSetSpecialEffectPitch                    takes effect whichEffect, real pitch returns nothing
native BlzSetSpecialEffectRoll                     takes effect whichEffect, real roll returns nothing
native BlzSetSpecialEffectX                        takes effect whichEffect, real x returns nothing
native BlzSetSpecialEffectY                        takes effect whichEffect, real y returns nothing
native BlzSetSpecialEffectZ                        takes effect whichEffect, real z returns nothing
native BlzSetSpecialEffectPositionLoc              takes effect whichEffect, location loc returns nothing
native BlzGetLocalSpecialEffectX                   takes effect whichEffect returns real
native BlzGetLocalSpecialEffectY                   takes effect whichEffect returns real
native BlzGetLocalSpecialEffectZ                   takes effect whichEffect returns real
native BlzSpecialEffectClearSubAnimations          takes effect whichEffect returns nothing
native BlzSpecialEffectRemoveSubAnimation          takes effect whichEffect, subanimtype whichSubAnim returns nothing
native BlzSpecialEffectAddSubAnimation             takes effect whichEffect, subanimtype whichSubAnim returns nothing
native BlzPlaySpecialEffect                        takes effect whichEffect, animtype whichAnim returns nothing
native BlzPlaySpecialEffectWithTimeScale           takes effect whichEffect, animtype whichAnim, real timeScale returns nothing
native BlzGetAnimName                              takes animtype whichAnim returns string
native BlzGetUnitArmor                             takes unit whichUnit returns real
native BlzSetUnitArmor                             takes unit whichUnit, real armorAmount returns nothing
native BlzUnitHideAbility                          takes unit whichUnit, integer abilId, boolean flag returns nothing
native BlzUnitDisableAbility                       takes unit whichUnit, integer abilId, boolean flag, boolean hideUI returns nothing
native BlzUnitCancelTimedLife                      takes unit whichUnit returns nothing
native BlzIsUnitSelectable                         takes unit whichUnit returns boolean
native BlzIsUnitInvulnerable                       takes unit whichUnit returns boolean
native BlzUnitInterruptAttack                      takes unit whichUnit returns nothing
native BlzGetUnitCollisionSize                     takes unit whichUnit returns real
native BlzGetAbilityManaCost                       takes integer abilId, integer level returns integer
native BlzGetAbilityCooldown                       takes integer abilId, integer level returns real
native BlzSetUnitAbilityCooldown                   takes unit whichUnit, integer abilId, integer level, real cooldown returns nothing
native BlzGetUnitAbilityCooldown                   takes unit whichUnit, integer abilId, integer level returns real
native BlzGetUnitAbilityCooldownRemaining          takes unit whichUnit, integer abilId returns real
native BlzEndUnitAbilityCooldown                   takes unit whichUnit, integer abilCode returns nothing
native BlzStartUnitAbilityCooldown                 takes unit whichUnit, integer abilCode, real cooldown returns nothing
native BlzGetUnitAbilityManaCost                   takes unit whichUnit, integer abilId, integer level returns integer
native BlzSetUnitAbilityManaCost                   takes unit whichUnit, integer abilId, integer level, integer manaCost returns nothing
native BlzGetLocalUnitZ                            takes unit whichUnit returns real
native BlzDecPlayerTechResearched                  takes player whichPlayer, integer techid, integer levels returns nothing
native BlzSetEventDamage                           takes real damage returns nothing
native BlzGetEventDamageTarget 	                   takes nothing returns unit
native BlzGetEventAttackType  	                   takes nothing returns attacktype
native BlzGetEventDamageType                       takes nothing returns damagetype
native BlzGetEventWeaponType  	                   takes nothing returns weapontype
native BlzSetEventAttackType                       takes attacktype attackType returns boolean
native BlzSetEventDamageType                       takes damagetype damageType returns boolean
native BlzSetEventWeaponType                       takes weapontype weaponType returns boolean
native BlzGetEventIsAttack                         takes nothing returns boolean
native RequestExtraIntegerData                     takes integer dataType, player whichPlayer, string param1, string param2, boolean param3, integer param4, integer param5, integer param6 returns integer
native RequestExtraBooleanData                     takes integer dataType, player whichPlayer, string param1, string param2, boolean param3, integer param4, integer param5, integer param6 returns boolean
native RequestExtraStringData                      takes integer dataType, player whichPlayer, string param1, string param2, boolean param3, integer param4, integer param5, integer param6 returns string
native RequestExtraRealData                        takes integer dataType, player whichPlayer, string param1, string param2, boolean param3, integer param4, integer param5, integer param6 returns real
// Add this function to follow the style of GetUnitX and GetUnitY, it has the same result as BlzGetLocalUnitZ
native BlzGetUnitZ                                 takes unit whichUnit returns real
native BlzEnableSelections                         takes boolean enableSelection, boolean enableSelectionCircle returns nothing
native BlzIsSelectionEnabled                       takes nothing returns boolean
native BlzIsSelectionCircleEnabled                 takes nothing returns boolean
native BlzCameraSetupApplyForceDurationSmooth      takes camerasetup whichSetup, boolean doPan, real forcedDuration, real easeInDuration, real easeOutDuration, real smoothFactor returns nothing
native BlzEnableTargetIndicator                    takes boolean enable returns nothing
native BlzIsTargetIndicatorEnabled                 takes nothing returns boolean
native BlzShowTerrain                              takes boolean show returns nothing
native BlzShowSkyBox                               takes boolean show returns nothing
native BlzStartRecording                           takes integer fps returns nothing
native BlzEndRecording                             takes nothing returns nothing
native BlzShowUnitTeamGlow                         takes unit whichUnit, boolean show returns nothing

native BlzGetOriginFrame                           takes originframetype frameType, integer index returns framehandle
native BlzEnableUIAutoPosition                     takes boolean enable returns nothing
native BlzHideOriginFrames                         takes boolean enable returns nothing
native BlzConvertColor                             takes integer a, integer r, integer g, integer b returns integer
native BlzLoadTOCFile                              takes string TOCFile returns boolean
native BlzCreateFrame                              takes string name, framehandle owner, integer priority, integer createContext returns framehandle
native BlzCreateSimpleFrame                        takes string name, framehandle owner, integer createContext returns framehandle
native BlzCreateFrameByType                        takes string typeName, string name, framehandle owner, string inherits, integer createContext returns framehandle
native BlzDestroyFrame                             takes framehandle frame returns nothing
native BlzFrameSetPoint                            takes framehandle frame, framepointtype point, framehandle relative, framepointtype relativePoint, real x, real y returns nothing
native BlzFrameSetAbsPoint                         takes framehandle frame, framepointtype point, real x, real y returns nothing
native BlzFrameClearAllPoints                      takes framehandle frame returns nothing
native BlzFrameSetAllPoints                        takes framehandle frame, framehandle relative returns nothing
native BlzFrameSetVisible                          takes framehandle frame, boolean visible returns nothing
native BlzFrameIsVisible                           takes framehandle frame returns boolean
native BlzGetFrameByName                           takes string name, integer createContext returns framehandle
native BlzFrameGetName                             takes framehandle frame returns string
native BlzFrameClick                               takes framehandle frame returns nothing
native BlzFrameSetText                             takes framehandle frame, string text returns nothing
native BlzFrameGetText                             takes framehandle frame returns string
native BlzFrameAddText                             takes framehandle frame, string text returns nothing
native BlzFrameSetTextSizeLimit                    takes framehandle frame, integer size returns nothing
native BlzFrameGetTextSizeLimit                    takes framehandle frame returns integer
native BlzFrameSetTextColor                        takes framehandle frame, integer color returns nothing
native BlzFrameSetFocus                            takes framehandle frame, boolean flag returns nothing
native BlzFrameSetModel                            takes framehandle frame, string modelFile, integer cameraIndex returns nothing
native BlzFrameSetEnable                           takes framehandle frame, boolean enabled returns nothing
native BlzFrameGetEnable                           takes framehandle frame returns boolean
native BlzFrameSetAlpha                            takes framehandle frame, integer alpha returns nothing
native BlzFrameGetAlpha                            takes framehandle frame returns integer
native BlzFrameSetSpriteAnimate                    takes framehandle frame, integer primaryProp, integer flags returns nothing
native BlzFrameSetTexture                          takes framehandle frame, string texFile, integer flag, boolean blend returns nothing
native BlzFrameSetScale                            takes framehandle frame, real scale returns nothing
native BlzFrameSetTooltip                          takes framehandle frame, framehandle tooltip returns nothing
native BlzFrameCageMouse                           takes framehandle frame, boolean enable returns nothing
native BlzFrameSetValue                            takes framehandle frame, real value returns nothing
native BlzFrameGetValue                            takes framehandle frame returns real
native BlzFrameSetMinMaxValue                      takes framehandle frame, real minValue, real maxValue returns nothing
native BlzFrameSetStepSize                         takes framehandle frame, real stepSize returns nothing
native BlzFrameSetSize                             takes framehandle frame, real width, real height returns nothing
native BlzFrameSetVertexColor                      takes framehandle frame, integer color returns nothing
native BlzFrameSetLevel                            takes framehandle frame, integer level returns nothing
native BlzFrameSetParent                           takes framehandle frame, framehandle parent returns nothing
native BlzFrameGetParent                           takes framehandle frame returns framehandle
native BlzFrameGetHeight                           takes framehandle frame returns real
native BlzFrameGetWidth                            takes framehandle frame returns real
native BlzFrameSetFont                             takes framehandle frame, string fileName, real height, integer flags returns nothing
native BlzFrameSetTextAlignment                    takes framehandle frame, textaligntype vert, textaligntype horz returns nothing
native BlzFrameGetChildrenCount                    takes framehandle frame returns integer
native BlzFrameGetChild                            takes framehandle frame, integer index returns framehandle
native BlzTriggerRegisterFrameEvent                takes trigger whichTrigger, framehandle frame, frameeventtype eventId returns event
native BlzGetTriggerFrame                          takes nothing returns framehandle
native BlzGetTriggerFrameEvent                     takes nothing returns frameeventtype
native BlzGetTriggerFrameValue                     takes nothing returns real
native BlzGetTriggerFrameText                      takes nothing returns string
native BlzTriggerRegisterPlayerSyncEvent           takes trigger whichTrigger, player whichPlayer, string prefix, boolean fromServer returns event
native BlzSendSyncData                             takes string prefix, string data returns boolean
native BlzGetTriggerSyncPrefix                     takes nothing returns string
native BlzGetTriggerSyncData                       takes nothing returns string
native BlzTriggerRegisterPlayerKeyEvent            takes trigger whichTrigger, player whichPlayer, oskeytype key, integer metaKey, boolean keyDown returns event
native BlzGetTriggerPlayerKey                      takes nothing returns oskeytype
native BlzGetTriggerPlayerMetaKey                  takes nothing returns integer
native BlzGetTriggerPlayerIsKeyDown                takes nothing returns boolean
native BlzEnableCursor                             takes boolean enable returns nothing
native BlzSetMousePos                              takes integer x, integer y returns nothing
native BlzGetLocalClientWidth                      takes nothing returns integer
native BlzGetLocalClientHeight                     takes nothing returns integer
native BlzIsLocalClientActive                      takes nothing returns boolean
native BlzGetMouseFocusUnit                        takes nothing returns unit
native BlzChangeMinimapTerrainTex                  takes string texFile returns boolean
native BlzGetLocale                                takes nothing returns string
native BlzGetSpecialEffectScale                    takes effect whichEffect returns real
native BlzSetSpecialEffectMatrixScale              takes effect whichEffect, real x, real y, real z returns nothing
native BlzResetSpecialEffectMatrix                 takes effect whichEffect returns nothing
native BlzGetUnitAbility                           takes unit whichUnit, integer abilId returns ability
native BlzGetUnitAbilityByIndex                    takes unit whichUnit, integer index returns ability
native BlzGetAbilityId                             takes ability whichAbility returns integer
native BlzDisplayChatMessage                       takes player whichPlayer, integer recipient, string message returns nothing
native BlzPauseUnitEx                              takes unit whichUnit, boolean flag returns nothing
// native BlzFourCC2S                                 takes integer value returns string
// native BlzS2FourCC                                 takes string value returns integer
native BlzSetUnitFacingEx                          takes unit whichUnit, real facingAngle returns nothing

native CreateCommandButtonEffect                   takes integer abilityId, string order returns commandbuttoneffect
native CreateUpgradeCommandButtonEffect            takes integer whichUprgade returns commandbuttoneffect
native CreateLearnCommandButtonEffect              takes integer abilityId returns commandbuttoneffect
native DestroyCommandButtonEffect                  takes commandbuttoneffect whichEffect returns nothing

// Bit Operations
native BlzBitOr                                    takes integer x, integer y returns integer
native BlzBitAnd                                   takes integer x, integer y returns integer
native BlzBitXor                                   takes integer x, integer y returns integer

// Intanced Object Operations
// Ability
native BlzGetAbilityBooleanField                   takes ability whichAbility, abilitybooleanfield whichField returns boolean
native BlzGetAbilityIntegerField                   takes ability whichAbility, abilityintegerfield whichField returns integer
native BlzGetAbilityRealField                      takes ability whichAbility, abilityrealfield whichField returns real
native BlzGetAbilityStringField                    takes ability whichAbility, abilitystringfield whichField returns string
native BlzGetAbilityBooleanLevelField              takes ability whichAbility, abilitybooleanlevelfield whichField, integer level returns boolean
native BlzGetAbilityIntegerLevelField              takes ability whichAbility, abilityintegerlevelfield whichField, integer level returns integer
native BlzGetAbilityRealLevelField                 takes ability whichAbility, abilityreallevelfield whichField, integer level returns real
native BlzGetAbilityStringLevelField               takes ability whichAbility, abilitystringlevelfield whichField, integer level returns string
native BlzGetAbilityBooleanLevelArrayField         takes ability whichAbility, abilitybooleanlevelarrayfield whichField, integer level, integer index returns boolean
native BlzGetAbilityIntegerLevelArrayField         takes ability whichAbility, abilityintegerlevelarrayfield whichField, integer level, integer index returns integer
native BlzGetAbilityRealLevelArrayField            takes ability whichAbility, abilityreallevelarrayfield whichField, integer level, integer index returns real
native BlzGetAbilityStringLevelArrayField          takes ability whichAbility, abilitystringlevelarrayfield whichField, integer level, integer index returns string
native BlzSetAbilityBooleanField                   takes ability whichAbility, abilitybooleanfield whichField, boolean value returns boolean
native BlzSetAbilityIntegerField                   takes ability whichAbility, abilityintegerfield whichField, integer value returns boolean
native BlzSetAbilityRealField                      takes ability whichAbility, abilityrealfield whichField, real value returns boolean
native BlzSetAbilityStringField                    takes ability whichAbility, abilitystringfield whichField, string value returns boolean
native BlzSetAbilityBooleanLevelField              takes ability whichAbility, abilitybooleanlevelfield whichField, integer level, boolean value returns boolean
native BlzSetAbilityIntegerLevelField              takes ability whichAbility, abilityintegerlevelfield whichField, integer level, integer value returns boolean
native BlzSetAbilityRealLevelField                 takes ability whichAbility, abilityreallevelfield whichField, integer level, real value returns boolean
native BlzSetAbilityStringLevelField               takes ability whichAbility, abilitystringlevelfield whichField, integer level, string value returns boolean
native BlzSetAbilityBooleanLevelArrayField         takes ability whichAbility, abilitybooleanlevelarrayfield whichField, integer level, integer index, boolean value returns boolean
native BlzSetAbilityIntegerLevelArrayField         takes ability whichAbility, abilityintegerlevelarrayfield whichField, integer level, integer index, integer value returns boolean
native BlzSetAbilityRealLevelArrayField            takes ability whichAbility, abilityreallevelarrayfield whichField, integer level, integer index, real value returns boolean
native BlzSetAbilityStringLevelArrayField          takes ability whichAbility, abilitystringlevelarrayfield whichField, integer level, integer index, string value returns boolean
native BlzAddAbilityBooleanLevelArrayField         takes ability whichAbility, abilitybooleanlevelarrayfield whichField, integer level, boolean value returns boolean
native BlzAddAbilityIntegerLevelArrayField         takes ability whichAbility, abilityintegerlevelarrayfield whichField, integer level, integer value returns boolean
native BlzAddAbilityRealLevelArrayField            takes ability whichAbility, abilityreallevelarrayfield whichField, integer level, real value returns boolean
native BlzAddAbilityStringLevelArrayField          takes ability whichAbility, abilitystringlevelarrayfield whichField, integer level, string value returns boolean
native BlzRemoveAbilityBooleanLevelArrayField      takes ability whichAbility, abilitybooleanlevelarrayfield whichField, integer level, boolean value returns boolean
native BlzRemoveAbilityIntegerLevelArrayField      takes ability whichAbility, abilityintegerlevelarrayfield whichField, integer level, integer value returns boolean
native BlzRemoveAbilityRealLevelArrayField         takes ability whichAbility, abilityreallevelarrayfield whichField, integer level, real value returns boolean
native BlzRemoveAbilityStringLevelArrayField       takes ability whichAbility, abilitystringlevelarrayfield whichField, integer level, string value returns boolean

// Item
native BlzGetItemAbilityByIndex                    takes item whichItem, integer index returns ability
native BlzGetItemAbility                           takes item whichItem, integer abilCode returns ability
native BlzItemAddAbility                           takes item whichItem, integer abilCode returns boolean
native BlzGetItemBooleanField                      takes item whichItem, itembooleanfield whichField returns boolean
native BlzGetItemIntegerField                      takes item whichItem, itemintegerfield whichField returns integer
native BlzGetItemRealField                         takes item whichItem, itemrealfield whichField returns real
native BlzGetItemStringField                       takes item whichItem, itemstringfield whichField returns string
native BlzSetItemBooleanField                      takes item whichItem, itembooleanfield whichField, boolean value returns boolean
native BlzSetItemIntegerField                      takes item whichItem, itemintegerfield whichField, integer value returns boolean
native BlzSetItemRealField                         takes item whichItem, itemrealfield whichField, real value returns boolean
native BlzSetItemStringField                       takes item whichItem, itemstringfield whichField, string value returns boolean
native BlzItemRemoveAbility                        takes item whichItem, integer abilCode returns boolean

// Unit
native BlzGetUnitBooleanField                      takes unit whichUnit, unitbooleanfield whichField returns boolean
native BlzGetUnitIntegerField                      takes unit whichUnit, unitintegerfield whichField returns integer
native BlzGetUnitRealField                         takes unit whichUnit, unitrealfield whichField returns real
native BlzGetUnitStringField                       takes unit whichUnit, unitstringfield whichField returns string
native BlzSetUnitBooleanField                      takes unit whichUnit, unitbooleanfield whichField, boolean value returns boolean
native BlzSetUnitIntegerField                      takes unit whichUnit, unitintegerfield whichField, integer value returns boolean
native BlzSetUnitRealField                         takes unit whichUnit, unitrealfield whichField, real value returns boolean
native BlzSetUnitStringField                       takes unit whichUnit, unitstringfield whichField, string value returns boolean

// Unit Weapon
native BlzGetUnitWeaponBooleanField                takes unit whichUnit, unitweaponbooleanfield whichField, integer index returns boolean
native BlzGetUnitWeaponIntegerField                takes unit whichUnit, unitweaponintegerfield whichField, integer index returns integer
native BlzGetUnitWeaponRealField                   takes unit whichUnit, unitweaponrealfield whichField, integer index returns real
native BlzGetUnitWeaponStringField                 takes unit whichUnit, unitweaponstringfield whichField, integer index returns string
native BlzSetUnitWeaponBooleanField                takes unit whichUnit, unitweaponbooleanfield whichField, integer index, boolean value returns boolean
native BlzSetUnitWeaponIntegerField                takes unit whichUnit, unitweaponintegerfield whichField, integer index, integer value returns boolean
native BlzSetUnitWeaponRealField                   takes unit whichUnit, unitweaponrealfield whichField, integer index, real value returns boolean
native BlzSetUnitWeaponStringField                 takes unit whichUnit, unitweaponstringfield whichField, integer index, string value returns boolean

// Skin
native BlzGetUnitSkin                                 takes unit whichUnit returns integer
native BlzGetItemSkin                                 takes item whichItem returns integer
// native BlzGetDestructableSkin                         takes destructable whichDestructable returns integer
native BlzSetUnitSkin                                 takes unit whichUnit, integer skinId returns nothing
native BlzSetItemSkin                                 takes item whichItem, integer skinId returns nothing
// native BlzSetDestructableSkin                         takes destructable whichDestructable, integer skinId returns nothing

native BlzCreateItemWithSkin                       takes integer itemid, real x, real y, integer skinId returns item
native BlzCreateUnitWithSkin                       takes player id, integer unitid, real x, real y, real face, integer skinId returns unit
native BlzCreateDestructableWithSkin               takes integer objectid, real x, real y, real face, real scale, integer variation, integer skinId returns destructable
native BlzCreateDestructableZWithSkin              takes integer objectid, real x, real y, real z, real face, real scale, integer variation, integer skinId returns destructable
native BlzCreateDeadDestructableWithSkin           takes integer objectid, real x, real y, real face, real scale, integer variation, integer skinId returns destructable
native BlzCreateDeadDestructableZWithSkin          takes integer objectid, real x, real y, real z, real face, real scale, integer variation, integer skinId returns destructable
native BlzGetPlayerTownHallCount                   takes player whichPlayer returns integer

native BlzQueueImmediateOrderById      takes unit whichUnit, integer order returns boolean
native BlzQueuePointOrderById          takes unit whichUnit, integer order, real x, real y returns boolean
native BlzQueueTargetOrderById         takes unit whichUnit, integer order, widget targetWidget returns boolean
native BlzQueueInstantPointOrderById   takes unit whichUnit, integer order, real x, real y, widget instantTargetWidget returns boolean
native BlzQueueInstantTargetOrderById  takes unit whichUnit, integer order, widget targetWidget, widget instantTargetWidget returns boolean
native BlzQueueBuildOrderById          takes unit whichPeon, integer unitId, real x, real y returns boolean
native BlzQueueNeutralImmediateOrderById   takes player forWhichPlayer,unit neutralStructure, integer unitId returns boolean
native BlzQueueNeutralPointOrderById       takes player forWhichPlayer,unit neutralStructure, integer unitId, real x, real y returns boolean
native BlzQueueNeutralTargetOrderById      takes player forWhichPlayer,unit neutralStructure, integer unitId, widget target returns boolean

// returns the number of orders the unit currently has queued up
native BlzGetUnitOrderCount takes unit whichUnit returns integer
// clears either all orders or only queued up orders
native BlzUnitClearOrders takes unit whichUnit, boolean onlyQueued returns nothing
// stops the current order and optionally clears the queue
native BlzUnitForceStopOrder takes unit whichUnit, boolean clearQueue returns nothing
