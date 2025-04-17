globals
//globals from FrameLoader:
constant boolean LIBRARY_FrameLoader=true
trigger FrameLoader___eventTrigger= CreateTrigger()
trigger FrameLoader___actionTrigger= CreateTrigger()
timer FrameLoader___t= CreateTimer()
//endglobals from FrameLoader
//globals from FrameSaver:
constant boolean LIBRARY_FrameSaver=true
constant real FrameSaver___DELAY= 5.0
trigger FrameSaver___saveTrigger= CreateTrigger()
trigger FrameSaver___loadTrigger= CreateTrigger()
trigger FrameSaver___afterSaveTrigger= CreateTrigger()
timer FrameSaver___t= CreateTimer()
//endglobals from FrameSaver
//globals from ItemTypeUtils:
constant boolean LIBRARY_ItemTypeUtils=true
    // Barade: Cache all the values for better performance.
hashtable ItemTypeUtils___h= InitHashtable()
    
constant integer ItemTypeUtils___SHOP= 'ngme'
constant integer ItemTypeUtils___SELL_UNIT= 'HPal'
constant real ItemTypeUtils___PAWN_ITEM_RATE= 0.5
    
constant integer ItemTypeUtils___KEY_VALUE_GOLD= 0
constant integer ItemTypeUtils___KEY_VALUE_LUMBER= 1
constant integer ItemTypeUtils___KEY_PERISHABLE= 2
constant integer ItemTypeUtils___KEY_MODEL= 3
constant integer ItemTypeUtils___KEY_ICON= 4
//endglobals from ItemTypeUtils
//globals from OnStartGame:
constant boolean LIBRARY_OnStartGame=true
trigger OnStartGame___startGameTrigger= CreateTrigger()
//endglobals from OnStartGame
//globals from StringUtils:
constant boolean LIBRARY_StringUtils=true
//endglobals from StringUtils
//globals from PagedButtonsConfig:
constant boolean LIBRARY_PagedButtonsConfig=true
hashtable PagedButtonsConfig___h= InitHashtable()
//endglobals from PagedButtonsConfig
//globals from StringFormat:
constant boolean LIBRARY_StringFormat=true
//endglobals from StringFormat
//globals from MapConfigs:
constant boolean LIBRARY_MapConfigs=true
constant integer PALADIN= 'Hpal'

constant integer BLACK_DRAGON_WHELP= 'nbdr'
constant integer BLACK_DRAKE= 'nbdk'
constant integer BLACK_DRAGON= 'nbwm'
    
constant integer BOOTS_OF_SPEED= 'bspd'
constant integer RING_OF_PROTECTION_1= 'rde0'
constant integer RING_OF_PROTECTION_2= 'rde1'
constant integer RING_OF_PROTECTION_3= 'rde2'
constant integer RING_OF_PROTECTION_4= 'rde3'
constant integer RING_OF_PROTECTION_5= 'rde4'
//endglobals from MapConfigs
//globals from PagedButtons:
constant boolean LIBRARY_PagedButtons=true
constant integer PagedButtons_NEXT_PAGE_ID= 'h001'
constant integer PagedButtons_PREVIOUS_PAGE_ID= 'h000'
constant integer PagedButtons_SLOTS_PER_PAGE= 9
constant integer PagedButtons_ABILITY_ID_SELL_UNITS= 'Asud'
constant integer PagedButtons_ABILITY_ID_SELL_ITEMS= 'Asid'
    // The shops will be disabled automatically when a shop unit dies.
constant boolean PagedButtons_DISABLE_SHOPS_ON_DEATH= true
constant boolean PagedButtons_CHANGE_PAGE_UNIT_NAME= true
constant boolean PagedButtons_SHOW_PAGE_MESSAGE= false
constant boolean PagedButtons_HIDE_PAGE_BUTTONS_FOR_ONE_PAGE= true
constant boolean PagedButtons_SHOW_PAGE_NUMBER_IN_PAGE_BUTTONS= true
    // Shows the number of the next and previous pages in the page buttons. Otherwise, it will show the current page number.
constant boolean PagedButtons_SHOW_NEXT_AND_PREVIOUS_PAGE_NUMBER= false
    
constant boolean PagedButtons_AUTO_UPDATE_STOCKS= true
    // Define this as true to prevent items from being removed completely from non-marketplace shops.
constant boolean PagedButtons_ENABLE_FAKE_MARKETPLACE_ITEM_REMOVAL= true
constant boolean PagedButtons_HOOK_REMOVE_UNIT= true
    // This delay hreshold is required to avoid wrong item or unit types being removed due to still refilling stocks.
constant integer PagedButtons_STOCK_DELAY_THRESHOLD= 1
    
constant integer PagedButtons_BUTTON_TYPE_UNIT= 0
constant integer PagedButtons_BUTTON_TYPE_ITEM= 1
constant integer PagedButtons_BUTTON_TYPE_ABILITY= 2
constant integer PagedButtons_BUTTON_TYPE_SPACER= 3
    
hashtable PagedButtons___h= InitHashtable()
group PagedButtons___shops= CreateGroup()
trigger PagedButtons___deathTrigger= null
trigger PagedButtons___sellUnitTrigger= CreateTrigger()
trigger PagedButtons___sellItemTrigger= CreateTrigger()
timer PagedButtons___autoUpdateStockTimer= CreateTimer()
    
    // callbacks
trigger array PagedButtons___callbackTriggersChangePageButtons
integer PagedButtons___callbackTriggersChangePageButtonsCounter= 0
trigger array PagedButtons___callbackTriggersObjectAvailable
integer PagedButtons___callbackTriggersObjectAvailableCounter= 0
unit PagedButtons___triggerShop= null
integer PagedButtons___triggerPreviousPage= 0
integer PagedButtons___triggerAvailableObject= 0
//endglobals from PagedButtons
//globals from PagedButtonsUI:
constant boolean LIBRARY_PagedButtonsUI=true
    // Specifies if a charge number is shown which indicates the slot's page.
constant boolean PagedButtonsUI_SHOW_PAGE_NUMBERS= false
    // Specifies if preview registered models for IDs are shown below the tooltip.
constant boolean PagedButtonsUI_SHOW_PREVIEW_MODELS= true
constant integer PagedButtonsUI_MAX_SLOTS= 130
constant integer PagedButtonsUI_MAX_SLOTS_PER_LINE= 13
constant integer PagedButtonsUI_HERO_GOLD_COST= 425
constant integer PagedButtonsUI_HERO_LUMBER_COST= 100
    
constant boolean PagedButtonsUI_LOAD_TOC_FILE= true
constant string PagedButtonsUI_TOC_FILE= "war3mapImported\\PagedButtonsUITOC.toc"
    
constant string PagedButtonsUI_PREFIX= "PagedButtonsUI"
constant real PagedButtonsUI_X= 0.0
constant real PagedButtonsUI_Y= 0.57
constant real PagedButtonsUI_SIZE_X= 0.80
constant real PagedButtonsUI_SIZE_Y= 0.42
constant real PagedButtonsUI_TITLE_Y= 0.543
constant real PagedButtonsUI_TITLE_HEIGHT= 0.1
constant real PagedButtonsUI_BUTTON_X= 0.032
constant real PagedButtonsUI_BUTTON_Y= 0.53
constant real PagedButtonsUI_BUTTON_SIZE= 0.02818
constant real PagedButtonsUI_CHARGES_BACKGROUND_SIZE= 0.011
constant real PagedButtonsUI_CHARGES_POS= 0.003
constant real PagedButtonsUI_CHARGES_SIZE= 0.02
constant real PagedButtonsUI_BUTTON_SPACE= 0.005
    
constant real PagedButtonsUI_TOOLTIP_FRAME_X= 0.46
constant real PagedButtonsUI_TOOLTIP_FRAME_Y= 0.55
constant real PagedButtonsUI_TOOLTIP_FRAME_WIDTH= 0.32
constant real PagedButtonsUI_TOOLTIP_FRAME_HEIGHT= 0.386
    
constant real PagedButtonsUI_TOOLTIP_HORIZONTAL_SPACING= 0.03
constant real PagedButtonsUI_TOOLTIP_X= PagedButtonsUI_TOOLTIP_FRAME_X + PagedButtonsUI_TOOLTIP_HORIZONTAL_SPACING

constant real PagedButtonsUI_TOOLTIP_ICON_X= PagedButtonsUI_TOOLTIP_X
constant real PagedButtonsUI_TOOLTIP_ICON_Y= 0.52
constant real PagedButtonsUI_TOOLTIP_ICON_SIZE= 0.034
    
constant real PagedButtonsUI_TOOLTIP_PAGE_NAME_X= PagedButtonsUI_TOOLTIP_ICON_X + PagedButtonsUI_TOOLTIP_ICON_SIZE + 0.003
constant real PagedButtonsUI_TOOLTIP_PAGE_NAME_Y= 0.52
constant real PagedButtonsUI_TOOLTIP_PAGE_NAME_WIDTH= 0.1
constant real PagedButtonsUI_TOOLTIP_PAGE_NAME_HEIGHT= 0.011
    
constant real PagedButtonsUI_VERTICAL_SPACE= 0.0004
    
constant real PagedButtonsUI_SUMMON_X= PagedButtonsUI_TOOLTIP_PAGE_NAME_X
constant real PagedButtonsUI_SUMMON_Y= PagedButtonsUI_TOOLTIP_PAGE_NAME_Y - PagedButtonsUI_TOOLTIP_PAGE_NAME_HEIGHT - PagedButtonsUI_VERTICAL_SPACE
constant real PagedButtonsUI_SUMMON_HEIGHT= 0.011
    
constant real PagedButtonsUI_COST_SPACE= 0.009
constant real PagedButtonsUI_COST_ICON_SPACE= 0.003
    
constant real PagedButtonsUI_COST_X= PagedButtonsUI_SUMMON_X
constant real PagedButtonsUI_COST_Y= PagedButtonsUI_SUMMON_Y - PagedButtonsUI_SUMMON_HEIGHT - PagedButtonsUI_VERTICAL_SPACE
constant real PagedButtonsUI_COST_HEIGHT= 0.011
constant real PagedButtonsUI_COST_ICON_SIZE= 0.01
constant real PagedButtonsUI_COST_GOLD_X= PagedButtonsUI_COST_X + PagedButtonsUI_COST_ICON_SIZE + PagedButtonsUI_COST_ICON_SPACE
constant real PagedButtonsUI_COST_WIDTH= 0.03
    
constant real PagedButtonsUI_COST_ICON_LUMBER_X= PagedButtonsUI_COST_GOLD_X + PagedButtonsUI_COST_WIDTH + PagedButtonsUI_COST_SPACE
constant real PagedButtonsUI_COST_LUMBER_X= PagedButtonsUI_COST_ICON_LUMBER_X + PagedButtonsUI_COST_ICON_SIZE + PagedButtonsUI_COST_ICON_SPACE
constant real PagedButtonsUI_COST_ICON_FOOD_X= PagedButtonsUI_COST_LUMBER_X + PagedButtonsUI_COST_WIDTH + PagedButtonsUI_COST_SPACE
constant real PagedButtonsUI_COST_FOOD_X= PagedButtonsUI_COST_ICON_FOOD_X + PagedButtonsUI_COST_ICON_SIZE + PagedButtonsUI_COST_ICON_SPACE
    
constant real PagedButtonsUI_TOOLTIP_WIDTH= PagedButtonsUI_TOOLTIP_FRAME_WIDTH - 2.0 * PagedButtonsUI_TOOLTIP_HORIZONTAL_SPACING
constant real PagedButtonsUI_TOOLTIP_Y= PagedButtonsUI_COST_Y - PagedButtonsUI_COST_HEIGHT - PagedButtonsUI_BUTTON_SPACE
constant real PagedButtonsUI_TOOLTIP_HEIGHT= 0.29
constant real PagedButtonsUI_TOOLTIP_FONT_HEIGHT= 0.008
    
constant real PagedButtonsUI_PREVIEW_X= PagedButtonsUI_TOOLTIP_X + 0.05
constant real PagedButtonsUI_PREVIEW_Y= PagedButtonsUI_TOOLTIP_FRAME_Y - PagedButtonsUI_TOOLTIP_HEIGHT + 0.03
constant real PagedButtonsUI_PREVIEW_WIDTH= PagedButtonsUI_TOOLTIP_WIDTH
constant real PagedButtonsUI_PREVIEW_HEIGHT= 0.02
    
constant real PagedButtonsUI_NEXT_PAGE_BUTTON_X= 0.18
constant real PagedButtonsUI_PREVIOUS_PAGE_BUTTON_X= 0.06
constant real PagedButtonsUI_PAGE_BUTTON_WIDTH= 0.12
    
constant real PagedButtonsUI_CHECKBOX_X= 0.032
constant real PagedButtonsUI_CHECKBOX_SIZE= 0.026
    
constant real PagedButtonsUI_CLOSE_BUTTON_X= 0.34
constant real PagedButtonsUI_BOTTOM_BUTTONS_Y= 0.203
constant real PagedButtonsUI_CLOSE_BUTTON_WIDTH= 0.12
constant real PagedButtonsUI_CLOSE_BUTTON_HEIGHT= 0.03
    
    // player data
boolean array PagedButtonsUI___enabledForPlayer
boolean array PagedButtonsUI___UIVisible
unit array PagedButtonsUI___UIShop
integer array PagedButtonsUI___PagesIndex
boolean array PagedButtonsUI___checked
    // static if (SHOW_PREVIEW_MODELS) then
real array PagedButtonsUI___previewModelX
real array PagedButtonsUI___previewModelY
real array PagedButtonsUI___previewModelScale
string array PagedButtonsUI___previewModelFile
    //endif
    
framehandle PagedButtonsUI___BackgroundFrame
framehandle PagedButtonsUI___TitleFrame
framehandle array PagedButtonsUI___SlotFrame
framehandle array PagedButtonsUI___SlotBackdropFrame
framehandle array PagedButtonsUI___SlotChargesBackgroundFrame
framehandle array PagedButtonsUI___SlotChargesFrame
framehandle array PagedButtonsUI___SlotPageBackgroundFrame
framehandle array PagedButtonsUI___SlotPageFrame
trigger array PagedButtonsUI___SlotClickTrigger
trigger array PagedButtonsUI___SlotTooltipOnTrigger
trigger array PagedButtonsUI___SlotTooltipOffTrigger
framehandle PagedButtonsUI___TooltipFrame
framehandle PagedButtonsUI___PageNameText
framehandle PagedButtonsUI___TooltipIcon
framehandle PagedButtonsUI___SummonFrame
framehandle PagedButtonsUI___ItemGoldFrame
framehandle PagedButtonsUI___ItemGoldIconFrame
framehandle PagedButtonsUI___ItemLumberFrame
framehandle PagedButtonsUI___ItemLumberIconFrame
framehandle PagedButtonsUI___ItemFoodFrame
framehandle PagedButtonsUI___ItemFoodIconFrame
framehandle PagedButtonsUI___TooltipText
framehandle PagedButtonsUI___PreviewSprite= null
effect PagedButtonsUI___PreviewEffect= null
framehandle PagedButtonsUI___NextPagesButton
trigger PagedButtonsUI___NextPagesTrigger= null
framehandle PagedButtonsUI___PreviousPagesButton
trigger PagedButtonsUI___PreviousPagesTrigger= null
framehandle PagedButtonsUI___Checkbox
trigger PagedButtonsUI___CheckedTrigger= null
trigger PagedButtonsUI___UncheckedTrigger= null
framehandle PagedButtonsUI___CloseButton
trigger PagedButtonsUI___CloseTrigger= null
    
hashtable PagedButtonsUI___h= InitHashtable()
trigger PagedButtonsUI___syncTrigger= CreateTrigger()
trigger PagedButtonsUI___selectionTrigger= CreateTrigger()
trigger PagedButtonsUI___changePageButtonsTrigger= CreateTrigger()
trigger PagedButtonsUI___deathTrigger= CreateTrigger()
//endglobals from PagedButtonsUI
    // User-defined
unit udg_Shop= null
integer udg_ItemType= 0
integer udg_UnitType= 0
string udg_PageName
integer udg_PreviousPage= 0
integer udg_CurrentPage= 0
integer udg_Ability= 0
boolean udg_Enabled= false
unit udg_Shop2= null

    // Generated
rect gg_rct_dummy_sell_item= null
trigger gg_trg_Callback_Change_Shop_Page= null
trigger gg_trg_Callback_Object_Available= null
trigger gg_trg_Initialization= null
trigger gg_trg_Game_Start= null
trigger gg_trg_Shops= null
trigger gg_trg_No_UI= null
trigger gg_trg_UI= null
trigger gg_trg_No_Drakes= null
trigger gg_trg_Drakes= null
trigger gg_trg_Build_Shop= null
trigger gg_trg_Marketplace_Add_Unit= null
trigger gg_trg_Marketplace_Add_Item= null
trigger gg_trg_Marketplace_Sells_Unit= null
trigger gg_trg_Marketplace_Sells_Item= null
unit gg_unit_Hpal_0000= null
unit gg_unit_Hpal_0029= null

trigger l__library_init

//JASSHelper struct globals:
constant integer si__PagedButtonsConfig=1
integer si__PagedButtonsConfig_F=0
integer si__PagedButtonsConfig_I=0
integer array si__PagedButtonsConfig_V
integer array s__PagedButtonsConfig_heroGoldCost
integer array s__PagedButtonsConfig_heroLumberCost
integer array s__PagedButtonsConfig_stockInitialAfterStartDelay
integer array s__PagedButtonsConfig_stockMaximum
integer array s__PagedButtonsConfig_stockReplenishInterval
integer array s__PagedButtonsConfig_stockStartDelay
real array s__PagedButtonsConfig_modelX
real array s__PagedButtonsConfig_modelY
real array s__PagedButtonsConfig_modelScale
string array s__PagedButtonsConfig_modelPath
constant integer si__AFormat=2
integer si__AFormat_F=0
integer si__AFormat_I=0
integer array si__AFormat_V
integer array s__AFormat_m_position
string array s__AFormat_m_text
constant integer si__PagedButtons_Type=3
integer si__PagedButtons_Type_F=0
integer si__PagedButtons_Type_I=0
integer array si__PagedButtons_Type_V
boolean array s__PagedButtons_Type_shown
boolean array s__PagedButtons_Type_enabled
integer array s__PagedButtons_Type_whichType
constant integer si__PagedButtons_SpacerType=4
constant integer si__PagedButtons_SlotType=5
unit array s__PagedButtons_SlotType_shop
integer array s__PagedButtons_SlotType_id
integer array s__PagedButtons_SlotType_startStock
integer array s__PagedButtons_SlotType_maxStock
integer array s__PagedButtons_SlotType_currentStock
integer array s__PagedButtons_SlotType_startDelay
integer array s__PagedButtons_SlotType_replenishInterval
boolean array s__PagedButtons_SlotType_replenish
integer array s__PagedButtons_SlotType_elapsedTimeStartDelay
integer array s__PagedButtons_SlotType_elapsedTimeReplenishInterval
boolean array s__PagedButtons_SlotType_startDelayDone
integer array s__PagedButtons_SlotType_list
integer s__PagedButtons_SlotType_listCounter= 0
constant integer si__PagedButtons_Page=6
integer si__PagedButtons_Page_F=0
integer si__PagedButtons_Page_I=0
integer array si__PagedButtons_Page_V
string array s__PagedButtons_Page_name
constant integer si__PagedButtons_Shop=7
integer si__PagedButtons_Shop_F=0
integer si__PagedButtons_Shop_I=0
integer array si__PagedButtons_Shop_V
integer array s__PagedButtons_Shop_slotsPerPage
integer array s__PagedButtons_Shop_currentPage
string array s__PagedButtons_Shop_name
integer array s__PagedButtons_Shop_whichType
integer array s___PagedButtons_Shop_buttons
constant integer s___PagedButtons_Shop_buttons_size=1000
integer array s__PagedButtons_Shop_buttons
integer array s__PagedButtons_Shop_buttonsCount
integer array s___PagedButtons_Shop_pages
constant integer s___PagedButtons_Shop_pages_size=500
integer array s__PagedButtons_Shop_pages
integer array s__PagedButtons_Shop_maxPages
integer array si__PagedButtons_Type_type
trigger array st__PagedButtons_Type_onDestroy
trigger array st___prototype33
trigger array st___prototype44
boolean f__result_boolean
trigger array st___prototype56
unit f__arg_unit1
integer f__arg_integer1
widget f__arg_widget1
integer f__arg_this

endglobals
native GetUnitGoldCost takes integer unitid returns integer
native GetUnitWoodCost takes integer unitid returns integer


//Generated allocator of PagedButtonsConfig
function s__PagedButtonsConfig__allocate takes nothing returns integer
 local integer this=si__PagedButtonsConfig_F
    if (this!=0) then
        set si__PagedButtonsConfig_F=si__PagedButtonsConfig_V[this]
    else
        set si__PagedButtonsConfig_I=si__PagedButtonsConfig_I+1
        set this=si__PagedButtonsConfig_I
    endif
    if (this>8190) then
        return 0
    endif

    set si__PagedButtonsConfig_V[this]=-1
 return this
endfunction

//Generated destructor of PagedButtonsConfig
function s__PagedButtonsConfig_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif (si__PagedButtonsConfig_V[this]!=-1) then
        return
    endif
    set si__PagedButtonsConfig_V[this]=si__PagedButtonsConfig_F
    set si__PagedButtonsConfig_F=this
endfunction

//Generated allocator of PagedButtons_Shop
function s__PagedButtons_Shop__allocate takes nothing returns integer
 local integer this=si__PagedButtons_Shop_F
    if (this!=0) then
        set si__PagedButtons_Shop_F=si__PagedButtons_Shop_V[this]
    else
        set si__PagedButtons_Shop_I=si__PagedButtons_Shop_I+1
        set this=si__PagedButtons_Shop_I
    endif
    if (this>7) then
        return 0
    endif
    set s__PagedButtons_Shop_buttons[this]=(this-1)*1000
    set s__PagedButtons_Shop_pages[this]=(this-1)*500
   set s__PagedButtons_Shop_slotsPerPage[this]= PagedButtons_SLOTS_PER_PAGE
   set s__PagedButtons_Shop_currentPage[this]= 0
   set s__PagedButtons_Shop_buttonsCount[this]= 0
   set s__PagedButtons_Shop_maxPages[this]= 0
    set si__PagedButtons_Shop_V[this]=-1
 return this
endfunction

//Generated destructor of PagedButtons_Shop
function s__PagedButtons_Shop_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif (si__PagedButtons_Shop_V[this]!=-1) then
        return
    endif
    set si__PagedButtons_Shop_V[this]=si__PagedButtons_Shop_F
    set si__PagedButtons_Shop_F=this
endfunction

//Generated allocator of PagedButtons_Page
function s__PagedButtons_Page__allocate takes nothing returns integer
 local integer this=si__PagedButtons_Page_F
    if (this!=0) then
        set si__PagedButtons_Page_F=si__PagedButtons_Page_V[this]
    else
        set si__PagedButtons_Page_I=si__PagedButtons_Page_I+1
        set this=si__PagedButtons_Page_I
    endif
    if (this>8190) then
        return 0
    endif

    set si__PagedButtons_Page_V[this]=-1
 return this
endfunction

//Generated destructor of PagedButtons_Page
function s__PagedButtons_Page_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif (si__PagedButtons_Page_V[this]!=-1) then
        return
    endif
    set si__PagedButtons_Page_V[this]=si__PagedButtons_Page_F
    set si__PagedButtons_Page_F=this
endfunction

//Generated allocator of AFormat
function s__AFormat__allocate takes nothing returns integer
 local integer this=si__AFormat_F
    if (this!=0) then
        set si__AFormat_F=si__AFormat_V[this]
    else
        set si__AFormat_I=si__AFormat_I+1
        set this=si__AFormat_I
    endif
    if (this>8190) then
        return 0
    endif

    set si__AFormat_V[this]=-1
 return this
endfunction

//Generated destructor of AFormat
function s__AFormat_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif (si__AFormat_V[this]!=-1) then
        return
    endif
    set si__AFormat_V[this]=si__AFormat_F
    set si__AFormat_F=this
endfunction

//Generated allocator of PagedButtons_Type
function s__PagedButtons_Type__allocate takes nothing returns integer
 local integer this=si__PagedButtons_Type_F
    if (this!=0) then
        set si__PagedButtons_Type_F=si__PagedButtons_Type_V[this]
    else
        set si__PagedButtons_Type_I=si__PagedButtons_Type_I+1
        set this=si__PagedButtons_Type_I
    endif
    if (this>8190) then
        return 0
    endif

   set s__PagedButtons_Type_shown[this]= false
   set s__PagedButtons_Type_enabled[this]= true
    set si__PagedButtons_Type_type[this]=3
    set si__PagedButtons_Type_V[this]=-1
 return this
endfunction

//Generated destructor of PagedButtons_Type
function sc__PagedButtons_Type_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif (si__PagedButtons_Type_V[this]!=-1) then
        return
    endif
    set f__arg_this=this
    call TriggerEvaluate(st__PagedButtons_Type_onDestroy[si__PagedButtons_Type_type[this]])
    set si__PagedButtons_Type_V[this]=si__PagedButtons_Type_F
    set si__PagedButtons_Type_F=this
endfunction

//Generated method caller for PagedButtons_SlotType.onDestroy
function sc__PagedButtons_SlotType_onDestroy takes integer this returns nothing
    set f__arg_this=this
    call TriggerEvaluate(st__PagedButtons_Type_onDestroy[5])
endfunction

//Generated allocator of PagedButtons_SlotType
function s__PagedButtons_SlotType__allocate takes nothing returns integer
 local integer this=s__PagedButtons_Type__allocate()
 local integer kthis
    if(this==0) then
        return 0
    endif
    set si__PagedButtons_Type_type[this]=5
    set kthis=this

   set s__PagedButtons_SlotType_replenish[this]= true
   set s__PagedButtons_SlotType_startDelayDone[this]= false
 return this
endfunction


//Generated method caller for PagedButtons_SpacerType.onDestroy
function sc__PagedButtons_SpacerType_onDestroy takes integer this returns nothing
endfunction

//Generated allocator of PagedButtons_SpacerType
function s__PagedButtons_SpacerType__allocate takes nothing returns integer
 local integer this=s__PagedButtons_Type__allocate()
 local integer kthis
    if(this==0) then
        return 0
    endif
    set si__PagedButtons_Type_type[this]=4
    set kthis=this

 return this
endfunction

function sc___prototype33_execute takes integer i,unit a1,integer a2 returns nothing
    set f__arg_unit1=a1
    set f__arg_integer1=a2

    call TriggerExecute(st___prototype33[i])
endfunction
function sc___prototype33_evaluate takes integer i,unit a1,integer a2 returns nothing
    set f__arg_unit1=a1
    set f__arg_integer1=a2

    call TriggerEvaluate(st___prototype33[i])

endfunction
function sc___prototype44_execute takes integer i,unit a1 returns nothing
    set f__arg_unit1=a1

    call TriggerExecute(st___prototype44[i])
endfunction
function sc___prototype44_evaluate takes integer i,unit a1 returns boolean
    set f__arg_unit1=a1

    call TriggerEvaluate(st___prototype44[i])
 return f__result_boolean
endfunction
function sc___prototype56_execute takes integer i,widget a1,integer a2 returns nothing
    set f__arg_widget1=a1
    set f__arg_integer1=a2

    call TriggerExecute(st___prototype56[i])
endfunction
function sc___prototype56_evaluate takes integer i,widget a1,integer a2 returns nothing
    set f__arg_widget1=a1
    set f__arg_integer1=a2

    call TriggerEvaluate(st___prototype56[i])

endfunction
function h__RemoveUnit takes unit a0 returns nothing
    //hook: DisablePagedButtons
    call sc___prototype44_evaluate(1,a0)
call RemoveUnit(a0)
endfunction
function h__UnitDropItem takes unit a0, integer a1 returns item
    //hook: AddItemToMarketplaceUnit
    call sc___prototype33_evaluate(1,a0,a1)
return UnitDropItem(a0,a1)
endfunction
function h__WidgetDropItem takes widget a0, integer a1 returns item
    //hook: AddItemToMarketplaceWidget
    call sc___prototype56_evaluate(1,a0,a1)
return WidgetDropItem(a0,a1)
endfunction

//library FrameLoader:
// in 1.31 and upto 1.32.9 PTR (when I wrote this). Frames are not correctly saved and loaded, breaking the game.
// This library runs all functions added to it with a 0s delay after the game was loaded.
// function FrameLoaderAdd takes code func returns nothing
    // func runs when the game is loaded.
    function FrameLoaderAdd takes code func returns nothing
        call TriggerAddAction(FrameLoader___actionTrigger, func)
    endfunction

    function FrameLoader___timerAction takes nothing returns nothing
        call TriggerExecute(FrameLoader___actionTrigger)
    endfunction
    function FrameLoader___eventAction takes nothing returns nothing
        call TimerStart(FrameLoader___t, 0, false, function FrameLoader___timerAction)
    endfunction
    function FrameLoader___init_function takes nothing returns nothing
        call TriggerRegisterGameEvent(FrameLoader___eventTrigger, EVENT_GAME_LOADED)
        call TriggerAddAction(FrameLoader___eventTrigger, function FrameLoader___eventAction)
    endfunction

//library FrameLoader ends
//library FrameSaver:


function FrameSaverAdd takes code func returns nothing
    call TriggerAddAction(FrameSaver___saveTrigger, func)
endfunction

function FrameSaverAddEx takes code func,code func2 returns nothing
    call TriggerAddAction(FrameSaver___saveTrigger, (func)) // INLINED!!
    call TriggerAddAction(FrameSaver___afterSaveTrigger, func2)
endfunction

function FrameSaver___TimerFunctionAfterSave takes nothing returns nothing
    call TriggerExecute(FrameSaver___afterSaveTrigger)
endfunction

function FrameSaver___TriggerActionStartAfterSaveTimer takes nothing returns nothing
    call TimerStart(FrameSaver___t, FrameSaver___DELAY, false, function FrameSaver___TimerFunctionAfterSave)
endfunction

function FrameSaver___TriggerActionCancelAfterSaveTimer takes nothing returns nothing
    call PauseTimer(FrameSaver___t)
endfunction

function FrameSaver___Init takes nothing returns nothing
    call TriggerRegisterGameEvent(FrameSaver___saveTrigger, EVENT_GAME_SAVE)
    call TriggerAddAction(FrameSaver___saveTrigger, function FrameSaver___TriggerActionStartAfterSaveTimer)
    
    call TriggerRegisterGameEvent(FrameSaver___loadTrigger, EVENT_GAME_LOADED)
    call TriggerAddAction(FrameSaver___loadTrigger, function FrameSaver___TriggerActionCancelAfterSaveTimer)
endfunction


//library FrameSaver ends
//library ItemTypeUtils:


// https://www.hiveworkshop.com/threads/detecting-item-price.120355/

// This is the x position where we create the dummy units. Dont place it in the water.
function ItemTypeUtils___GetShopDummyX takes nothing returns real
    return GetRectCenterX(gg_rct_dummy_sell_item)
endfunction

// This is the y position where we create the dummy units. Dont place it in the water.
function ItemTypeUtils___GetShopDummyY takes nothing returns real
    return GetRectCenterY(gg_rct_dummy_sell_item)
endfunction

function GetItemValueGoldFresh takes integer i returns integer
    local real x= (GetRectCenterX(gg_rct_dummy_sell_item)) // INLINED!!
    local real y= (GetRectCenterY(gg_rct_dummy_sell_item)) // INLINED!!
    local unit u1= CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), ItemTypeUtils___SHOP, x, y, 0)
    local unit u2= CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), ItemTypeUtils___SELL_UNIT, x, y - 100, 90)
    local item a= UnitAddItemById(u2, i)
    local integer g1= GetPlayerState(Player(PLAYER_NEUTRAL_PASSIVE), PLAYER_STATE_RESOURCE_GOLD)
    local integer g2= 0
    call SetItemPawnable(a, true)
    call UnitDropItemTarget(u2, a, u1)
    set g2=GetPlayerState(Player(PLAYER_NEUTRAL_PASSIVE), PLAYER_STATE_RESOURCE_GOLD) - g1
    call SetPlayerState(Player(PLAYER_NEUTRAL_PASSIVE), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(Player(PLAYER_NEUTRAL_PASSIVE), PLAYER_STATE_RESOURCE_GOLD) - g2)

    call h__RemoveUnit(u1)
    call h__RemoveUnit(u2)
    set u1=null
    set u2=null
    set a=null
    return g2
endfunction

function GetItemValueGold takes integer i returns integer
    if ( not HaveSavedInteger(ItemTypeUtils___h, i, ItemTypeUtils___KEY_VALUE_GOLD) ) then
        call SaveInteger(ItemTypeUtils___h, i, ItemTypeUtils___KEY_VALUE_GOLD, GetItemValueGoldFresh(i))
    endif
    return LoadInteger(ItemTypeUtils___h, i, ItemTypeUtils___KEY_VALUE_GOLD)
endfunction

function GetItemCostGold takes integer i returns integer
    return R2I(I2R(GetItemValueGold(i)) * ItemTypeUtils___PAWN_ITEM_RATE)
endfunction

function GetItemGoldCost takes integer i returns integer
    return (R2I(I2R(GetItemValueGold((i))) * ItemTypeUtils___PAWN_ITEM_RATE)) // INLINED!!
endfunction

function GetItemValueLumberFresh takes integer i returns integer
    local real x= (GetRectCenterX(gg_rct_dummy_sell_item)) // INLINED!!
    local real y= (GetRectCenterY(gg_rct_dummy_sell_item)) // INLINED!!
    local unit u1= CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), ItemTypeUtils___SHOP, x, y, 0)
    local unit u2= CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), ItemTypeUtils___SELL_UNIT, x, y - 100, 90)
    local item a= UnitAddItemById(u2, i)
    local integer g1= GetPlayerState(Player(PLAYER_NEUTRAL_PASSIVE), PLAYER_STATE_RESOURCE_LUMBER)
    local integer g2= 0
    call SetItemPawnable(a, true)
    call UnitDropItemTarget(u2, a, u1)
    set g2=GetPlayerState(Player(PLAYER_NEUTRAL_PASSIVE), PLAYER_STATE_RESOURCE_LUMBER) - g1
    call SetPlayerState(Player(PLAYER_NEUTRAL_PASSIVE), PLAYER_STATE_RESOURCE_LUMBER, GetPlayerState(Player(PLAYER_NEUTRAL_PASSIVE), PLAYER_STATE_RESOURCE_LUMBER) - g2)

    call h__RemoveUnit(u1)
    call h__RemoveUnit(u2)
    set u1=null
    set u2=null
    set a=null
    return g2
endfunction

function GetItemValueLumber takes integer i returns integer
    if ( not HaveSavedInteger(ItemTypeUtils___h, i, ItemTypeUtils___KEY_VALUE_LUMBER) ) then
        call SaveInteger(ItemTypeUtils___h, i, ItemTypeUtils___KEY_VALUE_LUMBER, GetItemValueLumberFresh(i))
    endif
    return LoadInteger(ItemTypeUtils___h, i, ItemTypeUtils___KEY_VALUE_LUMBER)
endfunction

function GetItemCostLumber takes integer i returns integer
    return R2I(I2R(GetItemValueLumber(i)) * ItemTypeUtils___PAWN_ITEM_RATE)
endfunction

function GetItemWoodCost takes integer i returns integer
    return (R2I(I2R(GetItemValueLumber((i))) * ItemTypeUtils___PAWN_ITEM_RATE)) // INLINED!!
endfunction

function GetItemTypePerishableFresh takes integer i returns boolean
    local item tmpItem= CreateItem(i, 0.0, 0.0)
    local boolean result= BlzGetItemBooleanField(tmpItem, ITEM_BF_PERISHABLE)
    call RemoveItem(tmpItem)
    set tmpItem=null

    return result
endfunction

function GetItemTypePerishable takes integer i returns boolean
    if ( not HaveSavedBoolean(ItemTypeUtils___h, i, ItemTypeUtils___KEY_PERISHABLE) ) then
        call SaveBoolean(ItemTypeUtils___h, i, ItemTypeUtils___KEY_PERISHABLE, GetItemTypePerishableFresh(i))
    endif
    return LoadBoolean(ItemTypeUtils___h, i, ItemTypeUtils___KEY_PERISHABLE)
endfunction

function GetItemTypeModelFresh takes integer i returns string
    local item tmpItem= CreateItem(i, 0.0, 0.0)
    local string result= BlzGetItemStringField(tmpItem, ITEM_SF_MODEL_USED)
    call RemoveItem(tmpItem)
    set tmpItem=null

    return result
endfunction

function GetItemTypeModel takes integer i returns string
    if ( not HaveSavedString(ItemTypeUtils___h, i, ItemTypeUtils___KEY_MODEL) ) then
        call SaveStr(ItemTypeUtils___h, i, ItemTypeUtils___KEY_MODEL, GetItemTypeModelFresh(i))
    endif
    return LoadStr(ItemTypeUtils___h, i, ItemTypeUtils___KEY_MODEL)
endfunction

function GetItemTypeIconFresh takes integer i returns string
    local item tmpItem= CreateItem(i, 0.0, 0.0)
    local string result= BlzGetItemIconPath(tmpItem)
    call RemoveItem(tmpItem)
    set tmpItem=null

    return result
endfunction

function GetItemTypeIcon takes integer i returns string
    if ( not HaveSavedString(ItemTypeUtils___h, i, ItemTypeUtils___KEY_ICON) ) then
        call SaveStr(ItemTypeUtils___h, i, ItemTypeUtils___KEY_ICON, GetItemTypeIconFresh(i))
    endif
    return LoadStr(ItemTypeUtils___h, i, ItemTypeUtils___KEY_ICON)
endfunction


//library ItemTypeUtils ends
//library OnStartGame:


function OnStartGame takes code func returns nothing
    call TriggerAddAction(OnStartGame___startGameTrigger, func)
endfunction

function OnStartGame___TimerFunctionStartGame takes nothing returns nothing
    local timer t= GetExpiredTimer()
    call TriggerExecute(OnStartGame___startGameTrigger)
    call PauseTimer(t)
    call DestroyTimer(t)
    set t=null
endfunction

function OnStartGame___Init takes nothing returns nothing
    call TimerStart(CreateTimer(), 0.0, false, function OnStartGame___TimerFunctionStartGame)
endfunction


//library OnStartGame ends
//library StringUtils:

function B2S takes boolean b returns string
    if ( b ) then
        return "true"
    endif
    return "false"
endfunction

function B2Option takes boolean b returns string
    if ( b ) then
        return GetLocalizedString("ON")
    endif
    return GetLocalizedString("OFF")
endfunction

function StringRepeat takes string str,integer count returns string
    local string result= ""
    local integer i= 0
    loop
        exitwhen ( i >= count )
        set result=result + str
        set i=i + 1
    endloop
    return result
endfunction

function StringReplace takes string source,string match,string replace returns string
    local integer i= 0
    local integer max= StringLength(source)
    local integer matchLength= StringLength(match)
    local integer index= 0
    local string result= ""
    loop
        exitwhen ( i == max )
        set index=i + matchLength
        if ( SubString(source, i, index) == match ) then
            set result=result + replace
            set i=index
        else
            set index=i + 1
            set result=result + SubString(source, i, index)
            set i=index
        endif
    endloop
    return result
endfunction

function StringRemove takes string source,string match returns string
    return StringReplace(source , match , "")
endfunction

function StringStartsWith takes string source,string start returns boolean
    local integer i= 0
    loop
        exitwhen ( i == StringLength(start) or i >= StringLength(source) )

        if ( SubString(source, i, i + 1) != SubString(start, i, i + 1) ) then
            return false
        endif

        set i=i + 1
    endloop

    return i == StringLength(start)
endfunction

function StringRemoveFromStart takes string source,string start returns string
    if ( StringStartsWith(source , start) ) then
        return SubString(source, StringLength(start), StringLength(source))
    endif

    return source
endfunction

function IndexOfStringEx takes string symbol,string source,integer start returns integer
    local integer symbolLength= StringLength(symbol)
    local integer length= StringLength(source)
    local integer i2= 0
    local integer i= start
    //call BJDebugMsg("Checking for symbol: " + symbol + " in source " + source)
    loop
        set i2=i + symbolLength
        exitwhen ( i >= length or i2 > length )
        if ( SubString(source, i, i2) == symbol ) then
            //call BJDebugMsg("Index: " + I2S(i))
            return i
        endif
        set i=i + 1
    endloop

    //call BJDebugMsg("Missing symbol " + symbol + " in source " + source)

    return - 1
endfunction

function IndexOfString takes string symbol,string source returns integer
    return IndexOfStringEx(symbol , source , 0)
endfunction

function StringIndexOf takes string symbol,string source returns integer
    return (IndexOfStringEx((symbol ) , ( source) , 0)) // INLINED!!
endfunction

function StringCount takes string source,string symbol returns integer
    local integer result= 0
    local integer symbolLength= StringLength(symbol)
    local integer length= StringLength(source)
    local integer i= 0
    //call BJDebugMsg("Checking for symbol: " + symbol + " in source " + source)
    loop
        exitwhen ( i == length )
        if ( SubString(source, i, i + symbolLength) == symbol ) then
            //call BJDebugMsg("Index: " + I2S(i))
            set result=result + 1
            set i=i + symbolLength
        else
            set i=i + 1
        endif
    endloop

    //call BJDebugMsg("Missing symbol " + symbol + " in source " + source)

    return result
endfunction


function StringSplit takes string source,integer index,string separator returns string
    local string result= null
    local integer currentIndex= 0
    local integer separatorLength= StringLength(separator)
    local integer length= StringLength(source)
    local integer i= 0
    loop
        exitwhen ( i == length or currentIndex > index )
        if ( SubString(source, i, i + separatorLength) == separator ) then
            if ( currentIndex == index and result == null ) then
                set result=""
            endif
            set currentIndex=currentIndex + 1
            set i=i + separatorLength
        else
            if ( currentIndex == index ) then
                if ( result == null ) then
                    set result=""
                endif
                set result=result + SubString(source, i, i + 1)
            endif
            set i=i + 1
        endif
    endloop

    return result
endfunction


function StringTokenEx takes string source,integer index,string separator,boolean toTheEnd returns string
    local string result= ""
    local boolean inWhitespace= false
    local integer currentIndex= 0
    local integer separatorLength= StringLength(separator)
    local integer length= StringLength(source)
    local integer i= 0
    loop
        exitwhen ( i == length or currentIndex > index )
        if ( SubString(source, i, i + separatorLength) == separator and ( not toTheEnd or currentIndex < index ) ) then
            if ( not inWhitespace ) then
                set inWhitespace=true
                set currentIndex=currentIndex + 1
                set i=i + separatorLength
            endif
        else
            if ( currentIndex == index ) then
                set result=result + SubString(source, i, i + 1)
            endif
            set inWhitespace=false
            set i=i + 1
        endif
    endloop

    return result
endfunction

function StringToken takes string source,integer index returns string
    return StringTokenEx(source , index , " " , false)
endfunction

function StringTokenEnteredChatMessageEx takes integer index,boolean toTheEnd returns string
    return StringTokenEx(GetEventPlayerChatString() , index , " " , toTheEnd)
endfunction

function StringTokenEnteredChatMessage takes integer index returns string
    return (StringTokenEx((GetEventPlayerChatString() ) , ( index) , " " , false)) // INLINED!!
endfunction

function RandomizeString takes string source returns string
    local string result= ""
    local integer sourcePosition= 0
    loop
        exitwhen ( StringLength(source) == 0 )
        set sourcePosition=GetRandomInt(0, StringLength(source) - 1)
        set result=result + SubString(source, sourcePosition, sourcePosition + 1)
        set source=SubString(source, 0, sourcePosition) + SubString(source, sourcePosition + 1, StringLength(source))
    endloop

    return result
endfunction

function StringRandomize takes string source returns string
    return RandomizeString(source)
endfunction

function I2SW takes integer i,integer width returns string
    local integer a= 0
    local string result= ""
    local integer max= 0
    if ( width > 0 ) then
        set a=IAbsBJ(i)
        set max=R2I(Pow(R2I(10), R2I(width - 1)))
        if ( i < 0 ) then
            set result=result + "-"
        endif
        loop
            if ( a >= max or max <= 1 ) then
                set result=result + I2S(a)
                exitwhen ( true )
            else
                set result=result + "0"
                set max=max / 10
            endif
        endloop
    else
        set result=I2S(i)
    endif
    return result
endfunction

function FormatTimeString takes integer seconds returns string
    local integer minutes= seconds / 60
    local integer hours= minutes / 60
    local integer hoursInMinutes= hours * 60
    local integer minutesInSeconds= minutes * 60

    set minutes=minutes - hoursInMinutes
    set seconds=seconds - minutesInSeconds

    if ( hours > 0 ) then
        return I2SW(hours , 2) + ":" + I2SW(minutes , 2) + ":" + I2SW(seconds , 2)
    elseif ( minutes > 0 ) then
        return I2SW(minutes , 2) + ":" + I2SW(seconds , 2)
    else
        return I2S(seconds) + " seconds"
    endif
endfunction

function IsCharacterNumber takes string whichCharacter returns boolean
    return whichCharacter == "0" or whichCharacter == "1" or whichCharacter == "2" or whichCharacter == "3" or whichCharacter == "4" or whichCharacter == "5" or whichCharacter == "6" or whichCharacter == "7" or whichCharacter == "8" or whichCharacter == "9"
endfunction

function IsStringNumber takes string whichString returns boolean
    local integer length= StringLength(whichString)
    local integer i= 0
    loop
        exitwhen ( i == length )
        if ( not IsCharacterNumber(SubString(whichString, i, i + 1)) ) then
            return false
        endif
        set i=i + 1
    endloop
    return true
endfunction

function FormatTime takes real time returns string
    local integer hours= R2I(time / 3600.0)
    local integer minutes=  R2I(time - hours * 3600) / 60
    local integer seconds= R2I(time - hours * 3600 - minutes * 60)
    
    return I2SW(hours , 2) + ":" + I2SW(minutes , 2) + ":" + I2SW(seconds , 2)
endfunction



function InsertLineBreaks takes string whichString,integer maxLineLength returns string
    local integer i
    local string result
    if ( StringLength(whichString) <= maxLineLength ) then
        return whichString
    endif
    set result=""
    set i=maxLineLength
    loop
        exitwhen ( i > StringLength(whichString) )
        set result=result + SubString(whichString, i - maxLineLength, i) + "\n"
        set i=i + maxLineLength
    endloop

    if ( i < StringLength(whichString) ) then
        set result=result + SubString(whichString, i - maxLineLength, StringLength(whichString))
    endif

    return result
endfunction


function GetExternalString takes integer index returns string
    if ( index < 0 ) then
        return ""
    elseif ( index < 10 ) then
        return GetLocalizedString("TRIGSTR_00" + I2S(index))
    elseif ( index < 100 ) then
        return GetLocalizedString("TRIGSTR_0" + I2S(index))
    else
        return GetLocalizedString("TRIGSTR_" + I2S(index))
    endif
endfunction


function tr takes string source returns string
    return GetLocalizedString(source)
endfunction


function trp takes string singularSource,string pluralSource,integer count returns string
    if ( count == 1 ) then
        return (GetLocalizedString((singularSource))) // INLINED!!
    endif
    return (GetLocalizedString((pluralSource))) // INLINED!!
endfunction


function sc takes string source returns integer
    return GetLocalizedHotkey(source)
endfunction


function GetLanguage takes nothing returns string
    if ( GetObjectName('hfoo') == "Soldat" ) then
        return "German"
    endif
    return "English"
endfunction

function tre takes string german,string english returns string
    if ( GetLanguage() == "German" ) then
        return german
    endif
    return english
endfunction


//library StringUtils ends
//library PagedButtonsConfig:



function AddPagedButtonsConfig takes integer id,integer heroGoldCost,integer heroLumberCost,integer stockInitialAfterStartDelay,integer stockMaximum,integer stockReplenishInterval,integer stockStartDelay,real modelX,real modelY,real modelScale,string modelPath returns nothing
    local integer c= s__PagedButtonsConfig__allocate()
    set s__PagedButtonsConfig_heroGoldCost[c]=heroGoldCost
    set s__PagedButtonsConfig_heroLumberCost[c]=heroLumberCost
    set s__PagedButtonsConfig_stockInitialAfterStartDelay[c]=stockInitialAfterStartDelay
    set s__PagedButtonsConfig_stockMaximum[c]=stockMaximum
    set s__PagedButtonsConfig_stockReplenishInterval[c]=stockReplenishInterval
    set s__PagedButtonsConfig_stockStartDelay[c]=stockStartDelay
    set s__PagedButtonsConfig_modelX[c]=modelX
    set s__PagedButtonsConfig_modelY[c]=modelY
    set s__PagedButtonsConfig_modelScale[c]=modelScale
    set s__PagedButtonsConfig_modelPath[c]=modelPath
    
    call SaveInteger(PagedButtonsConfig___h, id, 0, c)
endfunction

function AddPagedButtonsConfigHero takes integer id,integer heroGoldCost,integer heroLumberCost,integer stockInitialAfterStartDelay,integer stockMaximum,integer stockReplenishInterval,integer stockStartDelay,string modelPath returns nothing
    local integer c= s__PagedButtonsConfig__allocate()
    set s__PagedButtonsConfig_heroGoldCost[c]=heroGoldCost
    set s__PagedButtonsConfig_heroLumberCost[c]=heroLumberCost
    set s__PagedButtonsConfig_stockInitialAfterStartDelay[c]=stockInitialAfterStartDelay
    set s__PagedButtonsConfig_stockMaximum[c]=stockMaximum
    set s__PagedButtonsConfig_stockReplenishInterval[c]=stockReplenishInterval
    set s__PagedButtonsConfig_modelX[c]=0.73
    set s__PagedButtonsConfig_modelY[c]=0.26
    set s__PagedButtonsConfig_modelScale[c]=0.0002
    set s__PagedButtonsConfig_modelPath[c]=modelPath
    call SaveInteger(PagedButtonsConfig___h, id, 0, c)
endfunction

function AddPagedButtonsConfigUnit takes integer id,integer stockInitialAfterStartDelay,integer stockMaximum,integer stockReplenishInterval,integer stockStartDelay,string modelPath returns nothing
    local integer c= s__PagedButtonsConfig__allocate()
    set s__PagedButtonsConfig_heroGoldCost[c]=0
    set s__PagedButtonsConfig_heroLumberCost[c]=0
    set s__PagedButtonsConfig_stockInitialAfterStartDelay[c]=stockInitialAfterStartDelay
    set s__PagedButtonsConfig_stockMaximum[c]=stockMaximum
    set s__PagedButtonsConfig_stockReplenishInterval[c]=stockReplenishInterval
    set s__PagedButtonsConfig_modelX[c]=0.73
    set s__PagedButtonsConfig_modelY[c]=0.26
    set s__PagedButtonsConfig_modelScale[c]=0.0002
    set s__PagedButtonsConfig_modelPath[c]=modelPath
    call SaveInteger(PagedButtonsConfig___h, id, 0, c)
endfunction

function AddPagedButtonsConfigItem takes integer id,integer stockInitialAfterStartDelay,integer stockMaximum,integer stockReplenishInterval,integer stockStartDelay returns nothing
    local integer c= s__PagedButtonsConfig__allocate()
    set s__PagedButtonsConfig_heroGoldCost[c]=0
    set s__PagedButtonsConfig_heroLumberCost[c]=0
    set s__PagedButtonsConfig_stockInitialAfterStartDelay[c]=stockInitialAfterStartDelay
    set s__PagedButtonsConfig_stockMaximum[c]=stockMaximum
    set s__PagedButtonsConfig_stockReplenishInterval[c]=stockReplenishInterval
    set s__PagedButtonsConfig_stockStartDelay[c]=stockStartDelay
    set s__PagedButtonsConfig_modelX[c]=0.73
    set s__PagedButtonsConfig_modelY[c]=0.26
    set s__PagedButtonsConfig_modelScale[c]=0.0007
    set s__PagedButtonsConfig_modelPath[c]=GetItemTypeModel(id)
    call SaveInteger(PagedButtonsConfig___h, id, 0, c)
endfunction

function GetPagedButtonsConfig takes integer id returns integer
    local integer c= LoadInteger(PagedButtonsConfig___h, id, 0)
    if ( c == 0 ) then
        return LoadInteger(PagedButtonsConfig___h, 0, 0) // 0 is the default config
    endif
    return c
endfunction

function SetPagedButtonsConfigHeroCostsDefault takes integer heroGoldCost,integer heroLumberCost returns nothing
    local integer c= GetPagedButtonsConfig(0)
    set s__PagedButtonsConfig_heroGoldCost[c]=heroGoldCost
    set s__PagedButtonsConfig_heroLumberCost[c]=heroLumberCost
endfunction

function PagedButtonsConfig___Init takes nothing returns nothing
    // Default config which is used if the user does not register any for ID 0.
    call AddPagedButtonsConfig(0 , 425 , 100 , 1 , 1 , 0 , 0 , 0.0 , 0.0 , 0.0 , "")
endfunction


//library PagedButtonsConfig ends
//library StringFormat:



    
    function s__AFormat_position takes integer this returns integer
        return s__AFormat_m_position[this]
    endfunction

    
    function s__AFormat_text takes integer this returns string
        return s__AFormat_m_text[this]
    endfunction

    

//textmacro instance: AFormatMethod("i", "integer", "i", "I2S(value)", "")
        function s__AFormat_i takes integer this,integer value returns integer
            local string positionString= "%i"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + I2S(value) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + I2S(value) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("i", "integer", "i", "I2S(value)", "")
//textmacro instance: AFormatMethod("integer", "integer", "i", "I2S(value)", "")
        function s__AFormat_integer takes integer this,integer value returns integer
            local string positionString= "%i"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + I2S(value) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + I2S(value) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("integer", "integer", "i", "I2S(value)", "")
//textmacro instance: AFormatMethod("r", "real", "r", "R2S(value)", "")
        function s__AFormat_r takes integer this,real value returns integer
            local string positionString= "%r"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + R2S(value) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + R2S(value) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("r", "real", "r", "R2S(value)", "")
//textmacro instance: AFormatMethod("real", "real", "r", "R2S(value)", "")
        function s__AFormat_real takes integer this,real value returns integer
            local string positionString= "%r"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + R2S(value) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + R2S(value) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("real", "real", "r", "R2S(value)", "")
//textmacro instance: AFormatMethod("rw", "real", "r", "R2SW(value, width, precision)", ", integer width, integer precision")
        function s__AFormat_rw takes integer this,real value,integer width,integer precision returns integer
            local string positionString= "%r"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + R2SW(value, width, precision) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + R2SW(value, width, precision) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("rw", "real", "r", "R2SW(value, width, precision)", ", integer width, integer precision")
//textmacro instance: AFormatMethod("realWidth", "real", "r", "R2SW(value, width, precision)", ", integer width, integer precision")
        function s__AFormat_realWidth takes integer this,real value,integer width,integer precision returns integer
            local string positionString= "%r"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + R2SW(value, width, precision) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + R2SW(value, width, precision) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("realWidth", "real", "r", "R2SW(value, width, precision)", ", integer width, integer precision")
//textmacro instance: AFormatMethod("s", "string", "s", "value", "")
        function s__AFormat_s takes integer this,string value returns integer
            local string positionString= "%s"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + value + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + value + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("s", "string", "s", "value", "")
//textmacro instance: AFormatMethod("string", "string", "s", "value", "")
        function s__AFormat_string takes integer this,string value returns integer
            local string positionString= "%s"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + value + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + value + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("string", "string", "s", "value", "")
//textmacro instance: AFormatMethod("h", "handle", "h", "I2S(GetHandleId(value))", "")
        function s__AFormat_h takes integer this,handle value returns integer
            local string positionString= "%h"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + I2S(GetHandleId(value)) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + I2S(GetHandleId(value)) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("h", "handle", "h", "I2S(GetHandleId(value))", "")
//textmacro instance: AFormatMethod("handle", "handle", "h", "I2S(GetHandleId(value))", "")
        function s__AFormat_handle takes integer this,handle value returns integer
            local string positionString= "%h"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + I2S(GetHandleId(value)) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + I2S(GetHandleId(value)) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("handle", "handle", "h", "I2S(GetHandleId(value))", "")
//textmacro instance: AFormatMethod("u", "unit", "u", "GetUnitName(value)", "")
        function s__AFormat_u takes integer this,unit value returns integer
            local string positionString= "%u"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + GetUnitName(value) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + GetUnitName(value) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("u", "unit", "u", "GetUnitName(value)", "")
//textmacro instance: AFormatMethod("unit", "unit", "u", "GetUnitName(value)", "")
        function s__AFormat_unit takes integer this,unit value returns integer
            local string positionString= "%u"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + GetUnitName(value) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + GetUnitName(value) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("unit", "unit", "u", "GetUnitName(value)", "")
//textmacro instance: AFormatMethod("it", "item", "it", "GetItemName(value)", "")
        function s__AFormat_it takes integer this,item value returns integer
            local string positionString= "%it"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + GetItemName(value) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + GetItemName(value) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("it", "item", "it", "GetItemName(value)", "")
//textmacro instance: AFormatMethod("item", "item", "it", "GetItemName(value)", "")
        function s__AFormat_item takes integer this,item value returns integer
            local string positionString= "%it"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + GetItemName(value) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + GetItemName(value) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("item", "item", "it", "GetItemName(value)", "")
//textmacro instance: AFormatMethod("d", "destructable", "d", "GetDestructableName(value)", "")
        function s__AFormat_d takes integer this,destructable value returns integer
            local string positionString= "%d"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + GetDestructableName(value) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + GetDestructableName(value) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("d", "destructable", "d", "GetDestructableName(value)", "")
//textmacro instance: AFormatMethod("destructable", "destructable", "d", "GetDestructableName(value)", "")
        function s__AFormat_destructable takes integer this,destructable value returns integer
            local string positionString= "%d"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + GetDestructableName(value) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + GetDestructableName(value) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("destructable", "destructable", "d", "GetDestructableName(value)", "")
//textmacro instance: AFormatMethod("p", "player", "p", "GetPlayerName(value)", "")
        function s__AFormat_p takes integer this,player value returns integer
            local string positionString= "%p"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + GetPlayerName(value) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + GetPlayerName(value) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("p", "player", "p", "GetPlayerName(value)", "")
//textmacro instance: AFormatMethod("player", "player", "p", "GetPlayerName(value)", "")
        function s__AFormat_player takes integer this,player value returns integer
            local string positionString= "%p"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + GetPlayerName(value) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + GetPlayerName(value) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("player", "player", "p", "GetPlayerName(value)", "")
//textmacro instance: AFormatMethod("he", "unit", "he", "GetHeroProperName(value)", "")
        function s__AFormat_he takes integer this,unit value returns integer
            local string positionString= "%he"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + GetHeroProperName(value) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + GetHeroProperName(value) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("he", "unit", "he", "GetHeroProperName(value)", "")
//textmacro instance: AFormatMethod("hero", "unit", "he", "GetHeroProperName(value)", "")
        function s__AFormat_hero takes integer this,unit value returns integer
            local string positionString= "%he"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + GetHeroProperName(value) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + GetHeroProperName(value) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("hero", "unit", "he", "GetHeroProperName(value)", "")
//textmacro instance: AFormatMethod("o", "integer", "o", "GetObjectName(value)", "")
        function s__AFormat_o takes integer this,integer value returns integer
            local string positionString= "%o"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + GetObjectName(value) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + GetObjectName(value) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("o", "integer", "o", "GetObjectName(value)", "")
//textmacro instance: AFormatMethod("object", "integer", "o", "GetObjectName(value)", "")
        function s__AFormat_object takes integer this,integer value returns integer
            local string positionString= "%o"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + GetObjectName(value) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + GetObjectName(value) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("object", "integer", "o", "GetObjectName(value)", "")
//textmacro instance: AFormatMethod("l", "string", "l", "GetLocalizedString(value)", "")
        function s__AFormat_l takes integer this,string value returns integer
            local string positionString= "%l"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + GetLocalizedString(value) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + GetLocalizedString(value) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("l", "string", "l", "GetLocalizedString(value)", "")
//textmacro instance: AFormatMethod("localizedString", "string", "l", "GetLocalizedString(value)", "")
        function s__AFormat_localizedString takes integer this,string value returns integer
            local string positionString= "%l"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + GetLocalizedString(value) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + GetLocalizedString(value) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("localizedString", "string", "l", "GetLocalizedString(value)", "")
//textmacro instance: AFormatMethod("k", "string", "k", "I2S(GetLocalizedHotkey(value))", "")
        function s__AFormat_k takes integer this,string value returns integer
            local string positionString= "%k"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + I2S(GetLocalizedHotkey(value)) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + I2S(GetLocalizedHotkey(value)) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("k", "string", "k", "I2S(GetLocalizedHotkey(value))", "")
//textmacro instance: AFormatMethod("localizedHotkey", "string", "k", "I2S(GetLocalizedHotkey(value))", "")
        function s__AFormat_localizedHotkey takes integer this,string value returns integer
            local string positionString= "%k"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + I2S(GetLocalizedHotkey(value)) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + I2S(GetLocalizedHotkey(value)) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("localizedHotkey", "string", "k", "I2S(GetLocalizedHotkey(value))", "")
//textmacro instance: AFormatMethod("e", "integer", "e", "GetExternalString(value)", "")
        function s__AFormat_e takes integer this,integer value returns integer
            local string positionString= "%e"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + GetExternalString(value) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + GetExternalString(value) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("e", "integer", "e", "GetExternalString(value)", "")
//textmacro instance: AFormatMethod("externalString", "integer", "e", "GetExternalString(value)", "")
        function s__AFormat_externalString takes integer this,integer value returns integer
            local string positionString= "%e"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + GetExternalString(value) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + GetExternalString(value) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("externalString", "integer", "e", "GetExternalString(value)", "")
    /// Use seconds as parameter!
//textmacro instance: AFormatMethod("t", "integer", "t", "FormatTimeString(value)", "")
        function s__AFormat_t takes integer this,integer value returns integer
            local string positionString= "%t"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + FormatTimeString(value) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + FormatTimeString(value) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("t", "integer", "t", "FormatTimeString(value)", "")
    /// Use seconds as parameter!
//textmacro instance: AFormatMethod("time", "integer", "t", "FormatTimeString(value)", "")
        function s__AFormat_time takes integer this,integer value returns integer
            local string positionString= "%t"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + FormatTimeString(value) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + FormatTimeString(value) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("time", "integer", "t", "FormatTimeString(value)", "")

    
    function s__AFormat_result takes integer this returns string
        local string result= s__AFormat_m_text[this]
        call s__AFormat_deallocate(this)
        return result
    endfunction

    
    function s__AFormat_create takes string text returns integer
        local integer this= s__AFormat__allocate()
        set s__AFormat_m_position[this]=0
        set s__AFormat_m_text[this]=text
        return this
    endfunction


function String takes integer format returns string
    return s__AFormat_result(format)
endfunction


function Format takes string text returns integer
    return s__AFormat_create(text)
endfunction


//library StringFormat ends
//library MapConfigs:


function MapConfigs___Init takes nothing returns nothing
    call SetPagedButtonsConfigHeroCostsDefault(425 , 100)
    call AddPagedButtonsConfigHero(PALADIN , 0 , 0 , 1 , 3 , 30 , 120 , "units\\human\\HeroPaladin\\HeroPaladin")
    call AddPagedButtonsConfigUnit(BLACK_DRAGON_WHELP , 1 , 1 , 160 , 440 , "units\\creeps\\BlackDragonWelp\\BlackDragonWelp")
    call AddPagedButtonsConfigUnit(BLACK_DRAKE , 1 , 1 , 310 , 440 , "units\\creeps\\BlackDragon\\BlackDragon")
    call AddPagedButtonsConfigUnit(BLACK_DRAGON , 1 , 1 , 510 , 920 , "units\\creeps\\BlackDragon\\BlackDragon")
    call AddPagedButtonsConfigItem(BOOTS_OF_SPEED , 1 , 1 , 5 , 0)
    call AddPagedButtonsConfigItem(RING_OF_PROTECTION_1 , 1 , 1 , 0 , 0)
    call AddPagedButtonsConfigItem(RING_OF_PROTECTION_2 , 1 , 1 , 0 , 0)
    call AddPagedButtonsConfigItem(RING_OF_PROTECTION_3 , 1 , 1 , 0 , 0)
    call AddPagedButtonsConfigItem(RING_OF_PROTECTION_4 , 1 , 1 , 0 , 0)
    call AddPagedButtonsConfigItem(RING_OF_PROTECTION_5 , 1 , 1 , 0 , 0)
endfunction


//library MapConfigs ends
//library PagedButtons:



function GetTriggerShop takes nothing returns unit
    return PagedButtons___triggerShop
endfunction

function GetTriggerPreviousPage takes nothing returns integer
    return PagedButtons___triggerPreviousPage
endfunction

function GetTriggerAvailableObject takes nothing returns integer
    return PagedButtons___triggerAvailableObject
endfunction

function TriggerRegisterChangePagedButtons takes trigger whichTrigger returns nothing
    set PagedButtons___callbackTriggersChangePageButtons[PagedButtons___callbackTriggersChangePageButtonsCounter]=whichTrigger
    set PagedButtons___callbackTriggersChangePageButtonsCounter=PagedButtons___callbackTriggersChangePageButtonsCounter + 1
endfunction

function TriggerRegisterObjectAvailable takes trigger whichTrigger returns nothing
    set PagedButtons___callbackTriggersObjectAvailable[PagedButtons___callbackTriggersObjectAvailableCounter]=whichTrigger
    set PagedButtons___callbackTriggersObjectAvailableCounter=PagedButtons___callbackTriggersObjectAvailableCounter + 1
endfunction

function PagedButtons___ExecuteChangedPageButtonsCallbacks takes unit shop,integer previousPage returns nothing
    local integer i= 0
    set PagedButtons___triggerShop=shop
    set PagedButtons___triggerPreviousPage=previousPage
    set i=0
    loop
        exitwhen ( i == PagedButtons___callbackTriggersChangePageButtonsCounter )
        if ( IsTriggerEnabled(PagedButtons___callbackTriggersChangePageButtons[i]) ) then
            call ConditionalTriggerExecute(PagedButtons___callbackTriggersChangePageButtons[i])
        endif
        set i=i + 1
    endloop
endfunction

function PagedButtons___ExecuteObjectAvailableCallbacks takes unit shop,integer objectId returns nothing
    local integer i= 0
    set PagedButtons___triggerShop=shop
    set PagedButtons___triggerAvailableObject=objectId
    set i=0
    loop
        exitwhen ( i == PagedButtons___callbackTriggersObjectAvailableCounter )
        if ( IsTriggerEnabled(PagedButtons___callbackTriggersObjectAvailable[i]) ) then
            call ConditionalTriggerExecute(PagedButtons___callbackTriggersObjectAvailable[i])
        endif
        set i=i + 1
    endloop
endfunction

    
    function s__PagedButtons_Type_isSpacer takes integer this returns boolean
        return s__PagedButtons_Type_whichType[this] == PagedButtons_BUTTON_TYPE_SPACER
    endfunction
    

// Use a separate type for spacers to save memory.

    function s__PagedButtons_SpacerType_create takes nothing returns integer
        local integer this= s__PagedButtons_SpacerType__allocate()
        set s__PagedButtons_Type_whichType[this]=PagedButtons_BUTTON_TYPE_SPACER
        return this
    endfunction
    
    function s__PagedButtons_SpacerType_onDestroy takes integer this returns nothing
    endfunction

    

    function s__PagedButtons_SlotType_create takes unit shop,integer id,integer whichType,integer currentStock,integer startStock,integer maxStock,integer startDelay,integer replenishInterval returns integer
        local integer this= s__PagedButtons_SlotType__allocate()
        set s__PagedButtons_SlotType_shop[this]=shop
        set s__PagedButtons_SlotType_id[this]=id
        set s__PagedButtons_Type_whichType[this]=whichType
        set s__PagedButtons_SlotType_currentStock[this]=currentStock
        set s__PagedButtons_SlotType_startStock[this]=startStock
        set s__PagedButtons_SlotType_maxStock[this]=maxStock
        set s__PagedButtons_SlotType_startDelay[this]=startDelay
        set s__PagedButtons_SlotType_replenishInterval[this]=replenishInterval
        set s__PagedButtons_SlotType_elapsedTimeStartDelay[this]=0
        set s__PagedButtons_SlotType_elapsedTimeReplenishInterval[this]=0
        
        set s__PagedButtons_SlotType_list[s__PagedButtons_SlotType_listCounter]=this
        set s__PagedButtons_SlotType_listCounter=s__PagedButtons_SlotType_listCounter + 1
        
        return this
    endfunction
    
    function s__PagedButtons_SlotType_onDestroy takes integer this returns nothing
        local boolean found= false
        local integer i= 0
        loop
            exitwhen ( i >= s__PagedButtons_SlotType_listCounter )
            if ( s__PagedButtons_SlotType_list[i] == this ) then
                set found=true
            endif
            if ( found ) then
                set s__PagedButtons_SlotType_list[i]=s__PagedButtons_SlotType_list[i + 1]
                set s__PagedButtons_SlotType_list[i + 1]=0
            endif
            set i=i + 1
        endloop
        if ( found ) then
            set s__PagedButtons_SlotType_listCounter=s__PagedButtons_SlotType_listCounter - 1
        endif
    endfunction
    
    function s__PagedButtons_SlotType_timerFunctionUpdateTime takes nothing returns nothing
        local boolean updated= false
        local integer elapsedSeconds= 1
        local integer i= 0
        local integer this= 0
        loop
            exitwhen ( i >= s__PagedButtons_SlotType_listCounter )
            set this=s__PagedButtons_SlotType_list[i]
            if ( s__PagedButtons_SlotType_replenish[this] ) then
                set updated=false
                
                if ( not s__PagedButtons_SlotType_startDelayDone[this] ) then
                    set s__PagedButtons_SlotType_elapsedTimeStartDelay[this]=s__PagedButtons_SlotType_elapsedTimeStartDelay[this] + elapsedSeconds
                    if ( s__PagedButtons_SlotType_elapsedTimeStartDelay[this] >= s__PagedButtons_SlotType_startDelay[this] ) then
                        if ( s__PagedButtons_SlotType_currentStock[this] < s__PagedButtons_SlotType_maxStock[this] ) then
                            set s__PagedButtons_SlotType_currentStock[this]=s__PagedButtons_SlotType_currentStock[this] + 1
                            set updated=true
                        endif
                        set s__PagedButtons_SlotType_elapsedTimeStartDelay[this]=0
                        set s__PagedButtons_SlotType_startDelayDone[this]=true
                    endif
                endif
                
                if ( s__PagedButtons_SlotType_currentStock[this] < s__PagedButtons_SlotType_maxStock[this] ) then
                    set s__PagedButtons_SlotType_elapsedTimeReplenishInterval[this]=s__PagedButtons_SlotType_elapsedTimeReplenishInterval[this] + elapsedSeconds
                    //if (this.id == BOOTS_OF_SPEED) then
                    //    call BJDebugMsg("Elapsed seconds for " + GetObjectName(this.id) + " - " + I2S(elapsedSeconds) + " resulting in total elapsed: " + I2S(this.elapsedTimeReplenishInterval))
                    //endif
                    if ( s__PagedButtons_SlotType_elapsedTimeReplenishInterval[this] >= s__PagedButtons_SlotType_replenishInterval[this] ) then
                        if ( s__PagedButtons_SlotType_currentStock[this] < s__PagedButtons_SlotType_maxStock[this] ) then
                            set s__PagedButtons_SlotType_currentStock[this]=s__PagedButtons_SlotType_currentStock[this] + 1
                            set updated=true
                        endif
                        set s__PagedButtons_SlotType_elapsedTimeReplenishInterval[this]=0
                    endif
                endif
                if ( updated ) then
                    if ( s__PagedButtons_Type_shown[this] and s__PagedButtons_Type_enabled[this] ) then
                        if ( s__PagedButtons_Type_whichType[this] == PagedButtons_BUTTON_TYPE_UNIT ) then
                            // TODO Removes different unit when the stock is still in delay.
                            call AddUnitToStock(s__PagedButtons_SlotType_shop[this], s__PagedButtons_SlotType_id[this], s__PagedButtons_SlotType_currentStock[this], s__PagedButtons_SlotType_maxStock[this])
                        elseif ( s__PagedButtons_Type_whichType[this] == PagedButtons_BUTTON_TYPE_ITEM ) then
                            // TODO Removes different item when the stock is still in delay.
                            //call BJDebugMsg("Making item available again: " + GetObjectName(this.id))
                            call AddItemToStock(s__PagedButtons_SlotType_shop[this], s__PagedButtons_SlotType_id[this], s__PagedButtons_SlotType_currentStock[this], s__PagedButtons_SlotType_maxStock[this])
                        else
                            // Do nothing for abilities.
                        endif
                    endif
                    
                    call PagedButtons___ExecuteObjectAvailableCallbacks(s__PagedButtons_SlotType_shop[this] , s__PagedButtons_SlotType_id[this])
                endif
            endif
            set i=i + 1
        endloop
    endfunction



    
    function s__PagedButtons_Shop_removeButton takes integer this,integer index returns nothing
        loop
            exitwhen ( index >= s__PagedButtons_Shop_buttonsCount[this] )
            set s___PagedButtons_Shop_buttons[s__PagedButtons_Shop_buttons[this]+index]=s___PagedButtons_Shop_buttons[s__PagedButtons_Shop_buttons[this]+index + 1]
            set s___PagedButtons_Shop_buttons[s__PagedButtons_Shop_buttons[this]+index + 1]=0
            set index=index + 1
        endloop
        set s__PagedButtons_Shop_buttonsCount[this]=s__PagedButtons_Shop_buttonsCount[this] - 1
    endfunction
    
    function s__PagedButtons_Shop_create takes string name returns integer
        local integer this= s__PagedButtons_Shop__allocate()
        set s__PagedButtons_Shop_name[this]=name
        return this
    endfunction
    

function GetPagedButtonsShop takes unit shop returns integer
    return LoadInteger(PagedButtons___h, GetHandleId(shop), 0)
endfunction

function SetPagedButtonsShop takes unit shop,integer s returns nothing
    call SaveInteger(PagedButtons___h, GetHandleId(shop), 0, s)
endfunction

function GetPagedButtonsCount takes unit shop returns integer
    local integer s= (LoadInteger(PagedButtons___h, GetHandleId((shop)), 0)) // INLINED!!
    if ( s != 0 ) then
        return s__PagedButtons_Shop_buttonsCount[s]
    endif
    return 0
endfunction

function GetPagedButtonsNonSpacerButtonsCount takes unit shop returns integer
    local integer x= (LoadInteger(PagedButtons___h, GetHandleId((shop)), 0)) // INLINED!!
    local integer result= 0
    local integer t= 0
    local integer i= 0
    loop
        exitwhen ( i >= s__PagedButtons_Shop_buttonsCount[x] )
        set t=s___PagedButtons_Shop_buttons[s__PagedButtons_Shop_buttons[x]+i]
        if ( not (s__PagedButtons_Type_whichType[(t)] == PagedButtons_BUTTON_TYPE_SPACER) ) then // INLINED!!
            set result=result + 1
        endif
        set i=i + 1
    endloop
    return result
endfunction

function GetPagedButton takes unit shop,integer index returns integer
    local integer x= (LoadInteger(PagedButtons___h, GetHandleId((shop)), 0)) // INLINED!!
    
    return s___PagedButtons_Shop_buttons[s__PagedButtons_Shop_buttons[x]+index]
endfunction

function GetPagedButtonIndex takes unit shop,integer id returns integer
    local integer x= (LoadInteger(PagedButtons___h, GetHandleId((shop)), 0)) // INLINED!!
    local integer t= 0
    local integer s= 0
    local integer i= 0
    loop
        exitwhen ( i >= s__PagedButtons_Shop_buttonsCount[x] )
        set t=s___PagedButtons_Shop_buttons[s__PagedButtons_Shop_buttons[x]+i]
        if ( not (s__PagedButtons_Type_whichType[(t)] == PagedButtons_BUTTON_TYPE_SPACER) ) then // INLINED!!
            set s=(t)
            if ( s__PagedButtons_SlotType_id[s] == id ) then
                return i
            endif
        endif
        set i=i + 1
    endloop
    return - 1
endfunction

function GetPagedButtonIndexEx takes unit shop,integer id,integer index returns integer
    local integer x= (LoadInteger(PagedButtons___h, GetHandleId((shop)), 0)) // INLINED!!
    local integer t= 0
    local integer s= 0
    local integer i= 0
    local integer currentIndex= 0
    loop
        exitwhen ( i >= s__PagedButtons_Shop_buttonsCount[x] )
        set t=s___PagedButtons_Shop_buttons[s__PagedButtons_Shop_buttons[x]+i]
        if ( not (s__PagedButtons_Type_whichType[(t)] == PagedButtons_BUTTON_TYPE_SPACER) ) then // INLINED!!
            set s=(t)
            if ( s__PagedButtons_SlotType_id[s] == id ) then
                if ( currentIndex == index ) then
                    return i
                endif
                set currentIndex=currentIndex + 1
            endif
        endif
        set i=i + 1
    endloop
    return - 1
endfunction

function GetPagedButtonsCountEx takes unit shop,integer id returns integer
    local integer x= (LoadInteger(PagedButtons___h, GetHandleId((shop)), 0)) // INLINED!!
    local integer t= 0
    local integer s= 0
    local integer i= 0
    local integer count= 0
    loop
        exitwhen ( i >= s__PagedButtons_Shop_buttonsCount[x] )
        set t=s___PagedButtons_Shop_buttons[s__PagedButtons_Shop_buttons[x]+i]
        if ( not (s__PagedButtons_Type_whichType[(t)] == PagedButtons_BUTTON_TYPE_SPACER) ) then // INLINED!!
            set s=(t)
            if ( s__PagedButtons_SlotType_id[s] == id ) then
                set count=count + 1
            endif
        endif
        set i=i + 1
    endloop
    return count
endfunction

function IsPagedButtonShown takes unit shop,integer index returns boolean
    return s__PagedButtons_Type_shown[GetPagedButton(shop , index)]
endfunction

function IsPagedButtonEnabled takes unit shop,integer index returns boolean
    return s__PagedButtons_Type_enabled[GetPagedButton(shop , index)]
endfunction

function GetPagedButtonId takes unit shop,integer index returns integer
    if ( GetPagedButton(shop , index) == 0 ) then
        return 0
    endif
    return s__PagedButtons_SlotType_id[(GetPagedButton(shop , index))]
endfunction

function IsPagedButtonUnit takes unit shop,integer index returns boolean
    return s__PagedButtons_Type_whichType[GetPagedButton(shop , index)] == PagedButtons_BUTTON_TYPE_UNIT
endfunction

function IsPagedButtonItem takes unit shop,integer index returns boolean
    return s__PagedButtons_Type_whichType[GetPagedButton(shop , index)] == PagedButtons_BUTTON_TYPE_ITEM
endfunction

function IsPagedButtonAbility takes unit shop,integer index returns boolean
    return s__PagedButtons_Type_whichType[GetPagedButton(shop , index)] == PagedButtons_BUTTON_TYPE_ABILITY
endfunction

function IsPagedButtonSpacer takes unit shop,integer index returns boolean
    return s__PagedButtons_Type_whichType[GetPagedButton(shop , index)] == PagedButtons_BUTTON_TYPE_SPACER
endfunction

function GetPagedButtonType takes unit shop,integer id returns integer
    local integer x= (LoadInteger(PagedButtons___h, GetHandleId((shop)), 0)) // INLINED!!
    local integer result= 0
    local integer t= 0
    local integer s= 0
    local integer i= 0
    loop
        exitwhen ( i >= s__PagedButtons_Shop_buttonsCount[x] or result != 0 )
        set t=s___PagedButtons_Shop_buttons[s__PagedButtons_Shop_buttons[x]+i]
        if ( not (s__PagedButtons_Type_whichType[(t)] == PagedButtons_BUTTON_TYPE_SPACER) ) then // INLINED!!
            set s=(t)
            if ( s__PagedButtons_SlotType_id[s] == id ) then
                set result=t
            endif
        endif
        set i=i + 1
    endloop
    return result
endfunction

function HasPagedButtonsId takes unit shop,integer id returns boolean
    return GetPagedButtonType(shop , id) != 0
endfunction

function IsPagedButtonsIdUnit takes unit shop,integer id returns boolean
    local integer s= GetPagedButtonType(shop , id)
    if ( s != 0 ) then
        return s__PagedButtons_Type_whichType[s] == PagedButtons_BUTTON_TYPE_UNIT
    endif
    return false
endfunction

function GetPagedButtonsSlotsPerPage takes unit shop returns integer
    local integer s= (LoadInteger(PagedButtons___h, GetHandleId((shop)), 0)) // INLINED!!
    if ( s != 0 ) then
        return s__PagedButtons_Shop_slotsPerPage[s]
    endif
    return 0
endfunction

function GetPagedButtonsPage takes unit shop returns integer
    local integer s= (LoadInteger(PagedButtons___h, GetHandleId((shop)), 0)) // INLINED!!
    if ( s != 0 ) then
        return s__PagedButtons_Shop_currentPage[s]
    endif
    return 0
endfunction

function GetPagedButtonsMaxPages takes unit shop returns integer
    local integer s= (LoadInteger(PagedButtons___h, GetHandleId((shop)), 0)) // INLINED!!
    if ( s != 0 ) then
        return s__PagedButtons_Shop_maxPages[s]
    endif
    return 0
endfunction

function GetPagedButtonsShopPage takes unit shop,integer page returns integer
    local integer s= (LoadInteger(PagedButtons___h, GetHandleId((shop)), 0)) // INLINED!!
    if ( s != 0 and page >= 0 and page < s__PagedButtons_Shop_maxPages[s] ) then
        return s___PagedButtons_Shop_pages[s__PagedButtons_Shop_pages[s]+page]
    endif
    return 0
endfunction

function PagedButtons___PrintPages takes unit shop returns nothing
    local integer s= (LoadInteger(PagedButtons___h, GetHandleId((shop)), 0)) // INLINED!!
    local integer p= 0
    local integer i= 0
    if ( s != 0 ) then
        //call BJDebugMsg("Pages count: " + I2S(s.maxPages))
        loop
            exitwhen ( i >= s__PagedButtons_Shop_maxPages[s] )
            set p=s___PagedButtons_Shop_pages[s__PagedButtons_Shop_pages[s]+i]
            //call BJDebugMsg("Page name: " + p.name)
            set i=i + 1
        endloop
    endif
endfunction

function GetPagedButtonsPageName takes unit shop,integer page returns string
    local integer p= GetPagedButtonsShopPage(shop , page)
    if ( p != 0 ) then
        //call BJDebugMsg("Shop " + GetUnitName(shop) + " page name of page " + I2S(page) + ": " + p.name)
        return s__PagedButtons_Page_name[p]
    endif
    //call BJDebugMsg("Shop "  + GetUnitName(shop) + " page name of page " + I2S(page) + " is not set.")
    return null
endfunction

function SetPagedButtonsPageName takes unit shop,integer page,string name returns nothing
    local integer p= GetPagedButtonsShopPage(shop , page)
    if ( p != 0 ) then
        set s__PagedButtons_Page_name[p]=name
    endif
    //call PrintPages(shop)
endfunction

function SetPagedButtonsCurrentPageName takes unit shop,string name returns nothing
    call SetPagedButtonsPageName(shop , GetPagedButtonsPage(shop) , name)
endfunction

function PagedButtons___ChangeShopUnitName takes unit shop returns nothing
    local integer s= (LoadInteger(PagedButtons___h, GetHandleId((shop)), 0)) // INLINED!!
    local integer currentPage= GetPagedButtonsPage(shop)
    local string pageName= GetPagedButtonsPageName(shop , s__PagedButtons_Shop_currentPage[s])
    local string unitName= s__PagedButtons_Shop_name[s]
    //call BJDebugMsg("Change shop unit name to page " + I2S(s.currentPage) + ": " + pageName)
    if ( unitName == null ) then
        set unitName=""
    endif
    if ( pageName != null ) then
        if ( StringLength(unitName) > 0 and unitName != " " ) then
            call BlzSetUnitName(shop, unitName + " " + pageName)
        else
            call BlzSetUnitName(shop, pageName)
        endif
    else
        call BlzSetUnitName(shop, unitName)
    endif
endfunction

function PagedButtons___ResetShopUnitName takes unit shop returns nothing
     local integer s= (LoadInteger(PagedButtons___h, GetHandleId((shop)), 0)) // INLINED!!
    local string unitName= s__PagedButtons_Shop_name[s]
    if ( unitName == null ) then
        set unitName=""
    endif
    call BlzSetUnitName(shop, unitName)
endfunction

function PagedButtons___HidePagedButtonsCurrentPage takes unit shop returns nothing
    local integer x= (LoadInteger(PagedButtons___h, GetHandleId((shop)), 0)) // INLINED!!
    local integer maxPages= s__PagedButtons_Shop_maxPages[x]
    local integer totalCounter= s__PagedButtons_Shop_buttonsCount[x]
    local integer countUnits= 0
    local integer countItems= 0
    local integer slotsPerPage= s__PagedButtons_Shop_slotsPerPage[x]
    local integer currentPage= s__PagedButtons_Shop_currentPage[x]
    local integer i= currentPage * slotsPerPage
    local integer count= i + IMinBJ(slotsPerPage, totalCounter - currentPage * slotsPerPage)
    local integer t= GetPagedButton(shop , i)
    local integer s= 0
    loop
        exitwhen ( i >= count )
        set t=s___PagedButtons_Shop_buttons[s__PagedButtons_Shop_buttons[x]+i]
        if ( not (s__PagedButtons_Type_whichType[(t)] == PagedButtons_BUTTON_TYPE_SPACER) and s__PagedButtons_Type_enabled[t] ) then // INLINED!!
            set s=(t)
            if ( s__PagedButtons_Type_whichType[s] == PagedButtons_BUTTON_TYPE_UNIT ) then
                call RemoveUnitFromStock(shop, s__PagedButtons_SlotType_id[s])
            elseif ( s__PagedButtons_Type_whichType[s] == PagedButtons_BUTTON_TYPE_ITEM ) then
                call RemoveItemFromStock(shop, s__PagedButtons_SlotType_id[s])
            else
                call UnitRemoveAbility(shop, s__PagedButtons_SlotType_id[s])
            endif
        endif
        set s__PagedButtons_Type_shown[t]=false
        set i=i + 1
    endloop
    call SetUnitTypeSlots(shop, 0)
    call SetItemTypeSlots(shop, 0)
endfunction

function PagedButtons___ShowPagedButtonsCurrentPage takes unit shop returns nothing
    local integer x= (LoadInteger(PagedButtons___h, GetHandleId((shop)), 0)) // INLINED!!
    local integer maxPages= s__PagedButtons_Shop_maxPages[x]
    local integer currentPage= s__PagedButtons_Shop_currentPage[x]
    local integer totalCounter= s__PagedButtons_Shop_buttonsCount[x]
    local integer countUnits= 0
    local integer countItems= 0
    local integer nextPage= 0
    local integer previousPage= 0
    local integer slotsPerPage= GetPagedButtonsSlotsPerPage(shop)
    local integer i= currentPage * slotsPerPage
    local integer count= i + IMinBJ(slotsPerPage, totalCounter - currentPage * slotsPerPage)
    local integer t= GetPagedButton(shop , i)
    local integer s= 0
    if ( not PagedButtons_HIDE_PAGE_BUTTONS_FOR_ONE_PAGE or maxPages > 1 ) then
        call SetUnitTypeSlots(shop, 2)



















        set nextPage=currentPage + 1
        set previousPage=currentPage + 1

        
        call AddUnitToStock(shop, PagedButtons_NEXT_PAGE_ID, nextPage, nextPage)
        call AddUnitToStock(shop, PagedButtons_PREVIOUS_PAGE_ID, previousPage, previousPage)

    else
        call RemoveUnitFromStock(shop, PagedButtons_NEXT_PAGE_ID)
        call RemoveUnitFromStock(shop, PagedButtons_PREVIOUS_PAGE_ID)
        call SetUnitTypeSlots(shop, 0)
    endif
    if ( not PagedButtons_HIDE_PAGE_BUTTONS_FOR_ONE_PAGE or maxPages > 1 ) then
        set countUnits=2
    endif
    //call BJDebugMsg("Showing page "  + I2S(currentPage) + " with buttons " + I2S(count - i) + " starting at index " + I2S(i) + " and ending at index " + I2S(count) + " and starting with button instance " + I2S(t) + " with max pages " + I2S(maxPages))
    loop
        exitwhen ( i >= count )
        set t=s___PagedButtons_Shop_buttons[s__PagedButtons_Shop_buttons[x]+i]
        //call BJDebugMsg("Checking instance " + I2S(t))
        if ( not (s__PagedButtons_Type_whichType[(t)] == PagedButtons_BUTTON_TYPE_SPACER) and s__PagedButtons_Type_enabled[t] ) then // INLINED!!
            set s=(t)
            //call BJDebugMsg("Adding "  + GetObjectName(s.id))
            if ( s__PagedButtons_Type_whichType[s] == PagedButtons_BUTTON_TYPE_UNIT ) then
                set countUnits=countUnits + 1
                call SetUnitTypeSlots(shop, countUnits)
                call AddUnitToStock(shop, s__PagedButtons_SlotType_id[s], s__PagedButtons_SlotType_currentStock[s], s__PagedButtons_SlotType_maxStock[s])
            elseif ( s__PagedButtons_Type_whichType[s] == PagedButtons_BUTTON_TYPE_ITEM ) then
                set countItems=countItems + 1
                call SetItemTypeSlots(shop, countItems)
                call AddItemToStock(shop, s__PagedButtons_SlotType_id[s], s__PagedButtons_SlotType_currentStock[s], s__PagedButtons_SlotType_maxStock[s])
            else
                call UnitAddAbility(shop, s__PagedButtons_SlotType_id[s])
            endif
        else
            //call BJDebugMsg("Not enabled or spacer.")
        endif
        set s__PagedButtons_Type_shown[t]=true
        set i=i + 1
    endloop

    call PagedButtons___ChangeShopUnitName(shop)


// show the page buttons afterwards to make sure that they have a higher priority than the unit buttons
if ( not PagedButtons_HIDE_PAGE_BUTTONS_FOR_ONE_PAGE or maxPages > 1 ) then




    call AddUnitToStock(shop, PagedButtons_NEXT_PAGE_ID, nextPage, nextPage)
    call AddUnitToStock(shop, PagedButtons_PREVIOUS_PAGE_ID, previousPage, previousPage)

endif
endfunction

function SetPagedButtonsPage takes unit shop,integer page returns nothing
    local integer s= (LoadInteger(PagedButtons___h, GetHandleId((shop)), 0)) // INLINED!!
    local integer currentPage= s__PagedButtons_Shop_currentPage[s]
    call PagedButtons___HidePagedButtonsCurrentPage(shop)
    set s__PagedButtons_Shop_currentPage[s]=page
    call PagedButtons___ShowPagedButtonsCurrentPage(shop)

    call PagedButtons___ChangeShopUnitName(shop)

    call PagedButtons___ExecuteChangedPageButtonsCallbacks(shop , currentPage)
endfunction

function SetPagedButtonEnabled takes unit shop,integer index,boolean enabled returns nothing
    set s__PagedButtons_Type_enabled[GetPagedButton(shop , index)]=enabled
    // refresh
    call SetPagedButtonsPage(shop , GetPagedButtonsPage(shop))
endfunction

function PagedButtons___RefreshMaxPagesEx takes unit shop,integer maxPages returns nothing
    local integer s= (LoadInteger(PagedButtons___h, GetHandleId((shop)), 0)) // INLINED!!
    local integer oldMaxPages= s__PagedButtons_Shop_maxPages[s]
    local integer i= 0
    set s__PagedButtons_Shop_maxPages[s]=maxPages
    // create all missing pages instances
    if ( maxPages > oldMaxPages ) then
        set i=oldMaxPages
        loop
            exitwhen ( i >= maxPages )
            if ( s___PagedButtons_Shop_pages[s__PagedButtons_Shop_pages[s]+i] == 0 ) then
                set s___PagedButtons_Shop_pages[s__PagedButtons_Shop_pages[s]+i]=s__PagedButtons_Page__allocate()
                if ( i > 0 ) then
                    set s__PagedButtons_Page_name[s___PagedButtons_Shop_pages[s__PagedButtons_Shop_pages[s]+i]]=s__PagedButtons_Page_name[s___PagedButtons_Shop_pages[s__PagedButtons_Shop_pages[s]+i - 1]] // copy the previous page name
                endif
            endif
            set i=i + 1
        endloop
    // remove too many pages instances
    elseif ( maxPages < oldMaxPages ) then
        set i=oldMaxPages
        loop
            exitwhen ( i < maxPages )
            if ( s___PagedButtons_Shop_pages[s__PagedButtons_Shop_pages[s]+i] == 0 ) then
                set s___PagedButtons_Shop_pages[s__PagedButtons_Shop_pages[s]+i]=0
                call s__PagedButtons_Page_deallocate(s___PagedButtons_Shop_pages[s__PagedButtons_Shop_pages[s]+i])
            endif
            set i=i - 1
        endloop
    endif
endfunction

function PagedButtons___RefreshMaxPages takes unit shop returns nothing
    local integer s= (LoadInteger(PagedButtons___h, GetHandleId((shop)), 0)) // INLINED!!
    local integer count= s__PagedButtons_Shop_buttonsCount[s]
    local integer slots= s__PagedButtons_Shop_slotsPerPage[s]
    local integer maxPages= count / slots
    if ( ModuloInteger(count, slots) > 0 ) then
        set maxPages=maxPages + 1
    endif
    set maxPages=IMaxBJ(maxPages, 1)
    call PagedButtons___RefreshMaxPagesEx(shop , maxPages)
endfunction

function RemovePagedButtonsIndex takes unit shop,integer index returns boolean
    local integer s= (LoadInteger(PagedButtons___h, GetHandleId((shop)), 0)) // INLINED!!
    local integer t= 0
    if ( s != 0 and index >= 0 and index <= s__PagedButtons_Shop_buttonsCount[s] ) then
        set t=s___PagedButtons_Shop_buttons[s__PagedButtons_Shop_buttons[s]+index]
        if ( s__PagedButtons_Type_shown[t] ) then
            if ( s__PagedButtons_Type_whichType[t] == PagedButtons_BUTTON_TYPE_UNIT ) then
                call RemoveUnitFromStock(shop, s__PagedButtons_SlotType_id[(t)])
            elseif ( s__PagedButtons_Type_whichType[t] == PagedButtons_BUTTON_TYPE_ITEM ) then
                call RemoveItemFromStock(shop, s__PagedButtons_SlotType_id[(t)])
            elseif ( s__PagedButtons_Type_whichType[t] == PagedButtons_BUTTON_TYPE_ITEM ) then
                call UnitRemoveAbility(shop, s__PagedButtons_SlotType_id[(t)])
            endif
        endif
    
        call s__PagedButtons_Shop_removeButton(s,index)
        call sc__PagedButtons_Type_deallocate(t)
        
        // update buttons
        call PagedButtons___RefreshMaxPages(shop)
        call SetPagedButtonsPage(shop , IMaxBJ(0, IMinBJ(GetPagedButtonsPage(shop), s__PagedButtons_Shop_maxPages[s] - 1)))
        
        return true
    endif
    
    return false
endfunction

function RemovePagedButtonsId takes unit shop,integer id returns boolean
    local integer index= GetPagedButtonIndex(shop , id)
    if ( index != - 1 ) then
        return RemovePagedButtonsIndex(shop , index)
    endif
    
    return false
endfunction

function SetPagedButtonsSlotsPerPage takes unit shop,integer slots returns nothing
    local integer s= (LoadInteger(PagedButtons___h, GetHandleId((shop)), 0)) // INLINED!!
    set s__PagedButtons_Shop_slotsPerPage[s]=slots
    call PagedButtons___RefreshMaxPages(shop)
    call SetPagedButtonsPage(shop , GetPagedButtonsPage(shop))
endfunction

function PagedButtons___AddPageButtonsIdType takes unit shop,integer id,integer whichType returns integer
    local integer startStock= 1
    local integer currentStock= 1
    local integer maxStock= 1
    local integer startDelay= 0
    local integer replenishInterval= 30

    local integer c=  GetPagedButtonsConfig(id)
    set startStock=s__PagedButtonsConfig_stockInitialAfterStartDelay[c]
    set maxStock=s__PagedButtonsConfig_stockMaximum[c]
    set startDelay=s__PagedButtonsConfig_stockStartDelay[c]
    if ( startDelay > 0 ) then
         set startDelay=startDelay + PagedButtons_STOCK_DELAY_THRESHOLD
    endif
    set replenishInterval=s__PagedButtonsConfig_stockReplenishInterval[c]
    if ( replenishInterval > 0 ) then
        set replenishInterval=replenishInterval + PagedButtons_STOCK_DELAY_THRESHOLD
    endif
    
    if ( startDelay > 0 ) then
        set currentStock=0
    endif

    return s__PagedButtons_SlotType_create(shop , id , whichType , currentStock , startStock , maxStock , startDelay , replenishInterval)
endfunction

function AddPagedButtonsId takes unit shop,integer id,integer whichType returns integer
    local integer s= (LoadInteger(PagedButtons___h, GetHandleId((shop)), 0)) // INLINED!!
    local integer t= 0
    local integer index= 0
    
    if ( s == 0 ) then
        return - 1
    endif
    set index=s__PagedButtons_Shop_buttonsCount[s]
    if ( whichType == PagedButtons_BUTTON_TYPE_SPACER ) then
        set t=s__PagedButtons_SpacerType_create()
    else
        set t=PagedButtons___AddPageButtonsIdType(shop , id , whichType)
    endif
    set s___PagedButtons_Shop_buttons[s__PagedButtons_Shop_buttons[s]+index]=t
    set s__PagedButtons_Shop_buttonsCount[s]=index + 1
    call PagedButtons___RefreshMaxPages(shop)
    call SetPagedButtonsPage(shop , GetPagedButtonsPage(shop))
    
    //call BJDebugMsg("Added ID " + GetObjectName(id) + " to shop " + GetUnitName(shop) + " resulting in " + I2S(s.buttons.getSize()) + " buttons and " + I2S(s.maxPages) + " max pages.")
    
    return index
endfunction

function AddPagedButtonsUnitType takes unit shop,integer id returns integer
    return AddPagedButtonsId(shop , id , PagedButtons_BUTTON_TYPE_UNIT)
endfunction

function AddPagedButtonsItemType takes unit shop,integer id returns integer
    return AddPagedButtonsId(shop , id , PagedButtons_BUTTON_TYPE_ITEM)
endfunction

function AddPagedButtonsAbility takes unit shop,integer id returns integer
    return AddPagedButtonsId(shop , id , PagedButtons_BUTTON_TYPE_ABILITY)
endfunction

function AddPagedButtonsSpacer takes unit shop returns integer
    return AddPagedButtonsId(shop , 0 , PagedButtons_BUTTON_TYPE_SPACER)
endfunction

function AddPagedButtonsSpacers takes unit shop,integer counter returns nothing
    local integer i= 0
    loop
        exitwhen ( i == counter )
call AddPagedButtonsId((shop) , 0 , PagedButtons_BUTTON_TYPE_SPACER) // INLINED!!
        set i=i + 1
    endloop
endfunction

function GetPagedButtonsPageByIndex takes unit shop,integer index returns integer
    local integer s= (LoadInteger(PagedButtons___h, GetHandleId((shop)), 0)) // INLINED!!
    if ( s != 0 ) then
        return index / s__PagedButtons_Shop_slotsPerPage[s]
    endif
    return 0
endfunction

function AddPagedButtonsSpacersRemaining takes unit shop returns nothing
    local integer s= (LoadInteger(PagedButtons___h, GetHandleId((shop)), 0)) // INLINED!!
    local integer mod= 0
    if ( s != 0 ) then
        set mod=ModuloInteger(s__PagedButtons_Shop_buttonsCount[s], s__PagedButtons_Shop_slotsPerPage[s])
        if ( mod > 0 ) then
            call AddPagedButtonsSpacers(shop , s__PagedButtons_Shop_slotsPerPage[s] - mod)
        endif
    endif
endfunction

function NextPagedButtonsPage takes unit shop,string name returns integer
    local integer s= (LoadInteger(PagedButtons___h, GetHandleId((shop)), 0)) // INLINED!!
    local integer nextPage= 0
    if ( s != 0 ) then
        // find the next page
        loop
            exitwhen ( nextPage > s__PagedButtons_Shop_maxPages[s] or StringLength(s__PagedButtons_Page_name[s___PagedButtons_Shop_pages[s__PagedButtons_Shop_pages[s]+nextPage]]) == 0 )
            set nextPage=nextPage + 1
        endloop
        if ( nextPage > 0 ) then
            //call BJDebugMsg("Adding remaining spacers for page " + I2S(nextPage))
            call AddPagedButtonsSpacersRemaining(shop)
        endif
        call PagedButtons___RefreshMaxPagesEx(shop , nextPage + 1)
        //call BJDebugMsg("Setting name for next page " + I2S(nextPage) + ": " + name)
        call SetPagedButtonsPageName(shop , nextPage , name)
    

        call PagedButtons___ChangeShopUnitName(shop)

    
        //call BJDebugMsg("Set name for next page " + I2S(nextPage) + " to name " + name)
        return nextPage
    endif
    
    return - 1
endfunction

function HasPagedButtons takes unit shop returns boolean
    return IsUnitInGroup(shop, PagedButtons___shops)
endfunction

function EnablePagedButtons takes unit shop returns boolean
    if ( not (IsUnitInGroup((shop), PagedButtons___shops)) ) then // INLINED!!
        call UnitAddAbility(shop, PagedButtons_ABILITY_ID_SELL_UNITS)
        call UnitAddAbility(shop, PagedButtons_ABILITY_ID_SELL_ITEMS)
        call GroupAddUnit(PagedButtons___shops, shop)
        call SaveInteger(PagedButtons___h, GetHandleId((shop )), 0, ( s__PagedButtons_Shop_create(GetUnitName(shop)))) // INLINED!!
        call SetPagedButtonsSlotsPerPage(shop , PagedButtons_SLOTS_PER_PAGE)
        
        return true
    endif
    
    return false
endfunction

function PagedButtons___DestroyPagedButtonsShopTypes takes unit shop returns nothing
    local integer s= (LoadInteger(PagedButtons___h, GetHandleId((shop)), 0)) // INLINED!!
    call s__PagedButtons_Shop_deallocate(s)
endfunction

function DisablePagedButtons takes unit shop returns boolean
    if ( (IsUnitInGroup((shop), PagedButtons___shops)) ) then // INLINED!!

    call PagedButtons___ResetShopUnitName(shop)

        call RemoveUnitFromStock(shop, PagedButtons_NEXT_PAGE_ID)
        call RemoveUnitFromStock(shop, PagedButtons_PREVIOUS_PAGE_ID)
        call GroupRemoveUnit(PagedButtons___shops, shop)
        call PagedButtons___HidePagedButtonsCurrentPage(shop)
        call PagedButtons___DestroyPagedButtonsShopTypes(shop)
        call FlushChildHashtable(PagedButtons___h, GetHandleId(shop))
        
        return true
    endif
    
    return false
endfunction

function ChangePagedButtonsToNextPage takes unit shop returns nothing
    local integer s= (LoadInteger(PagedButtons___h, GetHandleId((shop)), 0)) // INLINED!!
    local integer currentPage= s__PagedButtons_Shop_currentPage[s]
    local integer maxPages= s__PagedButtons_Shop_maxPages[s]
    if ( currentPage == maxPages - 1 ) then
        call SetPagedButtonsPage(shop , 0)
    else
        call SetPagedButtonsPage(shop , currentPage + 1)
    endif
endfunction

function ChangePagedButtonsToPreviousPage takes unit shop returns nothing
    local integer s= (LoadInteger(PagedButtons___h, GetHandleId((shop)), 0)) // INLINED!!
    local integer currentPage= s__PagedButtons_Shop_currentPage[s]
    local integer maxPages= s__PagedButtons_Shop_maxPages[s]
    if ( currentPage == 0 ) then
        call SetPagedButtonsPage(shop , maxPages - 1)
    else
        call SetPagedButtonsPage(shop , currentPage - 1)
    endif
endfunction

function PagedButtons___TriggerConditionDeath takes nothing returns boolean

    call DisablePagedButtons(GetTriggerUnit())

    return false
endfunction

function PagedButtons___TriggerConditionSell takes nothing returns boolean
    return (IsUnitInGroup((GetSellingUnit()), PagedButtons___shops)) // INLINED!!
endfunction

function PagedButtons___DisplayMsg takes unit shop,unit buyingUnit returns nothing
    local player owner= GetOwningPlayer(buyingUnit)
    local integer currentPage= GetPagedButtonsPage(shop)
    local string msg= "Page " + I2S(currentPage + 1)
    local force whichForce= CreateForce()
    local player slotPlayer= null
    local integer i= 0
    loop
        exitwhen ( i == bj_MAX_PLAYERS )
        set slotPlayer=Player(i)
        if ( owner == slotPlayer or GetPlayerAlliance(owner, slotPlayer, ALLIANCE_SHARED_ADVANCED_CONTROL) or GetPlayerAlliance(owner, slotPlayer, ALLIANCE_SHARED_CONTROL) ) then
            call ForceAddPlayer(whichForce, slotPlayer)
        endif
        set slotPlayer=null
        set i=i + 1
    endloop
    if ( GetPagedButtonsPageName(shop , currentPage) != null ) then
        set msg=msg + ": " + GetPagedButtonsPageName(shop , currentPage)
    endif
    call DisplayTextToForce(whichForce, msg)
    call ForceClear(whichForce)
    call DestroyForce(whichForce)
    set whichForce=null
    set owner=null
endfunction

function PagedButtons___UpdateStocksById takes unit shop,integer id returns nothing
    local integer s= GetPagedButtonType(shop , id)
    if ( s != 0 ) then
        set s__PagedButtons_SlotType_currentStock[s]=IMaxBJ(s__PagedButtons_SlotType_currentStock[s] - 1, 0)
    endif
endfunction

function PagedButtons___TriggerActionSellUnit takes nothing returns nothing
    local unit shop= GetSellingUnit()
    local integer unitTypeId= GetUnitTypeId(GetSoldUnit())
    if ( unitTypeId == PagedButtons_NEXT_PAGE_ID or unitTypeId == PagedButtons_PREVIOUS_PAGE_ID ) then
        call h__RemoveUnit(GetSoldUnit())
        if ( unitTypeId == PagedButtons_NEXT_PAGE_ID ) then
            call ChangePagedButtonsToNextPage(shop)
        else
            call ChangePagedButtonsToPreviousPage(shop)
        endif



    else

    call PagedButtons___UpdateStocksById(shop , unitTypeId)

    endif
    set shop=null
endfunction

function PagedButtons___TriggerActionSellItem takes nothing returns nothing

    call PagedButtons___UpdateStocksById(GetSellingUnit() , GetItemTypeId(GetSoldItem()))

endfunction

function PagedButtons___TriggerConditionIsMarketplace takes nothing returns boolean
    return GetUnitTypeId(GetSellingUnit()) == 'nmrk'
endfunction

function PagedButtons___Init takes nothing returns nothing

    set PagedButtons___deathTrigger=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(PagedButtons___deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(PagedButtons___deathTrigger, Condition(function PagedButtons___TriggerConditionDeath))


    call TriggerRegisterAnyUnitEventBJ(PagedButtons___sellUnitTrigger, EVENT_PLAYER_UNIT_SELL)
    call TriggerAddCondition(PagedButtons___sellUnitTrigger, Condition(function PagedButtons___TriggerConditionSell))
    call TriggerAddAction(PagedButtons___sellUnitTrigger, function PagedButtons___TriggerActionSellUnit)
    call TriggerRegisterAnyUnitEventBJ(PagedButtons___sellItemTrigger, EVENT_PLAYER_UNIT_SELL_ITEM)
    call TriggerAddCondition(PagedButtons___sellItemTrigger, Condition(function PagedButtons___TriggerConditionSell))
    call TriggerAddAction(PagedButtons___sellItemTrigger, function PagedButtons___TriggerActionSellItem)

    call TimerStart(PagedButtons___autoUpdateStockTimer, 1.0, true, function s__PagedButtons_SlotType_timerFunctionUpdateTime)


    call TriggerAddCondition(bj_stockItemPurchased, Condition(function PagedButtons___TriggerConditionIsMarketplace))

endfunction


//processed hook: hook RemoveUnit DisablePagedButtons





//library PagedButtons ends
//library PagedButtonsUI:



function PagedButtonsUI___ResetPreviewFrame takes nothing returns nothing
    set PagedButtonsUI___PreviewSprite=null
endfunction

function PagedButtonsUI___RefreshPreviewFrame takes nothing returns nothing
    if ( PagedButtonsUI___PreviewSprite != null ) then
        call BlzDestroyFrame(PagedButtonsUI___PreviewSprite)
        set PagedButtonsUI___PreviewSprite=null
    endif
    set PagedButtonsUI___PreviewSprite=BlzCreateFrameByType("SPRITE", "PagedButtonsUIPreviewSprite", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
endfunction

function PagedButtonsUI___RefreshPreviewFrameForPlayerOnly takes real x,real y,real modelScale,string modelPath returns nothing
    call BlzFrameSetAbsPoint(PagedButtonsUI___PreviewSprite, FRAMEPOINT_CENTER, x, y)
    //call BlzFrameSetModel(PreviewSprite, modelPath, 0)
    //call BlzFrameSetModel(PreviewSprite, modelPath, 1) // works for item models
    call BlzFrameSetModel(PagedButtonsUI___PreviewSprite, modelPath, 1) // works for item models
    call BlzFrameSetSpriteAnimate(PagedButtonsUI___PreviewSprite, 2, 0) // Stand
    call BlzFrameSetScale(PagedButtonsUI___PreviewSprite, modelScale)
    call BlzFrameSetVisible(PagedButtonsUI___PreviewSprite, true)
endfunction


function SetPagedButtonsUIEnabledForPlayer takes player whichPlayer,boolean enabled returns nothing
    set PagedButtonsUI___enabledForPlayer[GetPlayerId(whichPlayer)]=enabled
endfunction

function IsPagedButtonsUIEnabledForPlayer takes player whichPlayer returns boolean
    return PagedButtonsUI___enabledForPlayer[GetPlayerId(whichPlayer)]
endfunction

function PagedButtonsUI___GetButtonSlotIcon takes unit shop,integer index returns string
    return BlzGetAbilityIcon(GetPagedButtonId(shop , index))
endfunction

function PagedButtonsUI___GetMaxPageIndex takes integer playerId returns integer
     return GetPagedButtonsNonSpacerButtonsCount(PagedButtonsUI___UIShop[playerId]) / PagedButtonsUI_MAX_SLOTS
endfunction

function PagedButtonsUI___SetSlotChargesVisible takes integer i,boolean visible returns nothing
    call BlzFrameSetVisible(PagedButtonsUI___SlotChargesBackgroundFrame[i], visible)
    call BlzFrameSetVisible(PagedButtonsUI___SlotChargesFrame[i], visible)
endfunction

function PagedButtonsUI___SetTooltipVisible takes boolean visible returns nothing
    call BlzFrameSetVisible(PagedButtonsUI___TooltipIcon, visible)
    call BlzFrameSetVisible(PagedButtonsUI___PageNameText, visible)
    call BlzFrameSetVisible(PagedButtonsUI___SummonFrame, visible)
    call BlzFrameSetVisible(PagedButtonsUI___TooltipText, visible)
    call BlzFrameSetVisible(PagedButtonsUI___ItemGoldFrame, visible)
    call BlzFrameSetVisible(PagedButtonsUI___ItemGoldIconFrame, visible)
    call BlzFrameSetVisible(PagedButtonsUI___ItemLumberFrame, visible)
    call BlzFrameSetVisible(PagedButtonsUI___ItemLumberIconFrame, visible)
    call BlzFrameSetVisible(PagedButtonsUI___ItemFoodFrame, visible)
    call BlzFrameSetVisible(PagedButtonsUI___ItemFoodIconFrame, visible)

    call BlzFrameSetVisible(PagedButtonsUI___PreviewSprite, visible)

endfunction

function PagedButtonsUI___SetVisible takes boolean visible returns nothing
    call BlzFrameSetVisible(PagedButtonsUI___BackgroundFrame, visible)
    call BlzFrameSetVisible(PagedButtonsUI___TitleFrame, visible)
    call BlzFrameSetVisible(PagedButtonsUI___Checkbox, visible)
    
    call PagedButtonsUI___SetTooltipVisible(visible)
endfunction

function PagedButtonsUI___SetSlotVisible takes integer i,boolean visible returns nothing
    call BlzFrameSetVisible(PagedButtonsUI___SlotFrame[i], visible)
    call BlzFrameSetVisible(PagedButtonsUI___SlotBackdropFrame[i], visible)
    call BlzFrameSetVisible(PagedButtonsUI___SlotPageBackgroundFrame[i], visible)
    call BlzFrameSetVisible(PagedButtonsUI___SlotPageFrame[i], visible)
    if ( visible ) then
        set visible=PagedButtonsUI___checked[GetPlayerId(GetLocalPlayer())]
    endif
    call PagedButtonsUI___SetSlotChargesVisible(i , visible)
endfunction

function PagedButtonsUI___SetAllSlotChargesVisibleForPlayer takes player whichPlayer,boolean visible returns nothing
    local integer i= 0
    loop
        exitwhen ( i >= PagedButtonsUI_MAX_SLOTS )
        if ( whichPlayer == GetLocalPlayer() ) then
            if ( BlzFrameIsVisible(PagedButtonsUI___SlotFrame[i]) ) then
                call PagedButtonsUI___SetSlotChargesVisible(i , visible)
            endif
        endif
        set i=i + 1
    endloop
endfunction

function PagedButtonsUI___UpdateItemsForUI takes player whichPlayer returns nothing
    local integer playerId= GetPlayerId(whichPlayer)
    local integer objectId= 0
    local integer i= 0
    local unit shop= PagedButtonsUI___UIShop[playerId]
    local integer slot= 0
    local integer nonSpacerSlots= 0
    local integer startSlot= PagedButtonsUI___PagesIndex[playerId] * PagedButtonsUI_MAX_SLOTS
    local integer maxSlots= GetPagedButtonsCount(shop)
    local integer page= GetPagedButtonsPage(shop)
    local string pageName= GetPagedButtonsPageName(shop , page)
    local integer maxPageIndex= (GetPagedButtonsNonSpacerButtonsCount(PagedButtonsUI___UIShop[(playerId)]) / PagedButtonsUI_MAX_SLOTS) // INLINED!!
    local integer handleId= 0
    if ( pageName == null or StringLength(pageName) == 0 ) then
        set pageName=GetUnitName(shop)
    endif
    if ( maxPageIndex > 0 ) then
        set pageName=s__AFormat_result(s__AFormat_i(s__AFormat_i(s__AFormat_s((s__AFormat_create((GetLocalizedString("PAGE_NAME")))),pageName),PagedButtonsUI___PagesIndex[playerId] + 1),maxPageIndex + 1)) // INLINED!!
        if ( whichPlayer == GetLocalPlayer() ) then
            call BlzFrameSetVisible(PagedButtonsUI___NextPagesButton, true)
            call BlzFrameSetVisible(PagedButtonsUI___PreviousPagesButton, true)
        endif
    else
        if ( whichPlayer == GetLocalPlayer() ) then
            call BlzFrameSetVisible(PagedButtonsUI___NextPagesButton, false)
            call BlzFrameSetVisible(PagedButtonsUI___PreviousPagesButton, false)
        endif
    endif
    //call BJDebugMsg("max page index " + I2S(maxPageIndex))
    // set UIShop[playerId] = shop
    if ( whichPlayer == GetLocalPlayer() ) then
        call BlzFrameSetText(PagedButtonsUI___TitleFrame, pageName)
    endif
    loop
        exitwhen ( slot >= maxSlots or i >= PagedButtonsUI_MAX_SLOTS )
        if ( not (s__PagedButtons_Type_whichType[GetPagedButton((shop ) , ( slot))] == PagedButtons_BUTTON_TYPE_SPACER) ) then // INLINED!!
            set nonSpacerSlots=nonSpacerSlots + 1
            if ( nonSpacerSlots > startSlot ) then
                set objectId=GetPagedButtonId(shop , slot)
                if ( PagedButtonsUI___UIVisible[playerId] ) then //  and GetItemCharges(index) > 0
                    if ( whichPlayer == GetLocalPlayer() ) then
                        //call BlzFrameSetTexture(SlotFrame[index], GetIconByItemType(udg_RucksackItemType[index]), 0, true)
                        call BlzFrameSetTexture(PagedButtonsUI___SlotBackdropFrame[i], BlzGetAbilityIcon(objectId), 0, true)
                        call BlzFrameSetText(PagedButtonsUI___SlotChargesFrame[i], "1") // I2S(GetItemCharges(index))
                        call BlzFrameSetText(PagedButtonsUI___SlotPageFrame[i], I2S(GetPagedButtonsPageByIndex(shop , slot) + 1))
                        call BlzFrameSetVisible(PagedButtonsUI___SlotChargesBackgroundFrame[i], PagedButtonsUI___checked[playerId])
                        call BlzFrameSetVisible(PagedButtonsUI___SlotChargesFrame[i], PagedButtonsUI___checked[playerId])




                        call BlzFrameSetVisible(PagedButtonsUI___SlotFrame[i], true)
                        call BlzFrameSetVisible(PagedButtonsUI___SlotBackdropFrame[i], true)
                    endif
                endif
                
                set handleId=GetHandleId(PagedButtonsUI___SlotClickTrigger[i])
                call SaveInteger(PagedButtonsUI___h, handleId, 0, slot)
                set handleId=GetHandleId(PagedButtonsUI___SlotTooltipOnTrigger[i])
                call SaveInteger(PagedButtonsUI___h, handleId, 0, slot)
                set handleId=GetHandleId(PagedButtonsUI___SlotTooltipOffTrigger[i])
                call SaveInteger(PagedButtonsUI___h, handleId, 0, slot)
                
                set i=i + 1
            endif
        endif
        
        set slot=slot + 1
    endloop
    
    loop
        exitwhen ( i >= PagedButtonsUI_MAX_SLOTS )
        if ( whichPlayer == GetLocalPlayer() ) then
            call PagedButtonsUI___SetSlotVisible(i , false)
        endif
        set i=i + 1
    endloop

endfunction

function PagedButtonsUI___UIExists takes nothing returns boolean
    return PagedButtonsUI___BackgroundFrame != null
endfunction

function PagedButtonsUI___GetPagesIndexFromPagedButtonsShopEx takes unit shop returns integer
    local integer currentPage= GetPagedButtonsPage(shop)
    local integer i= 0
    local integer max= GetPagedButtonsCount(shop)
    local integer countNonSpacerButtons= 0
    loop
        exitwhen ( i >= max )
        if ( GetPagedButtonsPageByIndex(shop , i) >= currentPage ) then
            return countNonSpacerButtons / PagedButtonsUI_MAX_SLOTS
        endif
        
        if ( not (s__PagedButtons_Type_whichType[GetPagedButton((shop ) , ( i))] == PagedButtons_BUTTON_TYPE_SPACER) ) then // INLINED!!
            set countNonSpacerButtons=countNonSpacerButtons + 1
        endif
        set i=i + 1
    endloop
    return 0
endfunction

function PagedButtonsUI___GetPagesIndexFromPagedButtonsShop takes unit shop returns integer
    if ( (IsUnitInGroup((shop), PagedButtons___shops)) ) then // INLINED!!
        return PagedButtonsUI___GetPagesIndexFromPagedButtonsShopEx(shop)
    endif
    return 0
endfunction

function ShowPagedButtonsUI takes player whichPlayer,unit shop returns nothing
    local integer playerId= GetPlayerId(whichPlayer)
    if ( not (PagedButtonsUI___BackgroundFrame != null) ) then // INLINED!!
        return
    endif
    set PagedButtonsUI___UIVisible[playerId]=true
    set PagedButtonsUI___UIShop[playerId]=shop
    set PagedButtonsUI___PagesIndex[playerId]=PagedButtonsUI___GetPagesIndexFromPagedButtonsShop(shop)
    call PagedButtonsUI___UpdateItemsForUI(whichPlayer)
    if ( whichPlayer == GetLocalPlayer() ) then
        call PagedButtonsUI___SetVisible(true)
        call PagedButtonsUI___SetTooltipVisible(false)
    endif
endfunction

function PagedButtonsUI___HidePagedButtonsUISlots takes nothing returns nothing
    local integer i= 0
    loop
        exitwhen ( i == PagedButtonsUI_MAX_SLOTS )
        call PagedButtonsUI___SetSlotVisible(i , false)
        set i=i + 1
    endloop
endfunction

function HidePagedButtonsUI takes nothing returns nothing
    call PagedButtonsUI___SetVisible(false)
    call PagedButtonsUI___HidePagedButtonsUISlots()
endfunction

function HidePagedButtonsUIForPlayer takes player whichPlayer returns nothing
    local integer playerId= GetPlayerId(whichPlayer)
    local integer i= 0
    local integer index= 0
    if ( not (PagedButtonsUI___BackgroundFrame != null) ) then // INLINED!!
        return
    endif
    set PagedButtonsUI___UIVisible[playerId]=false
    set PagedButtonsUI___UIShop[playerId]=null
    set PagedButtonsUI___PagesIndex[playerId]=0

    set PagedButtonsUI___previewModelX[playerId]=0.0
    set PagedButtonsUI___previewModelY[playerId]=0.0
    set PagedButtonsUI___previewModelScale[playerId]=0.0
    set PagedButtonsUI___previewModelFile[playerId]=""

    if ( whichPlayer == GetLocalPlayer() ) then
        call PagedButtonsUI___SetVisible(false)
    endif
    set i=0
    loop
        exitwhen ( i == PagedButtonsUI_MAX_SLOTS )
        if ( whichPlayer == GetLocalPlayer() ) then
            call PagedButtonsUI___SetSlotVisible(i , false)
        endif
        set i=i + 1
    endloop
endfunction

function PagedButtonsUI___ClickItemFunction takes nothing returns nothing
    local integer handleId= GetHandleId(GetTriggeringTrigger())
    local integer slot= LoadInteger(PagedButtonsUI___h, handleId, 0)
    if ( GetLocalPlayer() == GetTriggerPlayer() ) then
        call BlzSendSyncData(PagedButtonsUI_PREFIX, I2S(slot))
    endif
endfunction

function PagedButtonsUI___CompareReals takes real a,real b returns boolean
     return a >= b and a <= b
endfunction


function PagedButtonsUI___StringSplit takes string source,integer index,string separator returns string
    local string result= null
    local integer currentIndex= 0
    local integer separatorLength= StringLength(separator)
    local integer length= StringLength(source)
    local integer i= 0
    loop
        exitwhen ( i == length or currentIndex > index )
        if ( SubString(source, i, i + separatorLength) == separator ) then
            if ( currentIndex == index and result == null ) then
                set result=""
            endif
            set currentIndex=currentIndex + 1
            set i=i + separatorLength
        else
            if ( currentIndex == index ) then
                if ( result == null ) then
                    set result=""
                endif
                set result=result + SubString(source, i, i + 1)
            endif
            set i=i + 1
        endif
    endloop

    return result
endfunction

function PagedButtonsUI___SetTextAreaText takes framehandle f,string text returns nothing
    local string t= null
    local integer i= 0
    call BlzFrameSetText(f, "")
    loop
        set t=PagedButtonsUI___StringSplit(text , i , "|n")
        exitwhen ( t == null )
        if ( StringLength(t) == 0 ) then
            set t=" " // empty line
        endif
        call BlzFrameAddText(f, t)
        set i=i + 1
    endloop
endfunction

function PagedButtonsUI___EnterItemFunction takes nothing returns nothing
    local integer handleId= GetHandleId(GetTriggeringTrigger())
    local integer slot= LoadInteger(PagedButtonsUI___h, handleId, 0)
    local integer playerId= GetPlayerId(GetTriggerPlayer())
    local unit shop= PagedButtonsUI___UIShop[playerId]
    local integer id= GetPagedButtonId(shop , slot)
    local integer page= GetPagedButtonsPageByIndex(shop , slot)
    local string pageName= ""
    local string tooltip= ""
    local integer goldCost= 0
    local integer lumberCost= 0
    local integer foodCost= 0
    local string summonText= ""
    local real modelX= 0.0
    local real modelY= 0.0
    local real modelScale= 0.0
    local string modelPath= ""

    local integer c= GetPagedButtonsConfig(id)

    if ( slot >= 0 and slot < GetPagedButtonsCount(shop) ) then
        set pageName=GetPagedButtonsPageName(shop , page)
        set summonText=BlzGetAbilityTooltip(id, 0)
        if ( (s__PagedButtons_Type_whichType[GetPagedButton((shop ) , ( slot))] == PagedButtons_BUTTON_TYPE_UNIT) ) then // INLINED!!
            if ( IsUnitIdType(id, UNIT_TYPE_HERO) ) then
                //call BJDebugMsg("Hero code " + A2S(id))

                set goldCost=s__PagedButtonsConfig_heroGoldCost[c]
                set lumberCost=s__PagedButtonsConfig_heroLumberCost[c]




            else
                set goldCost=GetUnitGoldCost(id)
                set lumberCost=GetUnitWoodCost(id)
            endif
            set foodCost=GetFoodUsed(id)
        elseif ( (s__PagedButtons_Type_whichType[GetPagedButton((shop ) , ( slot))] == PagedButtons_BUTTON_TYPE_ITEM) ) then // INLINED!!
            set goldCost=(R2I(I2R(GetItemValueGold((id))) * ItemTypeUtils___PAWN_ITEM_RATE)) // INLINED!!
            set lumberCost=(R2I(I2R(GetItemValueLumber((id))) * ItemTypeUtils___PAWN_ITEM_RATE)) // INLINED!!
        endif
        

        set modelX=s__PagedButtonsConfig_modelX[c]
        set modelY=s__PagedButtonsConfig_modelY[c]
        set modelScale=s__PagedButtonsConfig_modelScale[c]
        set modelPath=s__PagedButtonsConfig_modelPath[c]

        
        if ( summonText != null and StringLength(summonText) > 0 ) then
            if ( GetLocalPlayer() == GetTriggerPlayer() ) then
                call BlzFrameSetText(PagedButtonsUI___SummonFrame, summonText)
                call BlzFrameSetVisible(PagedButtonsUI___SummonFrame, true)
            endif
        endif
        
        if ( goldCost > 0 ) then
             if ( GetLocalPlayer() == GetTriggerPlayer() ) then
                call BlzFrameSetText(PagedButtonsUI___ItemGoldFrame, "|cffffcc00" + I2S(goldCost) + "|r")
                call BlzFrameSetVisible(PagedButtonsUI___ItemGoldIconFrame, true)
                call BlzFrameSetVisible(PagedButtonsUI___ItemGoldFrame, true)
            endif
        else
            if ( GetLocalPlayer() == GetTriggerPlayer() ) then
                call BlzFrameSetVisible(PagedButtonsUI___ItemGoldIconFrame, false)
                call BlzFrameSetVisible(PagedButtonsUI___ItemGoldFrame, false)
            endif
        endif
        
        if ( lumberCost > 0 ) then
             if ( GetLocalPlayer() == GetTriggerPlayer() ) then
                call BlzFrameSetText(PagedButtonsUI___ItemLumberFrame, "|cffffcc00" + I2S(lumberCost) + "|r")
                call BlzFrameSetVisible(PagedButtonsUI___ItemLumberIconFrame, true)
                call BlzFrameSetVisible(PagedButtonsUI___ItemLumberFrame, true)
            endif
        else
            if ( GetLocalPlayer() == GetTriggerPlayer() ) then
                call BlzFrameSetVisible(PagedButtonsUI___ItemLumberIconFrame, false)
                call BlzFrameSetVisible(PagedButtonsUI___ItemLumberFrame, false)
            endif
        endif
        
        if ( foodCost > 0 ) then
             if ( GetLocalPlayer() == GetTriggerPlayer() ) then
                call BlzFrameSetText(PagedButtonsUI___ItemFoodFrame, "|cffffcc00" + I2S(foodCost) + "|r")
                call BlzFrameSetVisible(PagedButtonsUI___ItemFoodIconFrame, true)
                call BlzFrameSetVisible(PagedButtonsUI___ItemFoodFrame, true)
            endif
        else
            if ( GetLocalPlayer() == GetTriggerPlayer() ) then
                call BlzFrameSetVisible(PagedButtonsUI___ItemFoodIconFrame, false)
                call BlzFrameSetVisible(PagedButtonsUI___ItemFoodFrame, false)
            endif
        endif
        //call BJDebugMsg("Entering item " + I2S(index))
        
        if ( pageName != null ) then
            if ( GetLocalPlayer() == GetTriggerPlayer() ) then
                call BlzFrameSetText(PagedButtonsUI___PageNameText, pageName)
                call BlzFrameSetVisible(PagedButtonsUI___PageNameText, true)
            endif
        else
            if ( GetLocalPlayer() == GetTriggerPlayer() ) then
                call BlzFrameSetVisible(PagedButtonsUI___PageNameText, false)
            endif
        endif

        if ( id != 0 ) then
            set tooltip=tooltip + BlzGetAbilityExtendedTooltip(id, 0)
        else
            set tooltip=tooltip + s__AFormat_result(s__AFormat_i(s__AFormat_i((s__AFormat_create((GetLocalizedString("EMPTY_SLOT_TOOLTIP")))),slot + 1),page + 1)) // INLINED!!
            //call BlzFrameSetVisible(ItemGoldIconFrame[playerId], false)
        endif
        
        if ( id != 0 ) then
            if ( GetLocalPlayer() == GetTriggerPlayer() ) then
                call BlzFrameSetTexture(PagedButtonsUI___TooltipIcon, (BlzGetAbilityIcon(GetPagedButtonId((shop ) , ( slot)))), 0, false) // INLINED!!
                call BlzFrameSetVisible(PagedButtonsUI___TooltipIcon, true)
            endif
            set tooltip=tooltip + GetLocalizedString("BUY_TOOLTIP_SUFFIX")
        else
            if ( GetLocalPlayer() == GetTriggerPlayer() ) then
                call BlzFrameSetVisible(PagedButtonsUI___TooltipIcon, false)
            endif
            set tooltip=tooltip + GetLocalizedString("SLOT_TOOLTIP_SUFFIX")
        endif

        if ( GetLocalPlayer() == GetTriggerPlayer() ) then
            call PagedButtonsUI___SetTextAreaText(PagedButtonsUI___TooltipText , tooltip)
            //call BlzFrameSetText(TooltipText, tooltip)
            call BlzFrameSetVisible(PagedButtonsUI___TooltipText, true)
        endif
        

        if ( StringLength(modelPath) > 0 ) then
            // https://us.forums.blizzard.com/en/warcraft3/t/jasslua-frameeventmouseenter-infinite-loop/28659
            // because of this bug we store the model path and scaling and only refresh the sprite if it changed.
            if ( PagedButtonsUI___previewModelFile[playerId] != modelPath or not PagedButtonsUI___CompareReals(PagedButtonsUI___previewModelX[playerId] , modelX) or not PagedButtonsUI___CompareReals(PagedButtonsUI___previewModelY[playerId] , modelY) or not PagedButtonsUI___CompareReals(PagedButtonsUI___previewModelScale[playerId] , modelScale) ) then
                //call BJDebugMsg("Refresh with model path because of different scale or path: " + modelPath)
                set PagedButtonsUI___previewModelX[playerId]=modelX
                set PagedButtonsUI___previewModelY[playerId]=modelY
                set PagedButtonsUI___previewModelScale[playerId]=modelScale
                set PagedButtonsUI___previewModelFile[playerId]=modelPath
                // It won't work if we do not recreate the framehandle.
                call PagedButtonsUI___RefreshPreviewFrame()
                
                if ( GetLocalPlayer() == GetTriggerPlayer() ) then
                    call PagedButtonsUI___RefreshPreviewFrameForPlayerOnly(modelX , modelY , modelScale , modelPath)
                endif
            endif
        else
            set PagedButtonsUI___previewModelX[playerId]=0.4
            set PagedButtonsUI___previewModelY[playerId]=0.3
            set PagedButtonsUI___previewModelFile[playerId]=""
            set PagedButtonsUI___previewModelScale[playerId]=0.0
            if ( GetLocalPlayer() == GetTriggerPlayer() ) then
                call BlzFrameSetVisible(PagedButtonsUI___PreviewSprite, false)
            endif
        endif

    endif
    
    set shop=null
endfunction

function PagedButtonsUI___LeaveItemFunction takes nothing returns nothing
    
endfunction

function PagedButtonsUI___PreviousPagesFunction takes nothing returns nothing
    if ( GetLocalPlayer() == GetTriggerPlayer() ) then
        call BlzSendSyncData(PagedButtonsUI_PREFIX, "PreviousPage")
    endif
endfunction

function PagedButtonsUI___NextPagesFunction takes nothing returns nothing
    if ( GetLocalPlayer() == GetTriggerPlayer() ) then
        call BlzSendSyncData(PagedButtonsUI_PREFIX, "NextPage")
    endif
endfunction

function PagedButtonsUI___CheckedFunction takes nothing returns nothing
    if ( GetLocalPlayer() == GetTriggerPlayer() ) then
        call BlzSendSyncData(PagedButtonsUI_PREFIX, "Checked")
    endif
endfunction

function PagedButtonsUI___UncheckedFunction takes nothing returns nothing
    if ( GetLocalPlayer() == GetTriggerPlayer() ) then
        call BlzSendSyncData(PagedButtonsUI_PREFIX, "Unchecked")
    endif
endfunction

function PagedButtonsUI___CloseFunction takes nothing returns nothing
    if ( GetLocalPlayer() == GetTriggerPlayer() ) then
        call BlzSendSyncData(PagedButtonsUI_PREFIX, "Close")
    endif
endfunction

function PagedButtonsUI_CreateUI takes nothing returns nothing
    local integer i= 0
    local integer handleId= 0
    local real x= 0.0
    local real y= 0.0
    
    set PagedButtonsUI___BackgroundFrame=BlzCreateFrame("EscMenuBackdrop", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(PagedButtonsUI___BackgroundFrame, FRAMEPOINT_TOPLEFT, PagedButtonsUI_X, PagedButtonsUI_Y)
    call BlzFrameSetAbsPoint(PagedButtonsUI___BackgroundFrame, FRAMEPOINT_BOTTOMRIGHT, PagedButtonsUI_SIZE_X, PagedButtonsUI_Y - PagedButtonsUI_SIZE_Y)

    set y=PagedButtonsUI_TITLE_Y
    set PagedButtonsUI___TitleFrame=BlzCreateFrameByType("TEXT", "PagedButtonsUITitle", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(PagedButtonsUI___TitleFrame, FRAMEPOINT_TOPLEFT, 0.0, y)
    call BlzFrameSetAbsPoint(PagedButtonsUI___TitleFrame, FRAMEPOINT_BOTTOMRIGHT, PagedButtonsUI_SIZE_X, y - PagedButtonsUI_TITLE_HEIGHT)
    call BlzFrameSetTextAlignment(PagedButtonsUI___TitleFrame, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)

    set x=PagedButtonsUI_BUTTON_X
    set y=PagedButtonsUI_BUTTON_Y
    set i=0
    loop
        exitwhen ( i == PagedButtonsUI_MAX_SLOTS )
        set PagedButtonsUI___SlotFrame[i]=BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
        call BlzFrameSetAbsPoint(PagedButtonsUI___SlotFrame[i], FRAMEPOINT_TOPLEFT, x, y)
        call BlzFrameSetAbsPoint(PagedButtonsUI___SlotFrame[i], FRAMEPOINT_BOTTOMRIGHT, x + PagedButtonsUI_BUTTON_SIZE, y - PagedButtonsUI_BUTTON_SIZE)
        //call BlzFrameSetTexture(SlotFrame[index], GetIconByItemType(0), 0, true)
        //call BlzFrameSetText(SlotFrame[index], I2S(index))

        set PagedButtonsUI___SlotBackdropFrame[i]=BlzCreateFrameByType("BACKDROP", "PagedButtonsUIBackdropFrame" + I2S(i), PagedButtonsUI___SlotFrame[i], "", 1)
        call BlzFrameSetAllPoints(PagedButtonsUI___SlotBackdropFrame[i], PagedButtonsUI___SlotFrame[i])
//             call BlzFrameSetTexture(SlotBackdropFrame[index], "UI\\Widgets\\Console\\Human\\human-inventory-slotfiller.blp", 0, true)

        if ( PagedButtonsUI___SlotClickTrigger[i] != null ) then
            set handleId=GetHandleId(PagedButtonsUI___SlotClickTrigger[i])
            call FlushChildHashtable(PagedButtonsUI___h, handleId)
            call DestroyTrigger(PagedButtonsUI___SlotClickTrigger[i])
        endif
        set PagedButtonsUI___SlotClickTrigger[i]=CreateTrigger()
        call BlzTriggerRegisterFrameEvent(PagedButtonsUI___SlotClickTrigger[i], PagedButtonsUI___SlotFrame[i], FRAMEEVENT_CONTROL_CLICK)
        call TriggerAddAction(PagedButtonsUI___SlotClickTrigger[i], function PagedButtonsUI___ClickItemFunction)
        set handleId=GetHandleId(PagedButtonsUI___SlotClickTrigger[i])
        call SaveInteger(PagedButtonsUI___h, handleId, 0, i)

        if ( PagedButtonsUI___SlotTooltipOnTrigger[i] != null ) then
            set handleId=GetHandleId(PagedButtonsUI___SlotTooltipOnTrigger[i])
            call FlushChildHashtable(PagedButtonsUI___h, handleId)
            call DestroyTrigger(PagedButtonsUI___SlotTooltipOnTrigger[i])
        endif
        set PagedButtonsUI___SlotTooltipOnTrigger[i]=CreateTrigger()
        call BlzTriggerRegisterFrameEvent(PagedButtonsUI___SlotTooltipOnTrigger[i], PagedButtonsUI___SlotFrame[i], FRAMEEVENT_MOUSE_ENTER)
        call TriggerAddAction(PagedButtonsUI___SlotTooltipOnTrigger[i], function PagedButtonsUI___EnterItemFunction)
        set handleId=GetHandleId(PagedButtonsUI___SlotTooltipOnTrigger[i])
        call SaveInteger(PagedButtonsUI___h, handleId, 0, i)
        
        if ( PagedButtonsUI___SlotTooltipOffTrigger[i] != null ) then
            set handleId=GetHandleId(PagedButtonsUI___SlotTooltipOffTrigger[i])
            call FlushChildHashtable(PagedButtonsUI___h, handleId)
            call DestroyTrigger(PagedButtonsUI___SlotTooltipOffTrigger[i])
        endif
        set PagedButtonsUI___SlotTooltipOffTrigger[i]=CreateTrigger()
        call BlzTriggerRegisterFrameEvent(PagedButtonsUI___SlotTooltipOffTrigger[i], PagedButtonsUI___SlotFrame[i], FRAMEEVENT_MOUSE_LEAVE)
        call TriggerAddAction(PagedButtonsUI___SlotTooltipOffTrigger[i], function PagedButtonsUI___LeaveItemFunction)
        call SaveInteger(PagedButtonsUI___h, handleId, 0, i)

        // TODO Mouse down and mouse up to drag & drop to another bag or switch or do it like Warcraft's inventory with right click and left click. Add the icon of the item to the mouse cursor. If you click on the map it is dropped, if you click on the inventory it is dropped there.
        
        set PagedButtonsUI___SlotPageBackgroundFrame[i]=BlzCreateFrameByType("BACKDROP", "ItemBagBackrgroundFrame" + I2S(i), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
        call BlzFrameSetAbsPoint(PagedButtonsUI___SlotPageBackgroundFrame[i], FRAMEPOINT_TOPLEFT, x, y)
        call BlzFrameSetAbsPoint(PagedButtonsUI___SlotPageBackgroundFrame[i], FRAMEPOINT_BOTTOMRIGHT, x + PagedButtonsUI_CHARGES_BACKGROUND_SIZE, y - PagedButtonsUI_CHARGES_BACKGROUND_SIZE)
        call BlzFrameSetTexture(PagedButtonsUI___SlotPageBackgroundFrame[i], "ui\\widgets\\console\\human\\commandbutton\\human-button-lvls-overlay.blp", 0, true)
        call BlzFrameSetLevel(PagedButtonsUI___SlotPageBackgroundFrame[i], 1)

        set PagedButtonsUI___SlotPageFrame[i]=BlzCreateFrameByType("TEXT", "PagedButtonsUIBag" + I2S(i), PagedButtonsUI___SlotPageBackgroundFrame[i], "", 0)
        call BlzFrameSetAllPoints(PagedButtonsUI___SlotPageFrame[i], PagedButtonsUI___SlotPageBackgroundFrame[i])
        call BlzFrameSetText(PagedButtonsUI___SlotPageFrame[i], I2S(i + 1))
        call BlzFrameSetTextAlignment(PagedButtonsUI___SlotPageFrame[i], TEXT_JUSTIFY_CENTER, TEXT_JUSTIFY_CENTER)
        call BlzFrameSetScale(PagedButtonsUI___SlotPageFrame[i], 0.7)
        call BlzFrameSetEnable(PagedButtonsUI___SlotPageFrame[i], false)
        call BlzFrameSetLevel(PagedButtonsUI___SlotPageFrame[i], 2)
        
        set PagedButtonsUI___SlotChargesBackgroundFrame[i]=BlzCreateFrameByType("BACKDROP", "PagedButtonsUIItemChargesBackrgroundFrame" + I2S(i), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
        call BlzFrameSetAbsPoint(PagedButtonsUI___SlotChargesBackgroundFrame[i], FRAMEPOINT_TOPLEFT, x + PagedButtonsUI_BUTTON_SIZE - PagedButtonsUI_CHARGES_BACKGROUND_SIZE, y - PagedButtonsUI_BUTTON_SIZE + PagedButtonsUI_CHARGES_BACKGROUND_SIZE)
        call BlzFrameSetAbsPoint(PagedButtonsUI___SlotChargesBackgroundFrame[i], FRAMEPOINT_BOTTOMRIGHT, x + PagedButtonsUI_BUTTON_SIZE, y - PagedButtonsUI_BUTTON_SIZE)
        call BlzFrameSetTexture(PagedButtonsUI___SlotChargesBackgroundFrame[i], "ui\\widgets\\console\\human\\commandbutton\\human-button-lvls-overlay.blp", 0, true)
        call BlzFrameSetLevel(PagedButtonsUI___SlotChargesBackgroundFrame[i], 1)

        set PagedButtonsUI___SlotChargesFrame[i]=BlzCreateFrameByType("TEXT", "PagedButtonsUICharges" + I2S(i), PagedButtonsUI___SlotChargesBackgroundFrame[i], "", 0)
        call BlzFrameSetAllPoints(PagedButtonsUI___SlotChargesFrame[i], PagedButtonsUI___SlotChargesBackgroundFrame[i])
        call BlzFrameSetTextAlignment(PagedButtonsUI___SlotChargesFrame[i], TEXT_JUSTIFY_CENTER, TEXT_JUSTIFY_CENTER)
        call BlzFrameSetScale(PagedButtonsUI___SlotChargesFrame[i], 0.7)
        call BlzFrameSetEnable(PagedButtonsUI___SlotChargesFrame[i], false)
        call BlzFrameSetLevel(PagedButtonsUI___SlotChargesFrame[i], 2)

        set x=x + PagedButtonsUI_BUTTON_SIZE + PagedButtonsUI_BUTTON_SPACE

        set i=i + 1

        // every 3 bags start another line
        if ( ModuloInteger(i, PagedButtonsUI_MAX_SLOTS_PER_LINE) == 0 ) then
            set x=PagedButtonsUI_BUTTON_X
            set y=y - PagedButtonsUI_BUTTON_SIZE - PagedButtonsUI_BUTTON_SPACE
        endif
    endloop

    set PagedButtonsUI___TooltipFrame=BlzCreateFrame("EscMenuBackdrop", PagedButtonsUI___BackgroundFrame, 0, 0)
    call BlzFrameSetAbsPoint(PagedButtonsUI___TooltipFrame, FRAMEPOINT_TOPLEFT, PagedButtonsUI_TOOLTIP_FRAME_X, PagedButtonsUI_TOOLTIP_FRAME_Y)
    call BlzFrameSetAbsPoint(PagedButtonsUI___TooltipFrame, FRAMEPOINT_BOTTOMRIGHT, PagedButtonsUI_TOOLTIP_FRAME_X + PagedButtonsUI_TOOLTIP_FRAME_WIDTH, PagedButtonsUI_TOOLTIP_FRAME_Y - PagedButtonsUI_TOOLTIP_FRAME_HEIGHT)
    
    set PagedButtonsUI___TooltipIcon=BlzCreateFrameByType("BACKDROP", "PagedButtonsUITooltipIconFrame", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(PagedButtonsUI___TooltipIcon, FRAMEPOINT_TOPLEFT, PagedButtonsUI_TOOLTIP_ICON_X, PagedButtonsUI_TOOLTIP_ICON_Y)
    call BlzFrameSetAbsPoint(PagedButtonsUI___TooltipIcon, FRAMEPOINT_BOTTOMRIGHT, PagedButtonsUI_TOOLTIP_ICON_X + PagedButtonsUI_TOOLTIP_ICON_SIZE, PagedButtonsUI_TOOLTIP_ICON_Y - PagedButtonsUI_TOOLTIP_ICON_SIZE)
    call BlzFrameSetTexture(PagedButtonsUI___TooltipIcon, "ReplaceableTextures\\WorldEditUI\\Editor-Random-Item.blp", 0, true)
    
    set PagedButtonsUI___PageNameText=BlzCreateFrameByType("TEXT", "PagedButtonsUITooltipPageName", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(PagedButtonsUI___PageNameText, FRAMEPOINT_TOPLEFT, PagedButtonsUI_TOOLTIP_PAGE_NAME_X, PagedButtonsUI_TOOLTIP_PAGE_NAME_Y)
    call BlzFrameSetAbsPoint(PagedButtonsUI___PageNameText, FRAMEPOINT_BOTTOMRIGHT, PagedButtonsUI_TOOLTIP_PAGE_NAME_X + PagedButtonsUI_TOOLTIP_PAGE_NAME_WIDTH, PagedButtonsUI_TOOLTIP_PAGE_NAME_Y - PagedButtonsUI_TOOLTIP_PAGE_NAME_HEIGHT)
    
    set PagedButtonsUI___SummonFrame=BlzCreateFrameByType("TEXT", "PagedButtonsUITooltipSummon", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(PagedButtonsUI___SummonFrame, FRAMEPOINT_TOPLEFT, PagedButtonsUI_SUMMON_X, PagedButtonsUI_SUMMON_Y)
    call BlzFrameSetAbsPoint(PagedButtonsUI___SummonFrame, FRAMEPOINT_BOTTOMRIGHT, PagedButtonsUI_SUMMON_X + PagedButtonsUI_TOOLTIP_WIDTH, PagedButtonsUI_SUMMON_Y - PagedButtonsUI_SUMMON_HEIGHT)

    set PagedButtonsUI___ItemGoldIconFrame=BlzCreateFrameByType("BACKDROP", "PagedButtonsUITooltipGoldFrame", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(PagedButtonsUI___ItemGoldIconFrame, FRAMEPOINT_TOPLEFT, PagedButtonsUI_COST_X, PagedButtonsUI_COST_Y)
    call BlzFrameSetAbsPoint(PagedButtonsUI___ItemGoldIconFrame, FRAMEPOINT_BOTTOMRIGHT, PagedButtonsUI_COST_X + PagedButtonsUI_COST_ICON_SIZE, PagedButtonsUI_COST_Y - PagedButtonsUI_COST_ICON_SIZE)
    call BlzFrameSetTexture(PagedButtonsUI___ItemGoldIconFrame, "UI\\Feedback\\Resources\\ResourceGold.blp", 0, true)
    
    set PagedButtonsUI___ItemGoldFrame=BlzCreateFrameByType("TEXT", "PagedButtonsUITooltipGold", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(PagedButtonsUI___ItemGoldFrame, FRAMEPOINT_TOPLEFT, PagedButtonsUI_COST_GOLD_X, PagedButtonsUI_COST_Y)
    call BlzFrameSetAbsPoint(PagedButtonsUI___ItemGoldFrame, FRAMEPOINT_BOTTOMRIGHT, PagedButtonsUI_COST_GOLD_X + PagedButtonsUI_COST_WIDTH, PagedButtonsUI_COST_Y - PagedButtonsUI_COST_HEIGHT)
    
    set PagedButtonsUI___ItemLumberIconFrame=BlzCreateFrameByType("BACKDROP", "PagedButtonsUITooltipLumberFrame", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(PagedButtonsUI___ItemLumberIconFrame, FRAMEPOINT_TOPLEFT, PagedButtonsUI_COST_ICON_LUMBER_X, PagedButtonsUI_COST_Y)
    call BlzFrameSetAbsPoint(PagedButtonsUI___ItemLumberIconFrame, FRAMEPOINT_BOTTOMRIGHT, PagedButtonsUI_COST_ICON_LUMBER_X + PagedButtonsUI_COST_ICON_SIZE, PagedButtonsUI_COST_Y - PagedButtonsUI_COST_ICON_SIZE)
    call BlzFrameSetTexture(PagedButtonsUI___ItemLumberIconFrame, "UI\\Feedback\\Resources\\ResourceLumber.blp", 0, true)
    
    set PagedButtonsUI___ItemLumberFrame=BlzCreateFrameByType("TEXT", "PagedButtonsUITooltipLumber", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(PagedButtonsUI___ItemLumberFrame, FRAMEPOINT_TOPLEFT, PagedButtonsUI_COST_LUMBER_X, PagedButtonsUI_COST_Y)
    call BlzFrameSetAbsPoint(PagedButtonsUI___ItemLumberFrame, FRAMEPOINT_BOTTOMRIGHT, PagedButtonsUI_COST_LUMBER_X + PagedButtonsUI_COST_WIDTH, PagedButtonsUI_COST_Y - PagedButtonsUI_COST_ICON_SIZE)
    
    set PagedButtonsUI___ItemFoodIconFrame=BlzCreateFrameByType("BACKDROP", "PagedButtonsUITooltipFoodFrame", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(PagedButtonsUI___ItemFoodIconFrame, FRAMEPOINT_TOPLEFT, PagedButtonsUI_COST_ICON_FOOD_X, PagedButtonsUI_COST_Y)
    call BlzFrameSetAbsPoint(PagedButtonsUI___ItemFoodIconFrame, FRAMEPOINT_BOTTOMRIGHT, PagedButtonsUI_COST_ICON_FOOD_X + PagedButtonsUI_COST_ICON_SIZE, PagedButtonsUI_COST_Y - PagedButtonsUI_COST_ICON_SIZE)
    call BlzFrameSetTexture(PagedButtonsUI___ItemFoodIconFrame, "UI\\Feedback\\Resources\\ResourceSupply.blp", 0, true)
    
    set PagedButtonsUI___ItemFoodFrame=BlzCreateFrameByType("TEXT", "PagedButtonsUITooltipFood", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(PagedButtonsUI___ItemFoodFrame, FRAMEPOINT_TOPLEFT, PagedButtonsUI_COST_FOOD_X, PagedButtonsUI_COST_Y)
    call BlzFrameSetAbsPoint(PagedButtonsUI___ItemFoodFrame, FRAMEPOINT_BOTTOMRIGHT, PagedButtonsUI_COST_FOOD_X + PagedButtonsUI_COST_WIDTH, PagedButtonsUI_COST_Y - PagedButtonsUI_COST_ICON_SIZE)
    
    set PagedButtonsUI___TooltipText=BlzCreateFrame("EscMenuTextAreaTemplate", PagedButtonsUI___BackgroundFrame, 0, 0)
    call BlzFrameSetAbsPoint(PagedButtonsUI___TooltipText, FRAMEPOINT_TOPLEFT, PagedButtonsUI_TOOLTIP_X, PagedButtonsUI_TOOLTIP_Y)
    call BlzFrameSetAbsPoint(PagedButtonsUI___TooltipText, FRAMEPOINT_BOTTOMRIGHT, PagedButtonsUI_TOOLTIP_X + PagedButtonsUI_TOOLTIP_WIDTH, PagedButtonsUI_TOOLTIP_Y - PagedButtonsUI_TOOLTIP_HEIGHT)
    call BlzFrameSetFont(PagedButtonsUI___TooltipText, "MasterFont", PagedButtonsUI_TOOLTIP_FONT_HEIGHT, 0)
    call BlzFrameSetEnable(PagedButtonsUI___TooltipText, false)
    call BlzFrameSetTextAlignment(PagedButtonsUI___TooltipText, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)
    call BlzFrameSetLevel(PagedButtonsUI___TooltipText, 1)
    
    //call BJDebugMsg("Icon " + GetIconByItemType(itemTypeId) + " for item type " + GetObjectName(itemTypeId))


    call PagedButtonsUI___RefreshPreviewFrame()


    set PagedButtonsUI___NextPagesButton=BlzCreateFrame("ScriptDialogButton", PagedButtonsUI___BackgroundFrame, 0, 0)
    call BlzFrameSetAbsPoint(PagedButtonsUI___NextPagesButton, FRAMEPOINT_TOPLEFT, PagedButtonsUI_NEXT_PAGE_BUTTON_X, PagedButtonsUI_BOTTOM_BUTTONS_Y)
    call BlzFrameSetAbsPoint(PagedButtonsUI___NextPagesButton, FRAMEPOINT_BOTTOMRIGHT, PagedButtonsUI_NEXT_PAGE_BUTTON_X + PagedButtonsUI_PAGE_BUTTON_WIDTH, PagedButtonsUI_BOTTOM_BUTTONS_Y - PagedButtonsUI_CLOSE_BUTTON_HEIGHT)
    call BlzFrameSetText(PagedButtonsUI___NextPagesButton, GetLocalizedString("NEXT_PAGE_BUTTON"))

    if ( PagedButtonsUI___NextPagesTrigger != null ) then
        call DestroyTrigger(PagedButtonsUI___NextPagesTrigger)
    endif
    set PagedButtonsUI___NextPagesTrigger=CreateTrigger()
    call BlzTriggerRegisterFrameEvent(PagedButtonsUI___NextPagesTrigger, PagedButtonsUI___NextPagesButton, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(PagedButtonsUI___NextPagesTrigger, function PagedButtonsUI___NextPagesFunction)
    
    set PagedButtonsUI___PreviousPagesButton=BlzCreateFrame("ScriptDialogButton", PagedButtonsUI___BackgroundFrame, 0, 0)
    call BlzFrameSetAbsPoint(PagedButtonsUI___PreviousPagesButton, FRAMEPOINT_TOPLEFT, PagedButtonsUI_PREVIOUS_PAGE_BUTTON_X, PagedButtonsUI_BOTTOM_BUTTONS_Y)
    call BlzFrameSetAbsPoint(PagedButtonsUI___PreviousPagesButton, FRAMEPOINT_BOTTOMRIGHT, PagedButtonsUI_PREVIOUS_PAGE_BUTTON_X + PagedButtonsUI_PAGE_BUTTON_WIDTH, PagedButtonsUI_BOTTOM_BUTTONS_Y - PagedButtonsUI_CLOSE_BUTTON_HEIGHT)
    call BlzFrameSetText(PagedButtonsUI___PreviousPagesButton, GetLocalizedString("PREVIOUS_PAGE_BUTTON"))

    if ( PagedButtonsUI___PreviousPagesTrigger != null ) then
        call DestroyTrigger(PagedButtonsUI___PreviousPagesTrigger)
    endif
    set PagedButtonsUI___PreviousPagesTrigger=CreateTrigger()
    call BlzTriggerRegisterFrameEvent(PagedButtonsUI___PreviousPagesTrigger, PagedButtonsUI___PreviousPagesButton, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(PagedButtonsUI___PreviousPagesTrigger, function PagedButtonsUI___PreviousPagesFunction)

    set PagedButtonsUI___Checkbox=BlzCreateFrame("QuestCheckBox2", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(PagedButtonsUI___Checkbox, FRAMEPOINT_TOPLEFT, PagedButtonsUI_CHECKBOX_X, PagedButtonsUI_BOTTOM_BUTTONS_Y)
    call BlzFrameSetAbsPoint(PagedButtonsUI___Checkbox, FRAMEPOINT_BOTTOMRIGHT, PagedButtonsUI_CHECKBOX_X + PagedButtonsUI_CHECKBOX_SIZE, PagedButtonsUI_BOTTOM_BUTTONS_Y - PagedButtonsUI_CHECKBOX_SIZE)
    call BlzFrameSetEnable(PagedButtonsUI___Checkbox, true)
    call BlzFrameSetValue(PagedButtonsUI___Checkbox, 1.0)
   
    if ( PagedButtonsUI___CheckedTrigger != null ) then
        call DestroyTrigger(PagedButtonsUI___CheckedTrigger)
    endif
    set PagedButtonsUI___CheckedTrigger=CreateTrigger()
    call BlzTriggerRegisterFrameEvent(PagedButtonsUI___CheckedTrigger, PagedButtonsUI___Checkbox, FRAMEEVENT_CHECKBOX_CHECKED)
    call TriggerAddAction(PagedButtonsUI___CheckedTrigger, function PagedButtonsUI___CheckedFunction)
    
    if ( PagedButtonsUI___UncheckedTrigger != null ) then
        call DestroyTrigger(PagedButtonsUI___UncheckedTrigger)
    endif
    set PagedButtonsUI___UncheckedTrigger=CreateTrigger()
    call BlzTriggerRegisterFrameEvent(PagedButtonsUI___UncheckedTrigger, PagedButtonsUI___Checkbox, FRAMEEVENT_CHECKBOX_UNCHECKED)
    call TriggerAddAction(PagedButtonsUI___UncheckedTrigger, function PagedButtonsUI___UncheckedFunction)

    set PagedButtonsUI___CloseButton=BlzCreateFrame("ScriptDialogButton", PagedButtonsUI___BackgroundFrame, 0, 0)
    call BlzFrameSetAbsPoint(PagedButtonsUI___CloseButton, FRAMEPOINT_TOPLEFT, PagedButtonsUI_CLOSE_BUTTON_X, PagedButtonsUI_BOTTOM_BUTTONS_Y)
    call BlzFrameSetAbsPoint(PagedButtonsUI___CloseButton, FRAMEPOINT_BOTTOMRIGHT, PagedButtonsUI_CLOSE_BUTTON_X + PagedButtonsUI_CLOSE_BUTTON_WIDTH, PagedButtonsUI_BOTTOM_BUTTONS_Y - PagedButtonsUI_CLOSE_BUTTON_HEIGHT)
    call BlzFrameSetText(PagedButtonsUI___CloseButton, GetLocalizedString("CLOSE_BUTTON"))

    if ( PagedButtonsUI___CloseTrigger != null ) then
        call DestroyTrigger(PagedButtonsUI___CloseTrigger)
    endif
    set PagedButtonsUI___CloseTrigger=CreateTrigger()
    call BlzTriggerRegisterFrameEvent(PagedButtonsUI___CloseTrigger, PagedButtonsUI___CloseButton, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(PagedButtonsUI___CloseTrigger, function PagedButtonsUI___CloseFunction)

    call HidePagedButtonsUI()
endfunction

function PagedButtonsUI___TriggerActionSelected takes nothing returns nothing
    if ( (IsUnitInGroup((GetTriggerUnit()), PagedButtons___shops)) and GetPagedButtonsCount(GetTriggerUnit()) > 0 and (PagedButtonsUI___enabledForPlayer[GetPlayerId((GetTriggerPlayer()))]) ) then // INLINED!!
        call ShowPagedButtonsUI(GetTriggerPlayer() , GetTriggerUnit())
    endif
endfunction

function PagedButtonsUI___TriggerConditionChangePage takes nothing returns boolean
    local unit shop= (PagedButtons___triggerShop) // INLINED!!
    local integer i= 0
    loop
        exitwhen ( i == bj_MAX_PLAYERS )
        if ( shop == PagedButtonsUI___UIShop[i] ) then
            call PagedButtonsUI___UpdateItemsForUI(Player(i))
        endif
        set i=i + 1
    endloop
    set shop=null
    return false
endfunction

function PagedButtonsUI___HidePagedButtonsShopForAllPlayers takes unit shop returns nothing
    local integer i= 0
    loop
        exitwhen ( i == bj_MAX_PLAYERS )
        if ( shop == PagedButtonsUI___UIShop[i] ) then
            call HidePagedButtonsUIForPlayer(Player(i))
        endif
        set i=i + 1
    endloop
endfunction

function PagedButtonsUI___TriggerConditionDeath takes nothing returns boolean
    local unit shop= GetTriggerUnit()
    if ( (IsUnitInGroup((shop), PagedButtons___shops)) ) then // INLINED!!
        call PagedButtonsUI___HidePagedButtonsShopForAllPlayers(shop)
    endif
    set shop=null
    return false
endfunction

function PagedButtonsUI___TriggerActionSyncData takes nothing returns nothing
    local player whichPlayer= GetTriggerPlayer()
    local integer playerId= GetPlayerId(whichPlayer)
    local string data= BlzGetTriggerSyncData()
    local integer slot= 0
    local unit shop= PagedButtonsUI___UIShop[playerId]
    local integer id= 0
    local integer newPage= 0
    if ( data == "PreviousPage" ) then
        if ( PagedButtonsUI___PagesIndex[playerId] == 0 ) then
            set PagedButtonsUI___PagesIndex[playerId]=(GetPagedButtonsNonSpacerButtonsCount(PagedButtonsUI___UIShop[(playerId)]) / PagedButtonsUI_MAX_SLOTS) // INLINED!!
        else
            set PagedButtonsUI___PagesIndex[playerId]=PagedButtonsUI___PagesIndex[playerId] - 1
        endif
        call PagedButtonsUI___UpdateItemsForUI(whichPlayer)
        //call BJDebugMsg("Previous pages button with index " + I2S(PagesIndex[playerId]))
    elseif ( data == "NextPage" ) then
        if ( PagedButtonsUI___PagesIndex[playerId] < (GetPagedButtonsNonSpacerButtonsCount(PagedButtonsUI___UIShop[(playerId)]) / PagedButtonsUI_MAX_SLOTS) ) then // INLINED!!
            set PagedButtonsUI___PagesIndex[playerId]=PagedButtonsUI___PagesIndex[playerId] + 1
        else
            set PagedButtonsUI___PagesIndex[playerId]=0
        endif
        call PagedButtonsUI___UpdateItemsForUI(whichPlayer)
        //call BJDebugMsg("Next pages button with index " + I2S(PagesIndex[playerId]))
    elseif ( data == "Checked" ) then
        set PagedButtonsUI___checked[playerId]=true
        call PagedButtonsUI___SetAllSlotChargesVisibleForPlayer(whichPlayer , true)
    elseif ( data == "Unchecked" ) then
        set PagedButtonsUI___checked[playerId]=false
        call PagedButtonsUI___SetAllSlotChargesVisibleForPlayer(whichPlayer , false)
    elseif ( data == "Close" ) then
        call HidePagedButtonsUIForPlayer(whichPlayer)
    else
        set slot=S2I(data)
        set id=GetPagedButtonId(shop , slot)
        set newPage=GetPagedButtonsPageByIndex(shop , slot)
        if ( newPage < GetPagedButtonsMaxPages(shop) and newPage >= 0 ) then
            call SetPagedButtonsPage(shop , newPage)
            if ( id != 0 and ( (s__PagedButtons_Type_whichType[GetPagedButton((shop ) , ( slot))] == PagedButtons_BUTTON_TYPE_UNIT) or (s__PagedButtons_Type_whichType[GetPagedButton((shop ) , ( slot))] == PagedButtons_BUTTON_TYPE_ITEM) ) ) then // INLINED!!
                call IssueNeutralImmediateOrderById(whichPlayer, shop, id)
            endif
        endif
    endif
    set whichPlayer=null
    set shop=null
endfunction

function PagedButtonsUI___Init takes nothing returns nothing
    local player slotPlayer= null
    local integer i= 0
    loop
        exitwhen ( i >= PagedButtonsUI_MAX_SLOTS )
        set PagedButtonsUI___SlotClickTrigger[i]=null
        set PagedButtonsUI___SlotTooltipOnTrigger[i]=null
        set PagedButtonsUI___SlotTooltipOffTrigger[i]=null
        
        set slotPlayer=Player(i)
        if ( GetPlayerSlotState(slotPlayer) == PLAYER_SLOT_STATE_PLAYING and GetPlayerController(slotPlayer) == MAP_CONTROL_USER ) then
            set PagedButtonsUI___enabledForPlayer[i]=true
            call BlzTriggerRegisterPlayerSyncEvent(PagedButtonsUI___syncTrigger, slotPlayer, PagedButtonsUI_PREFIX, false)

            set PagedButtonsUI___previewModelX[i]=0.0
            set PagedButtonsUI___previewModelY[i]=0.0
            set PagedButtonsUI___previewModelScale[i]=0.0
            set PagedButtonsUI___previewModelFile[i]=""

        endif
        set slotPlayer=null
        
        set i=i + 1
    endloop
    call TriggerAddAction(PagedButtonsUI___syncTrigger, function PagedButtonsUI___TriggerActionSyncData)
    

    call BlzLoadTOCFile(PagedButtonsUI_TOC_FILE)

    
    call TriggerRegisterAnyUnitEventBJ(PagedButtonsUI___selectionTrigger, EVENT_PLAYER_UNIT_SELECTED)
    // Barade: Using trigger conditions with selection events led to weird behavior, so use a trigger action here.
    call TriggerAddAction(PagedButtonsUI___selectionTrigger, function PagedButtonsUI___TriggerActionSelected)
    
    call TriggerRegisterChangePagedButtons(PagedButtonsUI___changePageButtonsTrigger)
    call TriggerAddCondition(PagedButtonsUI___changePageButtonsTrigger, Condition(function PagedButtonsUI___TriggerConditionChangePage))
    
    call TriggerRegisterAnyUnitEventBJ(PagedButtonsUI___deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(PagedButtonsUI___deathTrigger, Condition(function PagedButtonsUI___TriggerConditionDeath))

    call TriggerAddAction(OnStartGame___startGameTrigger, (function PagedButtonsUI_CreateUI)) // INLINED!!
    call TriggerAddAction(FrameLoader___actionTrigger, (function PagedButtonsUI_CreateUI)) // INLINED!!
    call TriggerAddAction(FrameSaver___saveTrigger, (function HidePagedButtonsUI)) // INLINED!!

    call TriggerAddAction(FrameSaver___saveTrigger, (function PagedButtonsUI___ResetPreviewFrame)) // Destroying the frame will crash the game. // INLINED!!

endfunction


//library PagedButtonsUI ends
//===========================================================================
// 
// Baradé's Paged Buttons 1.6
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
    set udg_PageName=""
    set udg_PreviousPage=0
    set udg_CurrentPage=0
    set udg_Enabled=false
endfunction

//***************************************************************************
//*
//*  Custom Script Code
//*
//***************************************************************************
//***************************************************************************
//*  FrameSaver

//***************************************************************************
//*  FrameLoader vjass

//***************************************************************************
//*  Barades Item Type Utils
//***************************************************************************
//*  Barades On Start Game
//***************************************************************************
//*  Barades String Utils
//***************************************************************************
//*  Barades String Format
//***************************************************************************
//*  Barades Paged Buttons
//***************************************************************************
//*  Barades Paged Buttons UI



//***************************************************************************
//*  Barades Paged Buttons Config
//***************************************************************************
//*  Map Configs
//***************************************************************************
//*  Marketplace Hook Item
//processed hook: hook UnitDropItem AddItemToMarketplaceUnit
//processed hook: hook WidgetDropItem AddItemToMarketplaceWidget

function AddItemToMarketplaceUnit takes unit inUnit,integer inItemID returns nothing
    set udg_ItemType=inItemID
    call ConditionalTriggerExecute(gg_trg_Marketplace_Add_Item)
endfunction

function AddItemToMarketplaceWidget takes widget inWidget,integer inItemID returns nothing
    set udg_ItemType=inItemID
    call ConditionalTriggerExecute(gg_trg_Marketplace_Add_Item)
endfunction

//***************************************************************************
//*
//*  Unit Item Tables
//*
//***************************************************************************

function Unit000004_DropItems takes nothing returns nothing
    local widget trigWidget= null
    local unit trigUnit= null
    local integer itemID= 0
    local boolean canDrop= true

    set trigWidget=bj_lastDyingWidget
    if ( trigWidget == null ) then
        set trigUnit=GetTriggerUnit()
    endif

    if ( trigUnit != null ) then
        set canDrop=not IsUnitHidden(trigUnit)
        if ( canDrop and GetChangingUnit() != null ) then
            set canDrop=( GetChangingUnitPrevOwner() == Player(PLAYER_NEUTRAL_AGGRESSIVE) )
        endif
    endif

    if ( canDrop ) then
        // Item set 0
        call RandomDistReset()
        call RandomDistAddItem(ChooseRandomItemEx(ITEM_TYPE_ANY, 6), 100)
        set itemID=RandomDistChoose()
        if ( trigUnit != null ) then
            call h__UnitDropItem(trigUnit, itemID)
        else
            call h__WidgetDropItem(trigWidget, itemID)
        endif

    endif

    set bj_lastDyingWidget=null
    call DestroyTrigger(GetTriggeringTrigger())
endfunction

function Unit000014_DropItems takes nothing returns nothing
    local widget trigWidget= null
    local unit trigUnit= null
    local integer itemID= 0
    local boolean canDrop= true

    set trigWidget=bj_lastDyingWidget
    if ( trigWidget == null ) then
        set trigUnit=GetTriggerUnit()
    endif

    if ( trigUnit != null ) then
        set canDrop=not IsUnitHidden(trigUnit)
        if ( canDrop and GetChangingUnit() != null ) then
            set canDrop=( GetChangingUnitPrevOwner() == Player(PLAYER_NEUTRAL_AGGRESSIVE) )
        endif
    endif

    if ( canDrop ) then
        // Item set 0
        call RandomDistReset()
        call RandomDistAddItem('ckng', 50)
        call RandomDistAddItem('ofro', 50)
        set itemID=RandomDistChoose()
        if ( trigUnit != null ) then
            call h__UnitDropItem(trigUnit, itemID)
        else
            call h__WidgetDropItem(trigWidget, itemID)
        endif

    endif

    set bj_lastDyingWidget=null
    call DestroyTrigger(GetTriggeringTrigger())
endfunction

function Unit000023_DropItems takes nothing returns nothing
    local widget trigWidget= null
    local unit trigUnit= null
    local integer itemID= 0
    local boolean canDrop= true

    set trigWidget=bj_lastDyingWidget
    if ( trigWidget == null ) then
        set trigUnit=GetTriggerUnit()
    endif

    if ( trigUnit != null ) then
        set canDrop=not IsUnitHidden(trigUnit)
        if ( canDrop and GetChangingUnit() != null ) then
            set canDrop=( GetChangingUnitPrevOwner() == Player(PLAYER_NEUTRAL_AGGRESSIVE) )
        endif
    endif

    if ( canDrop ) then
        // Item set 0
        call RandomDistReset()
        call RandomDistAddItem(ChooseRandomItemEx(ITEM_TYPE_ANY, 2), 100)
        set itemID=RandomDistChoose()
        if ( trigUnit != null ) then
            call h__UnitDropItem(trigUnit, itemID)
        else
            call h__WidgetDropItem(trigWidget, itemID)
        endif

    endif

    set bj_lastDyingWidget=null
    call DestroyTrigger(GetTriggeringTrigger())
endfunction

function Unit000037_DropItems takes nothing returns nothing
    local widget trigWidget= null
    local unit trigUnit= null
    local integer itemID= 0
    local boolean canDrop= true

    set trigWidget=bj_lastDyingWidget
    if ( trigWidget == null ) then
        set trigUnit=GetTriggerUnit()
    endif

    if ( trigUnit != null ) then
        set canDrop=not IsUnitHidden(trigUnit)
        if ( canDrop and GetChangingUnit() != null ) then
            set canDrop=( GetChangingUnitPrevOwner() == Player(PLAYER_NEUTRAL_AGGRESSIVE) )
        endif
    endif

    if ( canDrop ) then
        // Item set 0
        call RandomDistReset()
        call RandomDistAddItem(ChooseRandomItemEx(ITEM_TYPE_ANY, 3), 100)
        set itemID=RandomDistChoose()
        if ( trigUnit != null ) then
            call h__UnitDropItem(trigUnit, itemID)
        else
            call h__WidgetDropItem(trigWidget, itemID)
        endif

    endif

    set bj_lastDyingWidget=null
    call DestroyTrigger(GetTriggeringTrigger())
endfunction


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

    set u=BlzCreateUnitWithSkin(p, 'hcas', - 320.0, 1280.0, 270.000, 'hcas')
endfunction

//===========================================================================
function CreateUnitsForPlayer0 takes nothing returns nothing
    local player p= Player(0)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set gg_unit_Hpal_0000=BlzCreateUnitWithSkin(p, 'Hpal', - 313.8, - 66.3, 270.000, 'Hpal')
    call SetHeroLevel(gg_unit_Hpal_0000, 10, false)
    call SelectHeroSkill(gg_unit_Hpal_0000, 'AHhb')
    call SelectHeroSkill(gg_unit_Hpal_0000, 'AHhb')
    call SelectHeroSkill(gg_unit_Hpal_0000, 'AHhb')
    call SelectHeroSkill(gg_unit_Hpal_0000, 'AHad')
    call SelectHeroSkill(gg_unit_Hpal_0000, 'AHad')
    call SelectHeroSkill(gg_unit_Hpal_0000, 'AHad')
    call SelectHeroSkill(gg_unit_Hpal_0000, 'AHre')
    call SelectHeroSkill(gg_unit_Hpal_0000, 'AHds')
    call SelectHeroSkill(gg_unit_Hpal_0000, 'AHds')
    call SelectHeroSkill(gg_unit_Hpal_0000, 'AHds')
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

    set u=BlzCreateUnitWithSkin(p, 'hcas', 192.0, 1280.0, 270.000, 'hcas')
endfunction

//===========================================================================
function CreateUnitsForPlayer1 takes nothing returns nothing
    local player p= Player(1)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'hpea', 89.3, 1585.3, 90.000, 'hpea')
    set u=BlzCreateUnitWithSkin(p, 'hpea', 164.2, 1582.8, 90.000, 'hpea')
    set gg_unit_Hpal_0029=BlzCreateUnitWithSkin(p, 'Hpal', - 185.3, - 61.8, 270.000, 'Hpal')
    call SetHeroLevel(gg_unit_Hpal_0029, 10, false)
    call SelectHeroSkill(gg_unit_Hpal_0029, 'AHhb')
    call SelectHeroSkill(gg_unit_Hpal_0029, 'AHhb')
    call SelectHeroSkill(gg_unit_Hpal_0029, 'AHhb')
    call SelectHeroSkill(gg_unit_Hpal_0029, 'AHad')
    call SelectHeroSkill(gg_unit_Hpal_0029, 'AHad')
    call SelectHeroSkill(gg_unit_Hpal_0029, 'AHad')
    call SelectHeroSkill(gg_unit_Hpal_0029, 'AHre')
    call SelectHeroSkill(gg_unit_Hpal_0029, 'AHds')
    call SelectHeroSkill(gg_unit_Hpal_0029, 'AHds')
    call SelectHeroSkill(gg_unit_Hpal_0029, 'AHds')
    set u=BlzCreateUnitWithSkin(p, 'hpea', 237.9, 1582.5, 90.000, 'hpea')
    set u=BlzCreateUnitWithSkin(p, 'hpea', 298.0, 1577.8, 90.000, 'hpea')
    set u=BlzCreateUnitWithSkin(p, 'hpea', 345.3, 1579.9, 90.000, 'hpea')
endfunction

//===========================================================================
function CreateNeutralHostile takes nothing returns nothing
    local player p= Player(PLAYER_NEUTRAL_AGGRESSIVE)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set unitID=ChooseRandomCreep(3)
    if ( unitID != - 1 ) then
        set u=BlzCreateUnitWithSkin(p, unitID, - 2626.9, - 2959.2, 57.000, unitID)
        set t=CreateTrigger()
        call TriggerRegisterUnitEvent(t, u, EVENT_UNIT_DEATH)
        call TriggerRegisterUnitEvent(t, u, EVENT_UNIT_CHANGE_OWNER)
        call TriggerAddAction(t, function Unit000037_DropItems)
    endif
    set u=BlzCreateUnitWithSkin(p, 'nftr', - 2446.9, 270.5, 263.251, 'nftr')
    set u=BlzCreateUnitWithSkin(p, 'nfsp', - 2393.8, 112.8, 256.121, 'nfsp')
    set u=BlzCreateUnitWithSkin(p, 'nftb', - 2543.6, 188.6, 268.900, 'nftb')
    set t=CreateTrigger()
    call TriggerRegisterUnitEvent(t, u, EVENT_UNIT_DEATH)
    call TriggerRegisterUnitEvent(t, u, EVENT_UNIT_CHANGE_OWNER)
    call TriggerAddAction(t, function Unit000014_DropItems)
    set unitID=ChooseRandomCreep(2)
    if ( unitID != - 1 ) then
        set u=BlzCreateUnitWithSkin(p, unitID, - 2551.3, - 3066.2, 265.990, unitID)
    endif
    set unitID=ChooseRandomCreep(2)
    if ( unitID != - 1 ) then
        set u=BlzCreateUnitWithSkin(p, unitID, - 2739.3, - 2985.9, 155.590, unitID)
    endif
    set unitID=ChooseRandomCreep(3)
    if ( unitID != - 1 ) then
        set u=BlzCreateUnitWithSkin(p, unitID, 2332.0, - 2485.9, 45.390, unitID)
        set t=CreateTrigger()
        call TriggerRegisterUnitEvent(t, u, EVENT_UNIT_DEATH)
        call TriggerRegisterUnitEvent(t, u, EVENT_UNIT_CHANGE_OWNER)
        call TriggerAddAction(t, function Unit000023_DropItems)
    endif
    set unitID=ChooseRandomCreep(2)
    if ( unitID != - 1 ) then
        set u=BlzCreateUnitWithSkin(p, unitID, 2312.8, - 2677.9, 237.760, unitID)
    endif
    set unitID=ChooseRandomCreep(2)
    if ( unitID != - 1 ) then
        set u=BlzCreateUnitWithSkin(p, unitID, 2484.3, - 2499.4, 230.230, unitID)
    endif
    set unitID=ChooseRandomCreep(4)
    if ( unitID != - 1 ) then
        set u=BlzCreateUnitWithSkin(p, unitID, 3034.6, - 442.8, 262.660, unitID)
    endif
    set unitID=ChooseRandomCreep(4)
    if ( unitID != - 1 ) then
        set u=BlzCreateUnitWithSkin(p, unitID, 3034.4, - 276.1, 146.840, unitID)
    endif
    set unitID=ChooseRandomCreep(6)
    if ( unitID != - 1 ) then
        set u=BlzCreateUnitWithSkin(p, unitID, 2920.6, - 348.4, 158.160, unitID)
        set t=CreateTrigger()
        call TriggerRegisterUnitEvent(t, u, EVENT_UNIT_DEATH)
        call TriggerRegisterUnitEvent(t, u, EVENT_UNIT_CHANGE_OWNER)
        call TriggerAddAction(t, function Unit000004_DropItems)
    endif
endfunction

//===========================================================================
function CreateNeutralPassiveBuildings takes nothing returns nothing
    local player p= Player(PLAYER_NEUTRAL_PASSIVE)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'n001', - 640.0, 256.0, 270.000, 'n001')
    set u=BlzCreateUnitWithSkin(p, 'n000', - 256.0, 256.0, 270.000, 'n000')
    call SetUnitColor(u, ConvertPlayerColor(0))
    set u=BlzCreateUnitWithSkin(p, 'n002', 192.0, 256.0, 270.000, 'n002')
    set u=BlzCreateUnitWithSkin(p, 'n003', - 1024.0, 256.0, 270.000, 'n003')
    call SetUnitColor(u, ConvertPlayerColor(0))
    set u=BlzCreateUnitWithSkin(p, 'ngol', - 256.0, 2176.0, 270.000, 'ngol')
    call SetResourceAmount(u, 1000000)
    set u=BlzCreateUnitWithSkin(p, 'ngol', 256.0, 2176.0, 270.000, 'ngol')
    call SetResourceAmount(u, 1000000)
    set u=BlzCreateUnitWithSkin(p, 'n004', 1024.0, 256.0, 270.000, 'n004')
    set u=BlzCreateUnitWithSkin(p, 'n005', 640.0, 256.0, 270.000, 'n005')
    call SetUnitColor(u, ConvertPlayerColor(0))
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
    call CreateNeutralHostile()
    call CreatePlayerUnits()
endfunction

//***************************************************************************
//*
//*  Regions
//*
//***************************************************************************

function CreateRegions takes nothing returns nothing
    local weathereffect we

    set gg_rct_dummy_sell_item=Rect(- 2816.0, 2304.0, - 2688.0, 2432.0)
endfunction

//***************************************************************************
//*
//*  Triggers
//*
//***************************************************************************

//===========================================================================
// Trigger: Callback Change Shop Page
//===========================================================================
function Trig_Callback_Change_Shop_Page_Actions takes nothing returns nothing
    set udg_Shop2=(PagedButtons___triggerShop) // INLINED!!
    set udg_PreviousPage=(PagedButtons___triggerPreviousPage) + 1 // INLINED!!
    set udg_CurrentPage=GetPagedButtonsPage(udg_Shop2) + 1
    call DisplayTextToForce(GetPlayersAll(), ( "Change page of shop " + ( GetUnitName(udg_Shop2) + ( " to page " + ( I2S(udg_CurrentPage) + ( " with previous page " + ( I2S(udg_PreviousPage) + "." ) ) ) ) ) ))
endfunction

//===========================================================================
function InitTrig_Callback_Change_Shop_Page takes nothing returns nothing
    set gg_trg_Callback_Change_Shop_Page=CreateTrigger()
    call TriggerAddAction(gg_trg_Callback_Change_Shop_Page, function Trig_Callback_Change_Shop_Page_Actions)
endfunction

//===========================================================================
// Trigger: Callback Object Available
//===========================================================================
function Trig_Callback_Object_Available_Actions takes nothing returns nothing
    set udg_Shop2=(PagedButtons___triggerShop) // INLINED!!
    set udg_PageName=GetObjectName((PagedButtons___triggerAvailableObject)) // INLINED!!
    call DisplayTextToForce(GetPlayersAll(), ( udg_PageName + ( " is available in shop " + ( GetUnitName(udg_Shop2) + "." ) ) ))
    call PingMinimapLocForForce(GetPlayersAll(), GetUnitLoc(udg_Shop2), 1)
endfunction

//===========================================================================
function InitTrig_Callback_Object_Available takes nothing returns nothing
    set gg_trg_Callback_Object_Available=CreateTrigger()
    call TriggerAddAction(gg_trg_Callback_Object_Available, function Trig_Callback_Object_Available_Actions)
endfunction

//===========================================================================
// Trigger: Initialization
//===========================================================================
function Trig_Initialization_Actions takes nothing returns nothing
    call SetMapFlag(MAP_FOG_ALWAYS_VISIBLE, true)
    call SetMapFlag(MAP_FOG_MAP_EXPLORED, true)
    call MeleeStartingVisibility()
    call MeleeStartingHeroLimit()
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
    call ForForce(GetPlayersAll(), function Trig_Game_Start_Func002A)
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_011")
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_037")
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_046")
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_047")
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_040")
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_036")
    call SelectUnitForPlayerSingle(gg_unit_Hpal_0000, Player(0))
    call SelectUnitForPlayerSingle(gg_unit_Hpal_0029, Player(1))
endfunction

//===========================================================================
function InitTrig_Game_Start takes nothing returns nothing
    set gg_trg_Game_Start=CreateTrigger()
    call TriggerRegisterTimerEventSingle(gg_trg_Game_Start, 0.00)
    call TriggerAddAction(gg_trg_Game_Start, function Trig_Game_Start_Actions)
endfunction

//===========================================================================
// Trigger: Shops
//===========================================================================
function Trig_Shops_Func001A takes nothing returns nothing
    set udg_Shop=GetEnumUnit()
    call EnablePagedButtons(udg_Shop)
    // Red Dragons
    set udg_PageName="Red Dragons"
    call NextPagedButtonsPage(udg_Shop , udg_PageName)
    set udg_UnitType='nrdk'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nrdr'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nrwm'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    // Green Dragons
    set udg_PageName="Green Dragons"
    call NextPagedButtonsPage(udg_Shop , udg_PageName)
    set udg_UnitType='ngrw'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='ngdk'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='ngrd'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    // Black Dragons
    set udg_PageName="Black Dragons"
    call NextPagedButtonsPage(udg_Shop , udg_PageName)
    set udg_UnitType='nbdr'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nbdk'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nbwm'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    // Blue Dragons
    set udg_PageName="Blue Dragons"
    call NextPagedButtonsPage(udg_Shop , udg_PageName)
    set udg_UnitType='nadw'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nadk'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nadr'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    // Bronze Dragons
    set udg_PageName="Bronze Dragons"
    call NextPagedButtonsPage(udg_Shop , udg_PageName)
    set udg_UnitType='nbzw'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nbzk'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nbzd'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    // Nether Dragons
    set udg_PageName="Nether Dragons"
    call NextPagedButtonsPage(udg_Shop , udg_PageName)
    set udg_UnitType='nnht'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nndk'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nndr'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
endfunction

function Trig_Shops_Func002A takes nothing returns nothing
    set udg_Shop=GetEnumUnit()
    call EnablePagedButtons(udg_Shop)
    // Lordaeron Summer
    set udg_PageName="Lordaeron Summer"
    call NextPagedButtonsPage(udg_Shop , udg_PageName)
    set udg_UnitType='nftr'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nfsp'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nftt'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nftb'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nfsh'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nftk'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='ngna'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='ngns'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='ngno'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='ngnb'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='ngnw'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='ngnv'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='ngrk'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='ngst'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nggr'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nogr'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nomg'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nogm'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nogl'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nmrl'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nmrr'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nmrm'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nspb'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nspg'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    // Lordaeron Winter
    set udg_PageName="Lordaeron Winter"
    call NextPagedButtonsPage(udg_Shop , udg_PageName)
    set udg_UnitType='nitr'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nitp'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nitt'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nits'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nith'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nitw'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    // Ashenvale
    set udg_PageName="Ashenvale"
    call NextPagedButtonsPage(udg_Shop , udg_PageName)
    set udg_UnitType='ndtr'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='ndtp'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='ndtt'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='ndtb'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='ndth'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='ndtw'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nfrl'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nfrs'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nfrb'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nfrg'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nfre'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nfra'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nspr'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nssp'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nsgt'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nsbm'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nltl'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nthl'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nstw'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nsty'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nsat'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nsts'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nstl'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nsth'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nwlt'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nwlg'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nwld'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    // Feldwood
    set udg_PageName="Felwood"
    call NextPagedButtonsPage(udg_Shop , udg_PageName)
    set udg_UnitType='nenc'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nenp'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nepl'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='npfl'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nfel'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='npfm'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nmpg'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nmfs'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nmmu'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nslm'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nslf'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nsln'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nbal'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='ninf'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    // Barrens
    set udg_PageName="Barrens"
    call NextPagedButtonsPage(udg_Shop , udg_PageName)
    set udg_UnitType='ncea'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='ncer'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='ncim'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='ncen'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='ncks'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='ncnk'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nhar'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nhrr'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nhrw'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nhrh'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nhrq'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nowb'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nowe'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nowk'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nrzt'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nrzs'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nqbh'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nrzb'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nrzm'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nrzg'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    // Cityscape
    set udg_PageName="Cityscape"
    call NextPagedButtonsPage(udg_Shop , udg_PageName)
    set udg_UnitType='nban'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nbrg'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nrog'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nass'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nenf'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nbld'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nhfp'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nhdc'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nhhr'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nkob'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nkog'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nkot'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nkol'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nwiz'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nwzr'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nwzg'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nwzd'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    // Dalaran
    set udg_PageName="Dalaran"
    call NextPagedButtonsPage(udg_Shop , udg_PageName)
    set udg_UnitType='nele'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nelb'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    // Dalaran Ruins
    set udg_PageName="Dalaran Ruins"
    call NextPagedButtonsPage(udg_Shop , udg_PageName)
    set udg_UnitType='ndrj'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='ndmu'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    // Dungeon
    set udg_PageName="Dungeon"
    call NextPagedButtonsPage(udg_Shop , udg_PageName)
    set udg_UnitType='ngh1'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='ngh2'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='narg'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nwrg'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nsgg'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nrvf'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nrvl'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nrvd'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nslh'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nslr'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nslv'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nsll'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nska'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nskf'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nske'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nskg'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    // Icecrown Glacier
    set udg_PageName="Icecrown Glacier"
    call NextPagedButtonsPage(udg_Shop , udg_PageName)
    set udg_UnitType='nanm'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nanb'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nanc'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nanw'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nane'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nano'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nbdm'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nbda'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nbdw'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nbds'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nbdo'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nfor'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nfot'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nfod'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nmgw'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nmgr'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nmgd'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nmam'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nmit'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nmdr'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nspd'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nnwa'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nnwl'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nnwr'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nnws'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nnwq'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nplb'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nplg'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nfpl'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nfps'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nfpt'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nfpc'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nfpe'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nfpu'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='ntkf'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='ntka'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='ntkh'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='ntkt'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='ntkw'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='ntks'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='ntkc'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nubk'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nubr'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nubw'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    // Northrend
    set udg_PageName="Northrend"
    call NextPagedButtonsPage(udg_Shop , udg_PageName)
    set udg_UnitType='nrvs'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nrvi'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nwen'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nwnr'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nwns'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nwna'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nwwf'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nwwg'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nwwd'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    // Sunken Ruins
    set udg_PageName="Sunken Ruins"
    call NextPagedButtonsPage(udg_Shop , udg_PageName)
    set udg_UnitType='nscb'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nsc2'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nsc3'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nrel'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nsel'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nsgn'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nsgh'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nsgb'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nhyh'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nhyd'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nehy'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nahy'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nlpr'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nlpd'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nltc'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nlds'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nlsn'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nlkl'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nmcf'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nmbg'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nmtw'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nmsn'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nmrv'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nmsc'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='ntrv'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nsrv'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='ndrv'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nlrv'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nsko'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nsog'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nsoc'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nsra'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nsrh'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nsrn'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nsrw'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='ntrh'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='ntrs'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='ntrt'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='ntrg'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='ntrd'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='njg1'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='njga'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='njgb'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
endfunction

function Trig_Shops_Func003A takes nothing returns nothing
    set udg_Shop=GetEnumUnit()
    call EnablePagedButtons(udg_Shop)
    // Misc 1
    set udg_PageName="Misc 1"
    call NextPagedButtonsPage(udg_Shop , udg_PageName)
    set udg_ItemType='stwp'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='bspd'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='dust'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='tret'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='prvt'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='cnob'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='stel'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='pnvl'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='shea'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    // Misc 2
    set udg_PageName="Misc 2"
    call NextPagedButtonsPage(udg_Shop , udg_PageName)
    set udg_ItemType='spro'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='pinv'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    // Potions
    set udg_PageName="Potions"
    call NextPagedButtonsPage(udg_Shop , udg_PageName)
    set udg_ItemType='pman'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='pgma'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='phea'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='pghe'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='rej1'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='rej2'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='rej3'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='rej4'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    // Rings
    set udg_PageName="Rings"
    call NextPagedButtonsPage(udg_Shop , udg_PageName)
    set udg_ItemType='rde0'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='rde1'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='rde2'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='rde3'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='rde4'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='rlif'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
endfunction

function Trig_Shops_Func004A takes nothing returns nothing
    set udg_Shop=GetEnumUnit()
    call EnablePagedButtons(udg_Shop)
    // Human Heroes
    set udg_PageName="Human Heroes"
    call NextPagedButtonsPage(udg_Shop , udg_PageName)
    set udg_UnitType='Hpal'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='Hamg'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='Hmkg'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='Hblm'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    // Orc Heroes
    set udg_PageName="Orc Heroes"
    call NextPagedButtonsPage(udg_Shop , udg_PageName)
    set udg_UnitType='Obla'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='Ofar'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='Otch'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='Oshd'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    // Undead Heroes
    set udg_PageName="Undead Heroes"
    call NextPagedButtonsPage(udg_Shop , udg_PageName)
    set udg_UnitType='Udea'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='Ulic'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='Udre'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='Ucrl'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    // Night Elf Heroes
    set udg_PageName="Night Elf Heroes"
    call NextPagedButtonsPage(udg_Shop , udg_PageName)
    set udg_UnitType='Ekee'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='Emoo'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='Edem'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='Ewar'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    // Neutral Heroes
    set udg_PageName="Neutral Heroes"
    call NextPagedButtonsPage(udg_Shop , udg_PageName)
    set udg_UnitType='Nalc'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='Nngs'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='Ntin'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='Nbst'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='Npbm'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='Nbrn'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='Nfir'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='Nplh'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
endfunction

function Trig_Shops_Func005A takes nothing returns nothing
    set udg_Shop=GetEnumUnit()
    call EnablePagedButtons(udg_Shop)
    // Units
    set udg_PageName="Units"
    call NextPagedButtonsPage(udg_Shop , udg_PageName)
    set udg_UnitType='ngsp'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='nzep'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    set udg_UnitType='ngir'
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
    // Abilities
    set udg_PageName="Abilities"
    call NextPagedButtonsPage(udg_Shop , udg_PageName)
    set udg_Ability='Andt'
call AddPagedButtonsId((udg_Shop ) , ( udg_Ability) , PagedButtons_BUTTON_TYPE_ABILITY) // INLINED!!
    set udg_Ability='Ansp'
call AddPagedButtonsId((udg_Shop ) , ( udg_Ability) , PagedButtons_BUTTON_TYPE_ABILITY) // INLINED!!
endfunction

function Trig_Shops_Func006A takes nothing returns nothing
    set udg_Shop=GetEnumUnit()
    call EnablePagedButtons(udg_Shop)
    set udg_PageName="Creeps"
    call NextPagedButtonsPage(udg_Shop , udg_PageName)
endfunction

function Trig_Shops_Actions takes nothing returns nothing
    call ForGroupBJ(GetUnitsOfTypeIdAll('n002'), function Trig_Shops_Func001A)
    call ForGroupBJ(GetUnitsOfTypeIdAll('n000'), function Trig_Shops_Func002A)
    call ForGroupBJ(GetUnitsOfTypeIdAll('n001'), function Trig_Shops_Func003A)
    call ForGroupBJ(GetUnitsOfTypeIdAll('n003'), function Trig_Shops_Func004A)
    call ForGroupBJ(GetUnitsOfTypeIdAll('n004'), function Trig_Shops_Func005A)
    call ForGroupBJ(GetUnitsOfTypeIdAll('n005'), function Trig_Shops_Func006A)
    // Callbacks
    call TriggerRegisterChangePagedButtons(gg_trg_Callback_Change_Shop_Page)
    call TriggerRegisterObjectAvailable(gg_trg_Callback_Object_Available)
endfunction

//===========================================================================
function InitTrig_Shops takes nothing returns nothing
    set gg_trg_Shops=CreateTrigger()
    call TriggerAddAction(gg_trg_Shops, function Trig_Shops_Actions)
endfunction

//===========================================================================
// Trigger: No UI
//===========================================================================
function Trig_No_UI_Actions takes nothing returns nothing
    set PagedButtonsUI___enabledForPlayer[GetPlayerId((GetTriggerPlayer() ))]=( false) // INLINED!!
    call QuestMessageBJ(GetForceOfPlayer(GetTriggerPlayer()), bj_QUESTMESSAGE_WARNING, "TRIGSTR_048")
endfunction

//===========================================================================
function InitTrig_No_UI takes nothing returns nothing
    set gg_trg_No_UI=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_No_UI, Player(0), "-noui", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_No_UI, Player(1), "-noui", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_No_UI, Player(2), "-noui", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_No_UI, Player(3), "-noui", true)
    call TriggerAddAction(gg_trg_No_UI, function Trig_No_UI_Actions)
endfunction

//===========================================================================
// Trigger: UI
//===========================================================================
function Trig_UI_Actions takes nothing returns nothing
    set PagedButtonsUI___enabledForPlayer[GetPlayerId((GetTriggerPlayer() ))]=( true) // INLINED!!
    call QuestMessageBJ(GetForceOfPlayer(GetTriggerPlayer()), bj_QUESTMESSAGE_ALWAYSHINT, "TRIGSTR_049")
endfunction

//===========================================================================
function InitTrig_UI takes nothing returns nothing
    set gg_trg_UI=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_UI, Player(0), "-ui", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_UI, Player(1), "-ui", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_UI, Player(2), "-ui", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_UI, Player(3), "-ui", true)
    call TriggerAddAction(gg_trg_UI, function Trig_UI_Actions)
endfunction

//===========================================================================
// Trigger: No Drakes
//===========================================================================
function Trig_No_Drakes_Func002A takes nothing returns nothing
    set udg_Shop=GetEnumUnit()
    set udg_UnitType='nrdr'
    call SetPagedButtonEnabled(udg_Shop , GetPagedButtonIndex(udg_Shop , udg_UnitType) , udg_Enabled)
    set udg_UnitType='ngdk'
    call SetPagedButtonEnabled(udg_Shop , GetPagedButtonIndex(udg_Shop , udg_UnitType) , udg_Enabled)
    set udg_UnitType='nbdk'
    call SetPagedButtonEnabled(udg_Shop , GetPagedButtonIndex(udg_Shop , udg_UnitType) , udg_Enabled)
    set udg_UnitType='nadk'
    call SetPagedButtonEnabled(udg_Shop , GetPagedButtonIndex(udg_Shop , udg_UnitType) , udg_Enabled)
    set udg_UnitType='nbzk'
    call SetPagedButtonEnabled(udg_Shop , GetPagedButtonIndex(udg_Shop , udg_UnitType) , udg_Enabled)
    set udg_UnitType='nndk'
    call SetPagedButtonEnabled(udg_Shop , GetPagedButtonIndex(udg_Shop , udg_UnitType) , udg_Enabled)
endfunction

function Trig_No_Drakes_Actions takes nothing returns nothing
    set udg_Enabled=false
    call ForGroupBJ(GetUnitsOfTypeIdAll('n002'), function Trig_No_Drakes_Func002A)
    call QuestMessageBJ(GetPlayersAll(), bj_QUESTMESSAGE_WARNING, "TRIGSTR_042")
endfunction

//===========================================================================
function InitTrig_No_Drakes takes nothing returns nothing
    set gg_trg_No_Drakes=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_No_Drakes, Player(0), "-nodrakes", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_No_Drakes, Player(1), "-nodrakes", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_No_Drakes, Player(2), "-nodrakes", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_No_Drakes, Player(3), "-nodrakes", true)
    call TriggerAddAction(gg_trg_No_Drakes, function Trig_No_Drakes_Actions)
endfunction

//===========================================================================
// Trigger: Drakes
//===========================================================================
function Trig_Drakes_Func002A takes nothing returns nothing
    set udg_Shop=GetEnumUnit()
    set udg_UnitType='nrdr'
    call SetPagedButtonEnabled(udg_Shop , GetPagedButtonIndex(udg_Shop , udg_UnitType) , udg_Enabled)
    set udg_UnitType='ngdk'
    call SetPagedButtonEnabled(udg_Shop , GetPagedButtonIndex(udg_Shop , udg_UnitType) , udg_Enabled)
    set udg_UnitType='nbdk'
    call SetPagedButtonEnabled(udg_Shop , GetPagedButtonIndex(udg_Shop , udg_UnitType) , udg_Enabled)
    set udg_UnitType='nadk'
    call SetPagedButtonEnabled(udg_Shop , GetPagedButtonIndex(udg_Shop , udg_UnitType) , udg_Enabled)
    set udg_UnitType='nbzk'
    call SetPagedButtonEnabled(udg_Shop , GetPagedButtonIndex(udg_Shop , udg_UnitType) , udg_Enabled)
    set udg_UnitType='nndk'
    call SetPagedButtonEnabled(udg_Shop , GetPagedButtonIndex(udg_Shop , udg_UnitType) , udg_Enabled)
endfunction

function Trig_Drakes_Actions takes nothing returns nothing
    set udg_Enabled=true
    call ForGroupBJ(GetUnitsOfTypeIdAll('n002'), function Trig_Drakes_Func002A)
    call QuestMessageBJ(GetPlayersAll(), bj_QUESTMESSAGE_UNITAVAILABLE, "TRIGSTR_043")
endfunction

//===========================================================================
function InitTrig_Drakes takes nothing returns nothing
    set gg_trg_Drakes=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_Drakes, Player(0), "-drakes", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Drakes, Player(1), "-drakes", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Drakes, Player(2), "-drakes", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Drakes, Player(3), "-drakes", true)
    call TriggerAddAction(gg_trg_Drakes, function Trig_Drakes_Actions)
endfunction

//===========================================================================
// Trigger: Build Shop
//===========================================================================
function Trig_Build_Shop_Func001C takes nothing returns boolean
    if ( ( GetUnitTypeId(GetConstructedStructure()) == 'hvlt' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetConstructedStructure()) == 'ovln' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetConstructedStructure()) == 'utom' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetConstructedStructure()) == 'eden' ) ) then
        return true
    endif
    return false
endfunction

function Trig_Build_Shop_Conditions takes nothing returns boolean
    if ( not Trig_Build_Shop_Func001C() ) then
        return false
    endif
    return true
endfunction

function Trig_Build_Shop_Func086Func003C takes nothing returns boolean
    if ( ( GetUnitTypeId(GetConstructedStructure()) == 'hvlt' ) ) then
        return true
    endif
    return false
endfunction

function Trig_Build_Shop_Func086C takes nothing returns boolean
    if ( not Trig_Build_Shop_Func086Func003C() ) then
        return false
    endif
    return true
endfunction

function Trig_Build_Shop_Func087Func003C takes nothing returns boolean
    if ( ( GetUnitTypeId(GetConstructedStructure()) == 'ovln' ) ) then
        return true
    endif
    return false
endfunction

function Trig_Build_Shop_Func087C takes nothing returns boolean
    if ( not Trig_Build_Shop_Func087Func003C() ) then
        return false
    endif
    return true
endfunction

function Trig_Build_Shop_Func088Func003C takes nothing returns boolean
    if ( ( GetUnitTypeId(GetConstructedStructure()) == 'utom' ) ) then
        return true
    endif
    return false
endfunction

function Trig_Build_Shop_Func088C takes nothing returns boolean
    if ( not Trig_Build_Shop_Func088Func003C() ) then
        return false
    endif
    return true
endfunction

function Trig_Build_Shop_Func089Func003C takes nothing returns boolean
    if ( ( GetUnitTypeId(GetConstructedStructure()) == 'eden' ) ) then
        return true
    endif
    return false
endfunction

function Trig_Build_Shop_Func089C takes nothing returns boolean
    if ( not Trig_Build_Shop_Func089Func003C() ) then
        return false
    endif
    return true
endfunction

function Trig_Build_Shop_Actions takes nothing returns nothing
    set udg_Shop=GetConstructedStructure()
    call EnablePagedButtons(udg_Shop)
    call SetPagedButtonsSlotsPerPage(udg_Shop , 9)
    // Human
    set udg_PageName="Human"
    call NextPagedButtonsPage(udg_Shop , udg_PageName)
    set udg_ItemType='sreg'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='mcri'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='plcl'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='phea'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='pman'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='stwp'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='tsct'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='ofir'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='ssan'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    // Orc
    set udg_PageName="Orc"
    call NextPagedButtonsPage(udg_Shop , udg_PageName)
    set udg_ItemType='shas'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='hslv'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='dust'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='phea'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='pman'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='stwp'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='tgrh'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='oli2'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    // Undead
    set udg_PageName="Undead"
    call NextPagedButtonsPage(udg_Shop , udg_PageName)
    set udg_ItemType='rnec'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='plcl'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='skul'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='phea'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='pman'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='stwp'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='ocor'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='shea'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    // Night Elf
    set udg_PageName="Night Elf"
    call NextPagedButtonsPage(udg_Shop , udg_PageName)
    set udg_ItemType='moon'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='plcl'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='dust'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='phea'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='pman'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='stwp'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='spre'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='oven'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    set udg_ItemType='pams'
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
    // Current Page
    if ( Trig_Build_Shop_Func086C() ) then
        call SetPagedButtonsPage(udg_Shop , 0)
    else
        call DoNothing()
    endif
    if ( Trig_Build_Shop_Func087C() ) then
        call SetPagedButtonsPage(udg_Shop , 1)
    else
        call DoNothing()
    endif
    if ( Trig_Build_Shop_Func088C() ) then
        call SetPagedButtonsPage(udg_Shop , 2)
    else
        call DoNothing()
    endif
    if ( Trig_Build_Shop_Func089C() ) then
        call SetPagedButtonsPage(udg_Shop , 3)
    else
        call DoNothing()
    endif
endfunction

//===========================================================================
function InitTrig_Build_Shop takes nothing returns nothing
    set gg_trg_Build_Shop=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Build_Shop, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    call TriggerAddCondition(gg_trg_Build_Shop, Condition(function Trig_Build_Shop_Conditions))
    call TriggerAddAction(gg_trg_Build_Shop, function Trig_Build_Shop_Actions)
endfunction

//===========================================================================
// Trigger: Marketplace Add Unit
//===========================================================================
function Trig_Marketplace_Add_Unit_Conditions takes nothing returns boolean
    if ( not ( GetOwningPlayer(GetTriggerUnit()) == Player(PLAYER_NEUTRAL_AGGRESSIVE) ) ) then
        return false
    endif
    return true
endfunction

function Trig_Marketplace_Add_Unit_Func002A takes nothing returns nothing
    set udg_Shop=GetEnumUnit()
call AddPagedButtonsId((udg_Shop ) , ( udg_UnitType) , PagedButtons_BUTTON_TYPE_UNIT) // INLINED!!
endfunction

function Trig_Marketplace_Add_Unit_Actions takes nothing returns nothing
    set udg_UnitType=GetUnitTypeId(GetTriggerUnit())
    call ForGroupBJ(GetUnitsOfTypeIdAll('n005'), function Trig_Marketplace_Add_Unit_Func002A)
endfunction

//===========================================================================
function InitTrig_Marketplace_Add_Unit takes nothing returns nothing
    set gg_trg_Marketplace_Add_Unit=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Marketplace_Add_Unit, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Marketplace_Add_Unit, Condition(function Trig_Marketplace_Add_Unit_Conditions))
    call TriggerAddAction(gg_trg_Marketplace_Add_Unit, function Trig_Marketplace_Add_Unit_Actions)
endfunction

//===========================================================================
// Trigger: Marketplace Add Item
//===========================================================================
function Trig_Marketplace_Add_Item_Func001A takes nothing returns nothing
    set udg_Shop=GetEnumUnit()
call AddPagedButtonsId((udg_Shop ) , ( udg_ItemType) , PagedButtons_BUTTON_TYPE_ITEM) // INLINED!!
endfunction

function Trig_Marketplace_Add_Item_Actions takes nothing returns nothing
    call ForGroupBJ(GetUnitsOfTypeIdAll('n005'), function Trig_Marketplace_Add_Item_Func001A)
endfunction

//===========================================================================
function InitTrig_Marketplace_Add_Item takes nothing returns nothing
    set gg_trg_Marketplace_Add_Item=CreateTrigger()
    call TriggerAddAction(gg_trg_Marketplace_Add_Item, function Trig_Marketplace_Add_Item_Actions)
endfunction

//===========================================================================
// Trigger: Marketplace Sells Unit
//===========================================================================
function Trig_Marketplace_Sells_Unit_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetSellingUnit()) == 'n005' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Marketplace_Sells_Unit_Actions takes nothing returns nothing
    set udg_Shop=GetSellingUnit()
    set udg_UnitType=GetUnitTypeId(GetSoldUnit())
    call RemovePagedButtonsId(udg_Shop , udg_UnitType)
endfunction

//===========================================================================
function InitTrig_Marketplace_Sells_Unit takes nothing returns nothing
    set gg_trg_Marketplace_Sells_Unit=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Marketplace_Sells_Unit, EVENT_PLAYER_UNIT_SELL)
    call TriggerAddCondition(gg_trg_Marketplace_Sells_Unit, Condition(function Trig_Marketplace_Sells_Unit_Conditions))
    call TriggerAddAction(gg_trg_Marketplace_Sells_Unit, function Trig_Marketplace_Sells_Unit_Actions)
endfunction

//===========================================================================
// Trigger: Marketplace Sells Item
//===========================================================================
function Trig_Marketplace_Sells_Item_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetSellingUnit()) == 'n005' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Marketplace_Sells_Item_Actions takes nothing returns nothing
    set udg_Shop=GetSellingUnit()
    set udg_ItemType=GetItemTypeId(GetSoldItem())
    call RemovePagedButtonsId(udg_Shop , udg_UnitType)
endfunction

//===========================================================================
function InitTrig_Marketplace_Sells_Item takes nothing returns nothing
    set gg_trg_Marketplace_Sells_Item=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Marketplace_Sells_Item, EVENT_PLAYER_UNIT_SELL_ITEM)
    call TriggerAddCondition(gg_trg_Marketplace_Sells_Item, Condition(function Trig_Marketplace_Sells_Item_Conditions))
    call TriggerAddAction(gg_trg_Marketplace_Sells_Item, function Trig_Marketplace_Sells_Item_Actions)
endfunction

//===========================================================================
function InitCustomTriggers takes nothing returns nothing
    call InitTrig_Callback_Change_Shop_Page()
    call InitTrig_Callback_Object_Available()
    call InitTrig_Initialization()
    call InitTrig_Game_Start()
    call InitTrig_Shops()
    call InitTrig_No_UI()
    call InitTrig_UI()
    call InitTrig_No_Drakes()
    call InitTrig_Drakes()
    call InitTrig_Build_Shop()
    call InitTrig_Marketplace_Add_Unit()
    call InitTrig_Marketplace_Add_Item()
    call InitTrig_Marketplace_Sells_Unit()
    call InitTrig_Marketplace_Sells_Item()
endfunction

//===========================================================================
function RunInitializationTriggers takes nothing returns nothing
    call ConditionalTriggerExecute(gg_trg_Initialization)
    call ConditionalTriggerExecute(gg_trg_Shops)
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
    call SetPlayerRacePreference(Player(0), RACE_PREF_UNDEAD)
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
    // Force: TRIGSTR_006
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
    call CreateRegions()
    call CreateAllUnits()
    call InitBlizzard()

call ExecuteFunc("jasshelper__initstructs671848390")
call ExecuteFunc("FrameLoader___init_function")
call ExecuteFunc("FrameSaver___Init")
call ExecuteFunc("OnStartGame___Init")
call ExecuteFunc("PagedButtonsConfig___Init")
call ExecuteFunc("MapConfigs___Init")
call ExecuteFunc("PagedButtons___Init")
call ExecuteFunc("PagedButtonsUI___Init")

    call InitGlobals()
    call InitCustomTriggers()
    call RunInitializationTriggers()

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

    call DefineStartLocation(0, - 256.0, - 128.0)
    call DefineStartLocation(1, - 256.0, - 128.0)

    // Player setup
    call InitCustomPlayerSlots()
    call InitCustomTeams()
    call InitAllyPriorities()
endfunction




//Struct method generated initializers/callers:
function sa__PagedButtons_SlotType_onDestroy takes nothing returns boolean
local integer this=f__arg_this
        local boolean found= false
        local integer i= 0
        loop
            exitwhen ( i >= s__PagedButtons_SlotType_listCounter )
            if ( s__PagedButtons_SlotType_list[i] == this ) then
                set found=true
            endif
            if ( found ) then
                set s__PagedButtons_SlotType_list[i]=s__PagedButtons_SlotType_list[i + 1]
                set s__PagedButtons_SlotType_list[i + 1]=0
            endif
            set i=i + 1
        endloop
        if ( found ) then
            set s__PagedButtons_SlotType_listCounter=s__PagedButtons_SlotType_listCounter - 1
        endif
    set f__arg_this=this
   return true
endfunction
function sa__PagedButtons_SpacerType_onDestroy takes nothing returns boolean
local integer this=f__arg_this
    set f__arg_this=this
   return true
endfunction
function sa___prototype44_DisablePagedButtons takes nothing returns boolean
    set f__result_boolean=DisablePagedButtons(f__arg_unit1)
    return true
endfunction
function sa___prototype33_AddItemToMarketplaceUnit takes nothing returns boolean
    call AddItemToMarketplaceUnit(f__arg_unit1,f__arg_integer1)
    return true
endfunction
function sa___prototype56_AddItemToMarketplaceWidget takes nothing returns boolean
    call AddItemToMarketplaceWidget(f__arg_widget1,f__arg_integer1)
    return true
endfunction

function jasshelper__initstructs671848390 takes nothing returns nothing
    set st__PagedButtons_Type_onDestroy[3]=null
    set st__PagedButtons_Type_onDestroy[5]=CreateTrigger()
    call TriggerAddCondition(st__PagedButtons_Type_onDestroy[5],Condition( function sa__PagedButtons_SlotType_onDestroy))
    set st__PagedButtons_Type_onDestroy[4]=CreateTrigger()
    call TriggerAddCondition(st__PagedButtons_Type_onDestroy[4],Condition( function sa__PagedButtons_SpacerType_onDestroy))
    set st___prototype44[1]=CreateTrigger()
    call TriggerAddAction(st___prototype44[1],function sa___prototype44_DisablePagedButtons)
    call TriggerAddCondition(st___prototype44[1],Condition(function sa___prototype44_DisablePagedButtons))
    set st___prototype33[1]=CreateTrigger()
    call TriggerAddAction(st___prototype33[1],function sa___prototype33_AddItemToMarketplaceUnit)
    call TriggerAddCondition(st___prototype33[1],Condition(function sa___prototype33_AddItemToMarketplaceUnit))
    set st___prototype56[1]=CreateTrigger()
    call TriggerAddAction(st___prototype56[1],function sa___prototype56_AddItemToMarketplaceWidget)
    call TriggerAddCondition(st___prototype56[1],Condition(function sa___prototype56_AddItemToMarketplaceWidget))










endfunction

