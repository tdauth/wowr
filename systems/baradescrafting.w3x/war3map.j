globals
//globals from FrameLoader:
constant boolean LIBRARY_FrameLoader=true
trigger FrameLoader__eventTrigger= CreateTrigger()
trigger FrameLoader__actionTrigger= CreateTrigger()
timer FrameLoader__t= CreateTimer()
//endglobals from FrameLoader
//globals from FrameSaver:
constant boolean LIBRARY_FrameSaver=true
constant real FrameSaver__DELAY= 5.0
trigger FrameSaver__saveTrigger= CreateTrigger()
trigger FrameSaver__loadTrigger= CreateTrigger()
trigger FrameSaver__afterSaveTrigger= CreateTrigger()
timer FrameSaver__t= CreateTimer()
//endglobals from FrameSaver
//globals from ItemTypeUtils:
constant boolean LIBRARY_ItemTypeUtils=true
    // Barade: Cache all the values for better performance.
hashtable ItemTypeUtils__h= InitHashtable()
    
constant integer ItemTypeUtils__SHOP= 'ngme'
constant integer ItemTypeUtils__SELL_UNIT= 'Hpal'
//endglobals from ItemTypeUtils
//globals from OpLimit:
constant boolean LIBRARY_OpLimit=true
//endglobals from OpLimit
//globals from PagedButtons:
constant boolean LIBRARY_PagedButtons=true
constant integer PagedButtons_NEXT_PAGE_ID= 'h000'
constant integer PagedButtons_PREVIOUS_PAGE_ID= 'h001'
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
    
constant boolean PagedButtons_AUTO_UPDATE_STOCKS= false
    // Define this as true to prevent items from being removed completely from non-marketplace shops.
constant boolean PagedButtons_ENABLE_FAKE_MARKETPLACE_ITEM_REMOVAL= true
constant boolean PagedButtons_HOOK_REMOVE_UNIT= true
    // This delay hreshold is required to avoid wrong item or unit types being removed due to still refilling stocks.
constant integer PagedButtons_STOCK_DELAY_THRESHOLD= 1
    
constant integer PagedButtons_BUTTON_TYPE_UNIT= 0
constant integer PagedButtons_BUTTON_TYPE_ITEM= 1
constant integer PagedButtons_BUTTON_TYPE_ABILITY= 2
constant integer PagedButtons_BUTTON_TYPE_SPACER= 3
    
hashtable PagedButtons__h= InitHashtable()
group PagedButtons__shops= CreateGroup()
trigger PagedButtons__deathTrigger= null
trigger PagedButtons__sellUnitTrigger= CreateTrigger()
trigger PagedButtons__sellItemTrigger= CreateTrigger()
timer PagedButtons__autoUpdateStockTimer= CreateTimer()
    
    // callbacks
trigger array PagedButtons__callbackTriggersChangePageButtons
integer PagedButtons__callbackTriggersChangePageButtonsCounter= 0
trigger array PagedButtons__callbackTriggersObjectAvailable
integer PagedButtons__callbackTriggersObjectAvailableCounter= 0
unit PagedButtons__triggerShop= null
integer PagedButtons__triggerPreviousPage= 0
integer PagedButtons__triggerAvailableObject= 0
//endglobals from PagedButtons
//globals from SimError:
constant boolean LIBRARY_SimError=true
sound SimError__error= null
//endglobals from SimError
//globals from StringUtils:
constant boolean LIBRARY_StringUtils=true
//endglobals from StringUtils
//globals from PagedButtonsUI:
constant boolean LIBRARY_PagedButtonsUI=true
    // Specifies if a charge number is shown which indicates the slot's page.
constant boolean PagedButtonsUI_SHOW_PAGE_NUMBERS= false
    // Specifies if preview registered models for IDs are shown below the tooltip.
constant boolean PagedButtonsUI_SHOW_PREVIEW_MODELS= false
constant integer PagedButtonsUI_MAX_SLOTS= 130
constant integer PagedButtonsUI_MAX_SLOTS_PER_LINE= 13
constant integer PagedButtonsUI_HERO_GOLD_COST= 425
constant integer PagedButtonsUI_HERO_LUMBER_COST= 100
constant string PagedButtonsUI_BUY_TEXT= "|n|n|cff808080Click to buy and open the page.|R|n"
constant string PagedButtonsUI_NEXT_PAGE_TEXT= "|cffFCD20DNext Page|r"
constant string PagedButtonsUI_PREVIOUS_PAGE_TEXT= "|cffFCD20DPrevious Page|r"
constant string PagedButtonsUI_OPEN_TEXT= "|n|n|cff808080Click to open the page.|R|n"
constant string PagedButtonsUI_CLOSE_TEXT= "|cffFCD20DClose|r"
constant string PagedButtonsUI_PREFIX= "PagedButtonsUI"
constant string PagedButtonsUI_TOC_FILE= "war3mapImported\\xxx.toc"
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
    
boolean array PagedButtonsUI__enabledForPlayer
boolean array PagedButtonsUI__UIVisible
unit array PagedButtonsUI__UIShop
integer array PagedButtonsUI__PagesIndex
framehandle PagedButtonsUI__BackgroundFrame
framehandle PagedButtonsUI__TitleFrame
framehandle array PagedButtonsUI__SlotFrame
framehandle array PagedButtonsUI__SlotBackdropFrame
framehandle array PagedButtonsUI__SlotChargesBackgroundFrame
framehandle array PagedButtonsUI__SlotChargesFrame
framehandle array PagedButtonsUI__SlotPageBackgroundFrame
framehandle array PagedButtonsUI__SlotPageFrame
trigger array PagedButtonsUI__SlotClickTrigger
trigger array PagedButtonsUI__SlotTooltipOnTrigger
trigger array PagedButtonsUI__SlotTooltipOffTrigger
framehandle PagedButtonsUI__TooltipFrame
framehandle PagedButtonsUI__PageNameText
framehandle PagedButtonsUI__TooltipIcon
framehandle PagedButtonsUI__SummonFrame
framehandle PagedButtonsUI__ItemGoldFrame
framehandle PagedButtonsUI__ItemGoldIconFrame
framehandle PagedButtonsUI__ItemLumberFrame
framehandle PagedButtonsUI__ItemLumberIconFrame
framehandle PagedButtonsUI__ItemFoodFrame
framehandle PagedButtonsUI__ItemFoodIconFrame
framehandle PagedButtonsUI__TooltipText
framehandle PagedButtonsUI__PreviewSprite= null
effect PagedButtonsUI__PreviewEffect= null
framehandle PagedButtonsUI__NextPagesButton
trigger PagedButtonsUI__NextPagesTrigger= null
framehandle PagedButtonsUI__PreviousPagesButton
trigger PagedButtonsUI__PreviousPagesTrigger= null
framehandle PagedButtonsUI__Checkbox
trigger PagedButtonsUI__CheckedTrigger= null
trigger PagedButtonsUI__UncheckedTrigger= null
framehandle PagedButtonsUI__CloseButton
trigger PagedButtonsUI__CloseTrigger= null
    
boolean PagedButtonsUI__checked= false
    // static if (SHOW_PREVIEW_MODELS) then
real array PagedButtonsUI__previewModelX
real array PagedButtonsUI__previewModelY
real array PagedButtonsUI__previewModelScale
string array PagedButtonsUI__previewModelFile
    //endif
    
hashtable PagedButtonsUI__h= InitHashtable()
trigger PagedButtonsUI__SyncTrigger= CreateTrigger()
trigger PagedButtonsUI__selectionTrigger= CreateTrigger()
trigger PagedButtonsUI__changePageButtonsTrigger= CreateTrigger()
trigger PagedButtonsUI__deathTrigger= CreateTrigger()
//endglobals from PagedButtonsUI
//globals from StringFormat:
constant boolean LIBRARY_StringFormat=true
//endglobals from StringFormat
//globals from Crafting:
constant boolean LIBRARY_Crafting=true
constant integer Crafting_MAX_REQUIREMENTS= 30
constant integer Crafting_MAX_SLOTS= 7
constant integer Crafting_DISASSEMBLE_ABILITY_ID= 'A000'
    // We can only set the start delay and replenish interval of items to 3600 seconds maximum.
    // This interval defines how often the stocks are updated and start again with their start delay.
constant real Crafting_UPDATE_INTERVAL= 60.0

integer array Crafting___recipesItemTypeIds
integer array Crafting___recipesUIItemTypeIds
boolean array Crafting___recipesIsUnit
boolean array Crafting___recipesIsSpacer
string array Crafting___recipesPageName
boolean array Crafting___recipesNotAvailableForPlayer
integer array Crafting___recipesMinRequirements
integer array Crafting___recipesRequirementCounters
integer array Crafting___recipesRequirementItemTypeIds
integer array Crafting___recipesRequirementCharges
boolean array Crafting___recipesRequirementConsume
integer Crafting___recipesCounter= 0

    // callbacks
integer Crafting___recipeRequirementCallback= 0
trigger Crafting___recipeRequirementCallbackTrigger= null
trigger Crafting___recipeShowCallbackTrigger= null
trigger array Crafting___craftingCallbackTriggers
integer Crafting___craftingCallbackTriggersCounter= 0
trigger array Crafting___craftingCallbackUnitTriggers
integer Crafting___craftingCallbackUnitTriggersCounter= 0
trigger array Crafting___disassembleCallbackTriggers
integer Crafting___disassembleCallbackTriggersCounter= 0
    
integer Crafting___lastCreatedRecipe= 0

integer Crafting___triggerRecipe= 0
unit Crafting___triggerCraftingUnit= null
item Crafting___triggerCraftedItem= null
unit Crafting___triggerCraftedUnit= null
integer Crafting___triggerCraftedCharges= 0

group Crafting___itemCraftingUnits= CreateGroup()
trigger Crafting___pickupTrigger= CreateTrigger()
trigger Crafting___dropTrigger= CreateTrigger()
trigger Crafting___itemCraftTrigger= CreateTrigger()
trigger Crafting___itemDisassembleTrigger= CreateTrigger()

hashtable Crafting___itemCraftingUnitsHashTable= InitHashtable()
trigger Crafting___itemCraftingChangePageTrigger= CreateTrigger()
timer Crafting___itemCraftingStockUpdateTimer= CreateTimer()
    
    // update food available
trigger Crafting___trainStartTrigger= CreateTrigger()
trigger Crafting___trainCancelTrigger= CreateTrigger()
trigger Crafting___sellTrigger= CreateTrigger()
trigger Crafting___reviveStartTrigger= CreateTrigger()
trigger Crafting___reviveCancelTrigger= CreateTrigger()
trigger Crafting___deathTrigger= CreateTrigger()
    

constant integer Crafting___HASHTABLE_KEY_PAGE= 0
constant integer Crafting___HASHTABLE_KEY_GROUP= 1
constant integer Crafting___HASHTABLE_KEY_DISABLED_RECIPES= 2
unit Crafting___tmpUnit= null
integer Crafting___tmpInteger0= 0
//endglobals from Crafting
//globals from MapCrafting:
constant boolean LIBRARY_MapCrafting=true
//endglobals from MapCrafting
    // User-defined
integer udg_TmpItemType= 0
integer udg_TmpItemType2= 0
unit udg_TmpUnit= null
item udg_TmpItem= null
integer udg_TmpInteger= 0
integer udg_TmpInteger2= 0
string udg_TmpString
integer udg_TmpUnitType= 0
integer udg_TmpUnitType2= 0
unit udg_TmpUnit2= null
integer udg_RecipeVictoryPotion= 0
integer udg_RecipeDefeatPotion= 0

    // Generated
rect gg_rct_Shop_Dummy= null
trigger gg_trg_Crafting_Init_Recipes= null
trigger gg_trg_Crafting_Start= null
trigger gg_trg_Crafting_On_Crafting_Item= null
trigger gg_trg_Crafting_On_Crafting_Unit= null
trigger gg_trg_Crafting_On_Disassemble_Item= null
trigger gg_trg_Crafting_On_Requirement= null
trigger gg_trg_Crafting_On_Show= null
trigger gg_trg_Initialization= null
trigger gg_trg_Game_Start= null
trigger gg_trg_Potion_of_Victory= null
trigger gg_trg_Potion_of_Defeat= null

trigger l__library_init

//JASSHelper struct globals:
constant integer si__PagedButtons_Type=1
integer si__PagedButtons_Type_F=0
integer si__PagedButtons_Type_I=0
integer array si__PagedButtons_Type_V
integer array si__PagedButtons_Type_2V
integer array si__PagedButtons_Type_3V
integer array si__PagedButtons_Type_4V
integer array si__PagedButtons_Type_5V
integer array si__PagedButtons_Type_6V
integer array si__PagedButtons_Type_7V
integer array si__PagedButtons_Type_8V
integer array si__PagedButtons_Type_9V
integer array si__PagedButtons_Type_10V
integer array si__PagedButtons_Type_11V
integer array si__PagedButtons_Type_12V
integer array si__PagedButtons_Type_13V
boolean array s__PagedButtons_Type_2shown
boolean array s__PagedButtons_Type_3shown
boolean array s__PagedButtons_Type_4shown
boolean array s__PagedButtons_Type_5shown
boolean array s__PagedButtons_Type_6shown
boolean array s__PagedButtons_Type_7shown
boolean array s__PagedButtons_Type_8shown
boolean array s__PagedButtons_Type_9shown
boolean array s__PagedButtons_Type_10shown
boolean array s__PagedButtons_Type_11shown
boolean array s__PagedButtons_Type_12shown
boolean array s__PagedButtons_Type_13shown
boolean array s__PagedButtons_Type_shown
boolean array s__PagedButtons_Type_2enabled
boolean array s__PagedButtons_Type_3enabled
boolean array s__PagedButtons_Type_4enabled
boolean array s__PagedButtons_Type_5enabled
boolean array s__PagedButtons_Type_6enabled
boolean array s__PagedButtons_Type_7enabled
boolean array s__PagedButtons_Type_8enabled
boolean array s__PagedButtons_Type_9enabled
boolean array s__PagedButtons_Type_10enabled
boolean array s__PagedButtons_Type_11enabled
boolean array s__PagedButtons_Type_12enabled
boolean array s__PagedButtons_Type_13enabled
boolean array s__PagedButtons_Type_enabled
integer array s__PagedButtons_Type_2whichType
integer array s__PagedButtons_Type_3whichType
integer array s__PagedButtons_Type_4whichType
integer array s__PagedButtons_Type_5whichType
integer array s__PagedButtons_Type_6whichType
integer array s__PagedButtons_Type_7whichType
integer array s__PagedButtons_Type_8whichType
integer array s__PagedButtons_Type_9whichType
integer array s__PagedButtons_Type_10whichType
integer array s__PagedButtons_Type_11whichType
integer array s__PagedButtons_Type_12whichType
integer array s__PagedButtons_Type_13whichType
integer array s__PagedButtons_Type_whichType
constant integer si__PagedButtons_SpacerType=2
constant integer si__PagedButtons_SlotType=3
unit array s__PagedButtons_SlotType_2shop
unit array s__PagedButtons_SlotType_3shop
unit array s__PagedButtons_SlotType_4shop
unit array s__PagedButtons_SlotType_5shop
unit array s__PagedButtons_SlotType_6shop
unit array s__PagedButtons_SlotType_7shop
unit array s__PagedButtons_SlotType_8shop
unit array s__PagedButtons_SlotType_9shop
unit array s__PagedButtons_SlotType_10shop
unit array s__PagedButtons_SlotType_11shop
unit array s__PagedButtons_SlotType_12shop
unit array s__PagedButtons_SlotType_13shop
unit array s__PagedButtons_SlotType_shop
integer array s__PagedButtons_SlotType_2id
integer array s__PagedButtons_SlotType_3id
integer array s__PagedButtons_SlotType_4id
integer array s__PagedButtons_SlotType_5id
integer array s__PagedButtons_SlotType_6id
integer array s__PagedButtons_SlotType_7id
integer array s__PagedButtons_SlotType_8id
integer array s__PagedButtons_SlotType_9id
integer array s__PagedButtons_SlotType_10id
integer array s__PagedButtons_SlotType_11id
integer array s__PagedButtons_SlotType_12id
integer array s__PagedButtons_SlotType_13id
integer array s__PagedButtons_SlotType_id
integer array s__PagedButtons_SlotType_2startStock
integer array s__PagedButtons_SlotType_3startStock
integer array s__PagedButtons_SlotType_4startStock
integer array s__PagedButtons_SlotType_5startStock
integer array s__PagedButtons_SlotType_6startStock
integer array s__PagedButtons_SlotType_7startStock
integer array s__PagedButtons_SlotType_8startStock
integer array s__PagedButtons_SlotType_9startStock
integer array s__PagedButtons_SlotType_10startStock
integer array s__PagedButtons_SlotType_11startStock
integer array s__PagedButtons_SlotType_12startStock
integer array s__PagedButtons_SlotType_13startStock
integer array s__PagedButtons_SlotType_startStock
integer array s__PagedButtons_SlotType_2maxStock
integer array s__PagedButtons_SlotType_3maxStock
integer array s__PagedButtons_SlotType_4maxStock
integer array s__PagedButtons_SlotType_5maxStock
integer array s__PagedButtons_SlotType_6maxStock
integer array s__PagedButtons_SlotType_7maxStock
integer array s__PagedButtons_SlotType_8maxStock
integer array s__PagedButtons_SlotType_9maxStock
integer array s__PagedButtons_SlotType_10maxStock
integer array s__PagedButtons_SlotType_11maxStock
integer array s__PagedButtons_SlotType_12maxStock
integer array s__PagedButtons_SlotType_13maxStock
integer array s__PagedButtons_SlotType_maxStock
integer array s__PagedButtons_SlotType_2currentStock
integer array s__PagedButtons_SlotType_3currentStock
integer array s__PagedButtons_SlotType_4currentStock
integer array s__PagedButtons_SlotType_5currentStock
integer array s__PagedButtons_SlotType_6currentStock
integer array s__PagedButtons_SlotType_7currentStock
integer array s__PagedButtons_SlotType_8currentStock
integer array s__PagedButtons_SlotType_9currentStock
integer array s__PagedButtons_SlotType_10currentStock
integer array s__PagedButtons_SlotType_11currentStock
integer array s__PagedButtons_SlotType_12currentStock
integer array s__PagedButtons_SlotType_13currentStock
integer array s__PagedButtons_SlotType_currentStock
integer array s__PagedButtons_SlotType_2startDelay
integer array s__PagedButtons_SlotType_3startDelay
integer array s__PagedButtons_SlotType_4startDelay
integer array s__PagedButtons_SlotType_5startDelay
integer array s__PagedButtons_SlotType_6startDelay
integer array s__PagedButtons_SlotType_7startDelay
integer array s__PagedButtons_SlotType_8startDelay
integer array s__PagedButtons_SlotType_9startDelay
integer array s__PagedButtons_SlotType_10startDelay
integer array s__PagedButtons_SlotType_11startDelay
integer array s__PagedButtons_SlotType_12startDelay
integer array s__PagedButtons_SlotType_13startDelay
integer array s__PagedButtons_SlotType_startDelay
integer array s__PagedButtons_SlotType_2replenishInterval
integer array s__PagedButtons_SlotType_3replenishInterval
integer array s__PagedButtons_SlotType_4replenishInterval
integer array s__PagedButtons_SlotType_5replenishInterval
integer array s__PagedButtons_SlotType_6replenishInterval
integer array s__PagedButtons_SlotType_7replenishInterval
integer array s__PagedButtons_SlotType_8replenishInterval
integer array s__PagedButtons_SlotType_9replenishInterval
integer array s__PagedButtons_SlotType_10replenishInterval
integer array s__PagedButtons_SlotType_11replenishInterval
integer array s__PagedButtons_SlotType_12replenishInterval
integer array s__PagedButtons_SlotType_13replenishInterval
integer array s__PagedButtons_SlotType_replenishInterval
boolean array s__PagedButtons_SlotType_2replenish
boolean array s__PagedButtons_SlotType_3replenish
boolean array s__PagedButtons_SlotType_4replenish
boolean array s__PagedButtons_SlotType_5replenish
boolean array s__PagedButtons_SlotType_6replenish
boolean array s__PagedButtons_SlotType_7replenish
boolean array s__PagedButtons_SlotType_8replenish
boolean array s__PagedButtons_SlotType_9replenish
boolean array s__PagedButtons_SlotType_10replenish
boolean array s__PagedButtons_SlotType_11replenish
boolean array s__PagedButtons_SlotType_12replenish
boolean array s__PagedButtons_SlotType_13replenish
boolean array s__PagedButtons_SlotType_replenish
integer array s__PagedButtons_SlotType_2elapsedTimeStartDelay
integer array s__PagedButtons_SlotType_3elapsedTimeStartDelay
integer array s__PagedButtons_SlotType_4elapsedTimeStartDelay
integer array s__PagedButtons_SlotType_5elapsedTimeStartDelay
integer array s__PagedButtons_SlotType_6elapsedTimeStartDelay
integer array s__PagedButtons_SlotType_7elapsedTimeStartDelay
integer array s__PagedButtons_SlotType_8elapsedTimeStartDelay
integer array s__PagedButtons_SlotType_9elapsedTimeStartDelay
integer array s__PagedButtons_SlotType_10elapsedTimeStartDelay
integer array s__PagedButtons_SlotType_11elapsedTimeStartDelay
integer array s__PagedButtons_SlotType_12elapsedTimeStartDelay
integer array s__PagedButtons_SlotType_13elapsedTimeStartDelay
integer array s__PagedButtons_SlotType_elapsedTimeStartDelay
integer array s__PagedButtons_SlotType_2elapsedTimeReplenishInterval
integer array s__PagedButtons_SlotType_3elapsedTimeReplenishInterval
integer array s__PagedButtons_SlotType_4elapsedTimeReplenishInterval
integer array s__PagedButtons_SlotType_5elapsedTimeReplenishInterval
integer array s__PagedButtons_SlotType_6elapsedTimeReplenishInterval
integer array s__PagedButtons_SlotType_7elapsedTimeReplenishInterval
integer array s__PagedButtons_SlotType_8elapsedTimeReplenishInterval
integer array s__PagedButtons_SlotType_9elapsedTimeReplenishInterval
integer array s__PagedButtons_SlotType_10elapsedTimeReplenishInterval
integer array s__PagedButtons_SlotType_11elapsedTimeReplenishInterval
integer array s__PagedButtons_SlotType_12elapsedTimeReplenishInterval
integer array s__PagedButtons_SlotType_13elapsedTimeReplenishInterval
integer array s__PagedButtons_SlotType_elapsedTimeReplenishInterval
boolean array s__PagedButtons_SlotType_2startDelayDone
boolean array s__PagedButtons_SlotType_3startDelayDone
boolean array s__PagedButtons_SlotType_4startDelayDone
boolean array s__PagedButtons_SlotType_5startDelayDone
boolean array s__PagedButtons_SlotType_6startDelayDone
boolean array s__PagedButtons_SlotType_7startDelayDone
boolean array s__PagedButtons_SlotType_8startDelayDone
boolean array s__PagedButtons_SlotType_9startDelayDone
boolean array s__PagedButtons_SlotType_10startDelayDone
boolean array s__PagedButtons_SlotType_11startDelayDone
boolean array s__PagedButtons_SlotType_12startDelayDone
boolean array s__PagedButtons_SlotType_13startDelayDone
boolean array s__PagedButtons_SlotType_startDelayDone
integer array s__PagedButtons_SlotType_list
integer s__PagedButtons_SlotType_listCounter= 0
constant integer si__PagedButtons_Page=4
integer si__PagedButtons_Page_F=0
integer si__PagedButtons_Page_I=0
integer array si__PagedButtons_Page_V
integer array si__PagedButtons_Page_2V
integer array si__PagedButtons_Page_3V
integer array si__PagedButtons_Page_4V
integer array si__PagedButtons_Page_5V
integer array si__PagedButtons_Page_6V
integer array si__PagedButtons_Page_7V
integer array si__PagedButtons_Page_8V
integer array si__PagedButtons_Page_9V
integer array si__PagedButtons_Page_10V
integer array si__PagedButtons_Page_11V
integer array si__PagedButtons_Page_12V
integer array si__PagedButtons_Page_13V
string array s__PagedButtons_Page_2name
string array s__PagedButtons_Page_3name
string array s__PagedButtons_Page_4name
string array s__PagedButtons_Page_5name
string array s__PagedButtons_Page_6name
string array s__PagedButtons_Page_7name
string array s__PagedButtons_Page_8name
string array s__PagedButtons_Page_9name
string array s__PagedButtons_Page_10name
string array s__PagedButtons_Page_11name
string array s__PagedButtons_Page_12name
string array s__PagedButtons_Page_13name
string array s__PagedButtons_Page_name
constant integer si__PagedButtons_Shop=5
integer si__PagedButtons_Shop_F=0
integer si__PagedButtons_Shop_I=0
integer array si__PagedButtons_Shop_V
integer array si__PagedButtons_Shop_2V
integer array si__PagedButtons_Shop_3V
integer array si__PagedButtons_Shop_4V
integer array si__PagedButtons_Shop_5V
integer array si__PagedButtons_Shop_6V
integer array si__PagedButtons_Shop_7V
integer array si__PagedButtons_Shop_8V
integer array si__PagedButtons_Shop_9V
integer array si__PagedButtons_Shop_10V
integer array si__PagedButtons_Shop_11V
integer array si__PagedButtons_Shop_12V
integer array si__PagedButtons_Shop_13V
integer array s__PagedButtons_Shop_2slotsPerPage
integer array s__PagedButtons_Shop_3slotsPerPage
integer array s__PagedButtons_Shop_4slotsPerPage
integer array s__PagedButtons_Shop_5slotsPerPage
integer array s__PagedButtons_Shop_6slotsPerPage
integer array s__PagedButtons_Shop_7slotsPerPage
integer array s__PagedButtons_Shop_8slotsPerPage
integer array s__PagedButtons_Shop_9slotsPerPage
integer array s__PagedButtons_Shop_10slotsPerPage
integer array s__PagedButtons_Shop_11slotsPerPage
integer array s__PagedButtons_Shop_12slotsPerPage
integer array s__PagedButtons_Shop_13slotsPerPage
integer array s__PagedButtons_Shop_slotsPerPage
integer array s__PagedButtons_Shop_2currentPage
integer array s__PagedButtons_Shop_3currentPage
integer array s__PagedButtons_Shop_4currentPage
integer array s__PagedButtons_Shop_5currentPage
integer array s__PagedButtons_Shop_6currentPage
integer array s__PagedButtons_Shop_7currentPage
integer array s__PagedButtons_Shop_8currentPage
integer array s__PagedButtons_Shop_9currentPage
integer array s__PagedButtons_Shop_10currentPage
integer array s__PagedButtons_Shop_11currentPage
integer array s__PagedButtons_Shop_12currentPage
integer array s__PagedButtons_Shop_13currentPage
integer array s__PagedButtons_Shop_currentPage
string array s__PagedButtons_Shop_2name
string array s__PagedButtons_Shop_3name
string array s__PagedButtons_Shop_4name
string array s__PagedButtons_Shop_5name
string array s__PagedButtons_Shop_6name
string array s__PagedButtons_Shop_7name
string array s__PagedButtons_Shop_8name
string array s__PagedButtons_Shop_9name
string array s__PagedButtons_Shop_10name
string array s__PagedButtons_Shop_11name
string array s__PagedButtons_Shop_12name
string array s__PagedButtons_Shop_13name
string array s__PagedButtons_Shop_name
integer array s__PagedButtons_Shop_2whichType
integer array s__PagedButtons_Shop_3whichType
integer array s__PagedButtons_Shop_4whichType
integer array s__PagedButtons_Shop_5whichType
integer array s__PagedButtons_Shop_6whichType
integer array s__PagedButtons_Shop_7whichType
integer array s__PagedButtons_Shop_8whichType
integer array s__PagedButtons_Shop_9whichType
integer array s__PagedButtons_Shop_10whichType
integer array s__PagedButtons_Shop_11whichType
integer array s__PagedButtons_Shop_12whichType
integer array s__PagedButtons_Shop_13whichType
integer array s__PagedButtons_Shop_whichType
integer array s___PagedButtons_Shop_buttons
integer array s__2_PagedButtons_Shop_buttons
integer array s__3_PagedButtons_Shop_buttons
integer array s__4_PagedButtons_Shop_buttons
integer array s__5_PagedButtons_Shop_buttons
integer array s__6_PagedButtons_Shop_buttons
integer array s__7_PagedButtons_Shop_buttons
integer array s__8_PagedButtons_Shop_buttons
integer array s__9_PagedButtons_Shop_buttons
integer array s__10_PagedButtons_Shop_buttons
integer array s__11_PagedButtons_Shop_buttons
integer array s__12_PagedButtons_Shop_buttons
integer array s__13_PagedButtons_Shop_buttons
constant integer s___PagedButtons_Shop_buttons_size=1000
integer array s__PagedButtons_Shop_2buttons
integer array s__PagedButtons_Shop_3buttons
integer array s__PagedButtons_Shop_4buttons
integer array s__PagedButtons_Shop_5buttons
integer array s__PagedButtons_Shop_6buttons
integer array s__PagedButtons_Shop_7buttons
integer array s__PagedButtons_Shop_8buttons
integer array s__PagedButtons_Shop_9buttons
integer array s__PagedButtons_Shop_10buttons
integer array s__PagedButtons_Shop_11buttons
integer array s__PagedButtons_Shop_12buttons
integer array s__PagedButtons_Shop_13buttons
integer array s__PagedButtons_Shop_buttons
integer array s__PagedButtons_Shop_2buttonsCount
integer array s__PagedButtons_Shop_3buttonsCount
integer array s__PagedButtons_Shop_4buttonsCount
integer array s__PagedButtons_Shop_5buttonsCount
integer array s__PagedButtons_Shop_6buttonsCount
integer array s__PagedButtons_Shop_7buttonsCount
integer array s__PagedButtons_Shop_8buttonsCount
integer array s__PagedButtons_Shop_9buttonsCount
integer array s__PagedButtons_Shop_10buttonsCount
integer array s__PagedButtons_Shop_11buttonsCount
integer array s__PagedButtons_Shop_12buttonsCount
integer array s__PagedButtons_Shop_13buttonsCount
integer array s__PagedButtons_Shop_buttonsCount
integer array s___PagedButtons_Shop_pages
integer array s__2_PagedButtons_Shop_pages
integer array s__3_PagedButtons_Shop_pages
integer array s__4_PagedButtons_Shop_pages
integer array s__5_PagedButtons_Shop_pages
integer array s__6_PagedButtons_Shop_pages
integer array s__7_PagedButtons_Shop_pages
integer array s__8_PagedButtons_Shop_pages
integer array s__9_PagedButtons_Shop_pages
integer array s__10_PagedButtons_Shop_pages
integer array s__11_PagedButtons_Shop_pages
integer array s__12_PagedButtons_Shop_pages
integer array s__13_PagedButtons_Shop_pages
constant integer s___PagedButtons_Shop_pages_size=500
integer array s__PagedButtons_Shop_2pages
integer array s__PagedButtons_Shop_3pages
integer array s__PagedButtons_Shop_4pages
integer array s__PagedButtons_Shop_5pages
integer array s__PagedButtons_Shop_6pages
integer array s__PagedButtons_Shop_7pages
integer array s__PagedButtons_Shop_8pages
integer array s__PagedButtons_Shop_9pages
integer array s__PagedButtons_Shop_10pages
integer array s__PagedButtons_Shop_11pages
integer array s__PagedButtons_Shop_12pages
integer array s__PagedButtons_Shop_13pages
integer array s__PagedButtons_Shop_pages
integer array s__PagedButtons_Shop_2maxPages
integer array s__PagedButtons_Shop_3maxPages
integer array s__PagedButtons_Shop_4maxPages
integer array s__PagedButtons_Shop_5maxPages
integer array s__PagedButtons_Shop_6maxPages
integer array s__PagedButtons_Shop_7maxPages
integer array s__PagedButtons_Shop_8maxPages
integer array s__PagedButtons_Shop_9maxPages
integer array s__PagedButtons_Shop_10maxPages
integer array s__PagedButtons_Shop_11maxPages
integer array s__PagedButtons_Shop_12maxPages
integer array s__PagedButtons_Shop_13maxPages
integer array s__PagedButtons_Shop_maxPages
constant integer si__AFormat=8
integer si__AFormat_F=0
integer si__AFormat_I=0
integer array si__AFormat_V
integer array s__AFormat_m_position
string array s__AFormat_m_text
integer array si__PagedButtons_Type_type
integer array si__PagedButtons_Type_2type
integer array si__PagedButtons_Type_3type
integer array si__PagedButtons_Type_4type
integer array si__PagedButtons_Type_5type
integer array si__PagedButtons_Type_6type
integer array si__PagedButtons_Type_7type
integer array si__PagedButtons_Type_8type
integer array si__PagedButtons_Type_9type
integer array si__PagedButtons_Type_10type
integer array si__PagedButtons_Type_11type
integer array si__PagedButtons_Type_12type
integer array si__PagedButtons_Type_13type
trigger array st__PagedButtons_Type_onDestroy
trigger array st___prototype22
boolean f__result_boolean
trigger array st___prototype51
integer f__result_integer
unit f__arg_unit1
integer f__arg_integer1
integer f__arg_this

endglobals
native GetUnitGoldCost takes integer unitid returns integer
native GetUnitWoodCost takes integer unitid returns integer


function sg__PagedButtons_Type_get_shown takes integer i returns boolean
    if(i<8191) then
        return s__PagedButtons_Type_shown[i]
    elseif(i<57337) then
        if(i<16382) then
            return s__PagedButtons_Type_2shown[i-8191]
        elseif(i<32764) then
            if(i<24573) then
                return s__PagedButtons_Type_3shown[i-16382]
            else
                return s__PagedButtons_Type_4shown[i-24573]
            endif
        elseif(i<40955) then
            return s__PagedButtons_Type_5shown[i-32764]
        elseif(i<49146) then
            return s__PagedButtons_Type_6shown[i-40955]
        else
            return s__PagedButtons_Type_7shown[i-49146]
        endif
    elseif(i<65528) then
        return s__PagedButtons_Type_8shown[i-57337]
    elseif(i<81910) then
        if(i<73719) then
            return s__PagedButtons_Type_9shown[i-65528]
        else
            return s__PagedButtons_Type_10shown[i-73719]
        endif
    elseif(i<90101) then
        return s__PagedButtons_Type_11shown[i-81910]
    elseif(i<98292) then
        return s__PagedButtons_Type_12shown[i-90101]
    else
        return s__PagedButtons_Type_13shown[i-98292]
    endif
endfunction

function sg__PagedButtons_Type_set_shown takes integer i,boolean v returns nothing
    if(i<8191) then
        set s__PagedButtons_Type_shown[i]=v
    elseif(i<57337) then
        if(i<16382) then
            set s__PagedButtons_Type_2shown[i-8191]=v
        elseif(i<32764) then
            if(i<24573) then
                set s__PagedButtons_Type_3shown[i-16382]=v
            else
                set s__PagedButtons_Type_4shown[i-24573]=v
            endif
        elseif(i<40955) then
            set s__PagedButtons_Type_5shown[i-32764]=v
        elseif(i<49146) then
            set s__PagedButtons_Type_6shown[i-40955]=v
        else
            set s__PagedButtons_Type_7shown[i-49146]=v
        endif
    elseif(i<65528) then
        set s__PagedButtons_Type_8shown[i-57337]=v
    elseif(i<81910) then
        if(i<73719) then
            set s__PagedButtons_Type_9shown[i-65528]=v
        else
            set s__PagedButtons_Type_10shown[i-73719]=v
        endif
    elseif(i<90101) then
        set s__PagedButtons_Type_11shown[i-81910]=v
    elseif(i<98292) then
        set s__PagedButtons_Type_12shown[i-90101]=v
    else
        set s__PagedButtons_Type_13shown[i-98292]=v
    endif
endfunction

function sg__PagedButtons_Type_get_enabled takes integer i returns boolean
    if(i<8191) then
        return s__PagedButtons_Type_enabled[i]
    elseif(i<57337) then
        if(i<16382) then
            return s__PagedButtons_Type_2enabled[i-8191]
        elseif(i<32764) then
            if(i<24573) then
                return s__PagedButtons_Type_3enabled[i-16382]
            else
                return s__PagedButtons_Type_4enabled[i-24573]
            endif
        elseif(i<40955) then
            return s__PagedButtons_Type_5enabled[i-32764]
        elseif(i<49146) then
            return s__PagedButtons_Type_6enabled[i-40955]
        else
            return s__PagedButtons_Type_7enabled[i-49146]
        endif
    elseif(i<65528) then
        return s__PagedButtons_Type_8enabled[i-57337]
    elseif(i<81910) then
        if(i<73719) then
            return s__PagedButtons_Type_9enabled[i-65528]
        else
            return s__PagedButtons_Type_10enabled[i-73719]
        endif
    elseif(i<90101) then
        return s__PagedButtons_Type_11enabled[i-81910]
    elseif(i<98292) then
        return s__PagedButtons_Type_12enabled[i-90101]
    else
        return s__PagedButtons_Type_13enabled[i-98292]
    endif
endfunction

function sg__PagedButtons_Type_set_enabled takes integer i,boolean v returns nothing
    if(i<8191) then
        set s__PagedButtons_Type_enabled[i]=v
    elseif(i<57337) then
        if(i<16382) then
            set s__PagedButtons_Type_2enabled[i-8191]=v
        elseif(i<32764) then
            if(i<24573) then
                set s__PagedButtons_Type_3enabled[i-16382]=v
            else
                set s__PagedButtons_Type_4enabled[i-24573]=v
            endif
        elseif(i<40955) then
            set s__PagedButtons_Type_5enabled[i-32764]=v
        elseif(i<49146) then
            set s__PagedButtons_Type_6enabled[i-40955]=v
        else
            set s__PagedButtons_Type_7enabled[i-49146]=v
        endif
    elseif(i<65528) then
        set s__PagedButtons_Type_8enabled[i-57337]=v
    elseif(i<81910) then
        if(i<73719) then
            set s__PagedButtons_Type_9enabled[i-65528]=v
        else
            set s__PagedButtons_Type_10enabled[i-73719]=v
        endif
    elseif(i<90101) then
        set s__PagedButtons_Type_11enabled[i-81910]=v
    elseif(i<98292) then
        set s__PagedButtons_Type_12enabled[i-90101]=v
    else
        set s__PagedButtons_Type_13enabled[i-98292]=v
    endif
endfunction

function sg__PagedButtons_Type_get_whichType takes integer i returns integer
    if(i<8191) then
        return s__PagedButtons_Type_whichType[i]
    elseif(i<57337) then
        if(i<16382) then
            return s__PagedButtons_Type_2whichType[i-8191]
        elseif(i<32764) then
            if(i<24573) then
                return s__PagedButtons_Type_3whichType[i-16382]
            else
                return s__PagedButtons_Type_4whichType[i-24573]
            endif
        elseif(i<40955) then
            return s__PagedButtons_Type_5whichType[i-32764]
        elseif(i<49146) then
            return s__PagedButtons_Type_6whichType[i-40955]
        else
            return s__PagedButtons_Type_7whichType[i-49146]
        endif
    elseif(i<65528) then
        return s__PagedButtons_Type_8whichType[i-57337]
    elseif(i<81910) then
        if(i<73719) then
            return s__PagedButtons_Type_9whichType[i-65528]
        else
            return s__PagedButtons_Type_10whichType[i-73719]
        endif
    elseif(i<90101) then
        return s__PagedButtons_Type_11whichType[i-81910]
    elseif(i<98292) then
        return s__PagedButtons_Type_12whichType[i-90101]
    else
        return s__PagedButtons_Type_13whichType[i-98292]
    endif
endfunction

function sg__PagedButtons_Type_set_whichType takes integer i,integer v returns nothing
    if(i<8191) then
        set s__PagedButtons_Type_whichType[i]=v
    elseif(i<57337) then
        if(i<16382) then
            set s__PagedButtons_Type_2whichType[i-8191]=v
        elseif(i<32764) then
            if(i<24573) then
                set s__PagedButtons_Type_3whichType[i-16382]=v
            else
                set s__PagedButtons_Type_4whichType[i-24573]=v
            endif
        elseif(i<40955) then
            set s__PagedButtons_Type_5whichType[i-32764]=v
        elseif(i<49146) then
            set s__PagedButtons_Type_6whichType[i-40955]=v
        else
            set s__PagedButtons_Type_7whichType[i-49146]=v
        endif
    elseif(i<65528) then
        set s__PagedButtons_Type_8whichType[i-57337]=v
    elseif(i<81910) then
        if(i<73719) then
            set s__PagedButtons_Type_9whichType[i-65528]=v
        else
            set s__PagedButtons_Type_10whichType[i-73719]=v
        endif
    elseif(i<90101) then
        set s__PagedButtons_Type_11whichType[i-81910]=v
    elseif(i<98292) then
        set s__PagedButtons_Type_12whichType[i-90101]=v
    else
        set s__PagedButtons_Type_13whichType[i-98292]=v
    endif
endfunction

function si__PagedButtons_Type_getType takes integer this returns integer
    if(this<8191) then
        return si__PagedButtons_Type_type[this]
    elseif(this<57337) then
        if(this<16382) then
            return si__PagedButtons_Type_2type[this-8191]
        elseif(this<32764) then
            if(this<24573) then
                return si__PagedButtons_Type_3type[this-16382]
            else
                return si__PagedButtons_Type_4type[this-24573]
            endif
        elseif(this<40955) then
            return si__PagedButtons_Type_5type[this-32764]
        elseif(this<49146) then
            return si__PagedButtons_Type_6type[this-40955]
        else
            return si__PagedButtons_Type_7type[this-49146]
        endif
    elseif(this<65528) then
        return si__PagedButtons_Type_8type[this-57337]
    elseif(this<81910) then
        if(this<73719) then
            return si__PagedButtons_Type_9type[this-65528]
        else
            return si__PagedButtons_Type_10type[this-73719]
        endif
    elseif(this<90101) then
        return si__PagedButtons_Type_11type[this-81910]
    elseif(this<98292) then
        return si__PagedButtons_Type_12type[this-90101]
    else
        return si__PagedButtons_Type_13type[this-98292]
    endif
endfunction

function sg___PagedButtons_Shop_pages_get takes integer i returns integer
    if(i<8191) then
        return s___PagedButtons_Shop_pages[i]
    elseif(i<57337) then
        if(i<16382) then
            return s__2_PagedButtons_Shop_pages[i-8191]
        elseif(i<32764) then
            if(i<24573) then
                return s__3_PagedButtons_Shop_pages[i-16382]
            else
                return s__4_PagedButtons_Shop_pages[i-24573]
            endif
        elseif(i<40955) then
            return s__5_PagedButtons_Shop_pages[i-32764]
        elseif(i<49146) then
            return s__6_PagedButtons_Shop_pages[i-40955]
        else
            return s__7_PagedButtons_Shop_pages[i-49146]
        endif
    elseif(i<65528) then
        return s__8_PagedButtons_Shop_pages[i-57337]
    elseif(i<81910) then
        if(i<73719) then
            return s__9_PagedButtons_Shop_pages[i-65528]
        else
            return s__10_PagedButtons_Shop_pages[i-73719]
        endif
    elseif(i<90101) then
        return s__11_PagedButtons_Shop_pages[i-81910]
    elseif(i<98292) then
        return s__12_PagedButtons_Shop_pages[i-90101]
    else
        return s__13_PagedButtons_Shop_pages[i-98292]
    endif
endfunction

function sg___PagedButtons_Shop_pages_set takes integer i,integer v returns nothing
    if(i<8191) then
        set s___PagedButtons_Shop_pages[i]=v
    elseif(i<57337) then
        if(i<16382) then
            set s__2_PagedButtons_Shop_pages[i-8191]=v
        elseif(i<32764) then
            if(i<24573) then
                set s__3_PagedButtons_Shop_pages[i-16382]=v
            else
                set s__4_PagedButtons_Shop_pages[i-24573]=v
            endif
        elseif(i<40955) then
            set s__5_PagedButtons_Shop_pages[i-32764]=v
        elseif(i<49146) then
            set s__6_PagedButtons_Shop_pages[i-40955]=v
        else
            set s__7_PagedButtons_Shop_pages[i-49146]=v
        endif
    elseif(i<65528) then
        set s__8_PagedButtons_Shop_pages[i-57337]=v
    elseif(i<81910) then
        if(i<73719) then
            set s__9_PagedButtons_Shop_pages[i-65528]=v
        else
            set s__10_PagedButtons_Shop_pages[i-73719]=v
        endif
    elseif(i<90101) then
        set s__11_PagedButtons_Shop_pages[i-81910]=v
    elseif(i<98292) then
        set s__12_PagedButtons_Shop_pages[i-90101]=v
    else
        set s__13_PagedButtons_Shop_pages[i-98292]=v
    endif
endfunction

function sg___PagedButtons_Shop_buttons_get takes integer i returns integer
    if(i<8191) then
        return s___PagedButtons_Shop_buttons[i]
    elseif(i<57337) then
        if(i<16382) then
            return s__2_PagedButtons_Shop_buttons[i-8191]
        elseif(i<32764) then
            if(i<24573) then
                return s__3_PagedButtons_Shop_buttons[i-16382]
            else
                return s__4_PagedButtons_Shop_buttons[i-24573]
            endif
        elseif(i<40955) then
            return s__5_PagedButtons_Shop_buttons[i-32764]
        elseif(i<49146) then
            return s__6_PagedButtons_Shop_buttons[i-40955]
        else
            return s__7_PagedButtons_Shop_buttons[i-49146]
        endif
    elseif(i<65528) then
        return s__8_PagedButtons_Shop_buttons[i-57337]
    elseif(i<81910) then
        if(i<73719) then
            return s__9_PagedButtons_Shop_buttons[i-65528]
        else
            return s__10_PagedButtons_Shop_buttons[i-73719]
        endif
    elseif(i<90101) then
        return s__11_PagedButtons_Shop_buttons[i-81910]
    elseif(i<98292) then
        return s__12_PagedButtons_Shop_buttons[i-90101]
    else
        return s__13_PagedButtons_Shop_buttons[i-98292]
    endif
endfunction

function sg___PagedButtons_Shop_buttons_set takes integer i,integer v returns nothing
    if(i<8191) then
        set s___PagedButtons_Shop_buttons[i]=v
    elseif(i<57337) then
        if(i<16382) then
            set s__2_PagedButtons_Shop_buttons[i-8191]=v
        elseif(i<32764) then
            if(i<24573) then
                set s__3_PagedButtons_Shop_buttons[i-16382]=v
            else
                set s__4_PagedButtons_Shop_buttons[i-24573]=v
            endif
        elseif(i<40955) then
            set s__5_PagedButtons_Shop_buttons[i-32764]=v
        elseif(i<49146) then
            set s__6_PagedButtons_Shop_buttons[i-40955]=v
        else
            set s__7_PagedButtons_Shop_buttons[i-49146]=v
        endif
    elseif(i<65528) then
        set s__8_PagedButtons_Shop_buttons[i-57337]=v
    elseif(i<81910) then
        if(i<73719) then
            set s__9_PagedButtons_Shop_buttons[i-65528]=v
        else
            set s__10_PagedButtons_Shop_buttons[i-73719]=v
        endif
    elseif(i<90101) then
        set s__11_PagedButtons_Shop_buttons[i-81910]=v
    elseif(i<98292) then
        set s__12_PagedButtons_Shop_buttons[i-90101]=v
    else
        set s__13_PagedButtons_Shop_buttons[i-98292]=v
    endif
endfunction

function sg__PagedButtons_Shop_get_slotsPerPage takes integer i returns integer
    if(i<8191) then
        return s__PagedButtons_Shop_slotsPerPage[i]
    elseif(i<57337) then
        if(i<16382) then
            return s__PagedButtons_Shop_2slotsPerPage[i-8191]
        elseif(i<32764) then
            if(i<24573) then
                return s__PagedButtons_Shop_3slotsPerPage[i-16382]
            else
                return s__PagedButtons_Shop_4slotsPerPage[i-24573]
            endif
        elseif(i<40955) then
            return s__PagedButtons_Shop_5slotsPerPage[i-32764]
        elseif(i<49146) then
            return s__PagedButtons_Shop_6slotsPerPage[i-40955]
        else
            return s__PagedButtons_Shop_7slotsPerPage[i-49146]
        endif
    elseif(i<65528) then
        return s__PagedButtons_Shop_8slotsPerPage[i-57337]
    elseif(i<81910) then
        if(i<73719) then
            return s__PagedButtons_Shop_9slotsPerPage[i-65528]
        else
            return s__PagedButtons_Shop_10slotsPerPage[i-73719]
        endif
    elseif(i<90101) then
        return s__PagedButtons_Shop_11slotsPerPage[i-81910]
    elseif(i<98292) then
        return s__PagedButtons_Shop_12slotsPerPage[i-90101]
    else
        return s__PagedButtons_Shop_13slotsPerPage[i-98292]
    endif
endfunction

function sg__PagedButtons_Shop_set_slotsPerPage takes integer i,integer v returns nothing
    if(i<8191) then
        set s__PagedButtons_Shop_slotsPerPage[i]=v
    elseif(i<57337) then
        if(i<16382) then
            set s__PagedButtons_Shop_2slotsPerPage[i-8191]=v
        elseif(i<32764) then
            if(i<24573) then
                set s__PagedButtons_Shop_3slotsPerPage[i-16382]=v
            else
                set s__PagedButtons_Shop_4slotsPerPage[i-24573]=v
            endif
        elseif(i<40955) then
            set s__PagedButtons_Shop_5slotsPerPage[i-32764]=v
        elseif(i<49146) then
            set s__PagedButtons_Shop_6slotsPerPage[i-40955]=v
        else
            set s__PagedButtons_Shop_7slotsPerPage[i-49146]=v
        endif
    elseif(i<65528) then
        set s__PagedButtons_Shop_8slotsPerPage[i-57337]=v
    elseif(i<81910) then
        if(i<73719) then
            set s__PagedButtons_Shop_9slotsPerPage[i-65528]=v
        else
            set s__PagedButtons_Shop_10slotsPerPage[i-73719]=v
        endif
    elseif(i<90101) then
        set s__PagedButtons_Shop_11slotsPerPage[i-81910]=v
    elseif(i<98292) then
        set s__PagedButtons_Shop_12slotsPerPage[i-90101]=v
    else
        set s__PagedButtons_Shop_13slotsPerPage[i-98292]=v
    endif
endfunction

function sg__PagedButtons_Shop_get_currentPage takes integer i returns integer
    if(i<8191) then
        return s__PagedButtons_Shop_currentPage[i]
    elseif(i<57337) then
        if(i<16382) then
            return s__PagedButtons_Shop_2currentPage[i-8191]
        elseif(i<32764) then
            if(i<24573) then
                return s__PagedButtons_Shop_3currentPage[i-16382]
            else
                return s__PagedButtons_Shop_4currentPage[i-24573]
            endif
        elseif(i<40955) then
            return s__PagedButtons_Shop_5currentPage[i-32764]
        elseif(i<49146) then
            return s__PagedButtons_Shop_6currentPage[i-40955]
        else
            return s__PagedButtons_Shop_7currentPage[i-49146]
        endif
    elseif(i<65528) then
        return s__PagedButtons_Shop_8currentPage[i-57337]
    elseif(i<81910) then
        if(i<73719) then
            return s__PagedButtons_Shop_9currentPage[i-65528]
        else
            return s__PagedButtons_Shop_10currentPage[i-73719]
        endif
    elseif(i<90101) then
        return s__PagedButtons_Shop_11currentPage[i-81910]
    elseif(i<98292) then
        return s__PagedButtons_Shop_12currentPage[i-90101]
    else
        return s__PagedButtons_Shop_13currentPage[i-98292]
    endif
endfunction

function sg__PagedButtons_Shop_set_currentPage takes integer i,integer v returns nothing
    if(i<8191) then
        set s__PagedButtons_Shop_currentPage[i]=v
    elseif(i<57337) then
        if(i<16382) then
            set s__PagedButtons_Shop_2currentPage[i-8191]=v
        elseif(i<32764) then
            if(i<24573) then
                set s__PagedButtons_Shop_3currentPage[i-16382]=v
            else
                set s__PagedButtons_Shop_4currentPage[i-24573]=v
            endif
        elseif(i<40955) then
            set s__PagedButtons_Shop_5currentPage[i-32764]=v
        elseif(i<49146) then
            set s__PagedButtons_Shop_6currentPage[i-40955]=v
        else
            set s__PagedButtons_Shop_7currentPage[i-49146]=v
        endif
    elseif(i<65528) then
        set s__PagedButtons_Shop_8currentPage[i-57337]=v
    elseif(i<81910) then
        if(i<73719) then
            set s__PagedButtons_Shop_9currentPage[i-65528]=v
        else
            set s__PagedButtons_Shop_10currentPage[i-73719]=v
        endif
    elseif(i<90101) then
        set s__PagedButtons_Shop_11currentPage[i-81910]=v
    elseif(i<98292) then
        set s__PagedButtons_Shop_12currentPage[i-90101]=v
    else
        set s__PagedButtons_Shop_13currentPage[i-98292]=v
    endif
endfunction

function sg__PagedButtons_Shop_get_name takes integer i returns string
    if(i<8191) then
        return s__PagedButtons_Shop_name[i]
    elseif(i<57337) then
        if(i<16382) then
            return s__PagedButtons_Shop_2name[i-8191]
        elseif(i<32764) then
            if(i<24573) then
                return s__PagedButtons_Shop_3name[i-16382]
            else
                return s__PagedButtons_Shop_4name[i-24573]
            endif
        elseif(i<40955) then
            return s__PagedButtons_Shop_5name[i-32764]
        elseif(i<49146) then
            return s__PagedButtons_Shop_6name[i-40955]
        else
            return s__PagedButtons_Shop_7name[i-49146]
        endif
    elseif(i<65528) then
        return s__PagedButtons_Shop_8name[i-57337]
    elseif(i<81910) then
        if(i<73719) then
            return s__PagedButtons_Shop_9name[i-65528]
        else
            return s__PagedButtons_Shop_10name[i-73719]
        endif
    elseif(i<90101) then
        return s__PagedButtons_Shop_11name[i-81910]
    elseif(i<98292) then
        return s__PagedButtons_Shop_12name[i-90101]
    else
        return s__PagedButtons_Shop_13name[i-98292]
    endif
endfunction

function sg__PagedButtons_Shop_set_name takes integer i,string v returns nothing
    if(i<8191) then
        set s__PagedButtons_Shop_name[i]=v
    elseif(i<57337) then
        if(i<16382) then
            set s__PagedButtons_Shop_2name[i-8191]=v
        elseif(i<32764) then
            if(i<24573) then
                set s__PagedButtons_Shop_3name[i-16382]=v
            else
                set s__PagedButtons_Shop_4name[i-24573]=v
            endif
        elseif(i<40955) then
            set s__PagedButtons_Shop_5name[i-32764]=v
        elseif(i<49146) then
            set s__PagedButtons_Shop_6name[i-40955]=v
        else
            set s__PagedButtons_Shop_7name[i-49146]=v
        endif
    elseif(i<65528) then
        set s__PagedButtons_Shop_8name[i-57337]=v
    elseif(i<81910) then
        if(i<73719) then
            set s__PagedButtons_Shop_9name[i-65528]=v
        else
            set s__PagedButtons_Shop_10name[i-73719]=v
        endif
    elseif(i<90101) then
        set s__PagedButtons_Shop_11name[i-81910]=v
    elseif(i<98292) then
        set s__PagedButtons_Shop_12name[i-90101]=v
    else
        set s__PagedButtons_Shop_13name[i-98292]=v
    endif
endfunction

function sg__PagedButtons_Shop_get_whichType takes integer i returns integer
    if(i<8191) then
        return s__PagedButtons_Shop_whichType[i]
    elseif(i<57337) then
        if(i<16382) then
            return s__PagedButtons_Shop_2whichType[i-8191]
        elseif(i<32764) then
            if(i<24573) then
                return s__PagedButtons_Shop_3whichType[i-16382]
            else
                return s__PagedButtons_Shop_4whichType[i-24573]
            endif
        elseif(i<40955) then
            return s__PagedButtons_Shop_5whichType[i-32764]
        elseif(i<49146) then
            return s__PagedButtons_Shop_6whichType[i-40955]
        else
            return s__PagedButtons_Shop_7whichType[i-49146]
        endif
    elseif(i<65528) then
        return s__PagedButtons_Shop_8whichType[i-57337]
    elseif(i<81910) then
        if(i<73719) then
            return s__PagedButtons_Shop_9whichType[i-65528]
        else
            return s__PagedButtons_Shop_10whichType[i-73719]
        endif
    elseif(i<90101) then
        return s__PagedButtons_Shop_11whichType[i-81910]
    elseif(i<98292) then
        return s__PagedButtons_Shop_12whichType[i-90101]
    else
        return s__PagedButtons_Shop_13whichType[i-98292]
    endif
endfunction

function sg__PagedButtons_Shop_set_whichType takes integer i,integer v returns nothing
    if(i<8191) then
        set s__PagedButtons_Shop_whichType[i]=v
    elseif(i<57337) then
        if(i<16382) then
            set s__PagedButtons_Shop_2whichType[i-8191]=v
        elseif(i<32764) then
            if(i<24573) then
                set s__PagedButtons_Shop_3whichType[i-16382]=v
            else
                set s__PagedButtons_Shop_4whichType[i-24573]=v
            endif
        elseif(i<40955) then
            set s__PagedButtons_Shop_5whichType[i-32764]=v
        elseif(i<49146) then
            set s__PagedButtons_Shop_6whichType[i-40955]=v
        else
            set s__PagedButtons_Shop_7whichType[i-49146]=v
        endif
    elseif(i<65528) then
        set s__PagedButtons_Shop_8whichType[i-57337]=v
    elseif(i<81910) then
        if(i<73719) then
            set s__PagedButtons_Shop_9whichType[i-65528]=v
        else
            set s__PagedButtons_Shop_10whichType[i-73719]=v
        endif
    elseif(i<90101) then
        set s__PagedButtons_Shop_11whichType[i-81910]=v
    elseif(i<98292) then
        set s__PagedButtons_Shop_12whichType[i-90101]=v
    else
        set s__PagedButtons_Shop_13whichType[i-98292]=v
    endif
endfunction

function sg__PagedButtons_Shop_get_buttons takes integer i returns integer
    if(i<8191) then
        return s__PagedButtons_Shop_buttons[i]
    elseif(i<57337) then
        if(i<16382) then
            return s__PagedButtons_Shop_2buttons[i-8191]
        elseif(i<32764) then
            if(i<24573) then
                return s__PagedButtons_Shop_3buttons[i-16382]
            else
                return s__PagedButtons_Shop_4buttons[i-24573]
            endif
        elseif(i<40955) then
            return s__PagedButtons_Shop_5buttons[i-32764]
        elseif(i<49146) then
            return s__PagedButtons_Shop_6buttons[i-40955]
        else
            return s__PagedButtons_Shop_7buttons[i-49146]
        endif
    elseif(i<65528) then
        return s__PagedButtons_Shop_8buttons[i-57337]
    elseif(i<81910) then
        if(i<73719) then
            return s__PagedButtons_Shop_9buttons[i-65528]
        else
            return s__PagedButtons_Shop_10buttons[i-73719]
        endif
    elseif(i<90101) then
        return s__PagedButtons_Shop_11buttons[i-81910]
    elseif(i<98292) then
        return s__PagedButtons_Shop_12buttons[i-90101]
    else
        return s__PagedButtons_Shop_13buttons[i-98292]
    endif
endfunction

function sg__PagedButtons_Shop_set_buttons takes integer i,integer v returns nothing
    if(i<8191) then
        set s__PagedButtons_Shop_buttons[i]=v
    elseif(i<57337) then
        if(i<16382) then
            set s__PagedButtons_Shop_2buttons[i-8191]=v
        elseif(i<32764) then
            if(i<24573) then
                set s__PagedButtons_Shop_3buttons[i-16382]=v
            else
                set s__PagedButtons_Shop_4buttons[i-24573]=v
            endif
        elseif(i<40955) then
            set s__PagedButtons_Shop_5buttons[i-32764]=v
        elseif(i<49146) then
            set s__PagedButtons_Shop_6buttons[i-40955]=v
        else
            set s__PagedButtons_Shop_7buttons[i-49146]=v
        endif
    elseif(i<65528) then
        set s__PagedButtons_Shop_8buttons[i-57337]=v
    elseif(i<81910) then
        if(i<73719) then
            set s__PagedButtons_Shop_9buttons[i-65528]=v
        else
            set s__PagedButtons_Shop_10buttons[i-73719]=v
        endif
    elseif(i<90101) then
        set s__PagedButtons_Shop_11buttons[i-81910]=v
    elseif(i<98292) then
        set s__PagedButtons_Shop_12buttons[i-90101]=v
    else
        set s__PagedButtons_Shop_13buttons[i-98292]=v
    endif
endfunction

function sg__PagedButtons_Shop_get_buttonsCount takes integer i returns integer
    if(i<8191) then
        return s__PagedButtons_Shop_buttonsCount[i]
    elseif(i<57337) then
        if(i<16382) then
            return s__PagedButtons_Shop_2buttonsCount[i-8191]
        elseif(i<32764) then
            if(i<24573) then
                return s__PagedButtons_Shop_3buttonsCount[i-16382]
            else
                return s__PagedButtons_Shop_4buttonsCount[i-24573]
            endif
        elseif(i<40955) then
            return s__PagedButtons_Shop_5buttonsCount[i-32764]
        elseif(i<49146) then
            return s__PagedButtons_Shop_6buttonsCount[i-40955]
        else
            return s__PagedButtons_Shop_7buttonsCount[i-49146]
        endif
    elseif(i<65528) then
        return s__PagedButtons_Shop_8buttonsCount[i-57337]
    elseif(i<81910) then
        if(i<73719) then
            return s__PagedButtons_Shop_9buttonsCount[i-65528]
        else
            return s__PagedButtons_Shop_10buttonsCount[i-73719]
        endif
    elseif(i<90101) then
        return s__PagedButtons_Shop_11buttonsCount[i-81910]
    elseif(i<98292) then
        return s__PagedButtons_Shop_12buttonsCount[i-90101]
    else
        return s__PagedButtons_Shop_13buttonsCount[i-98292]
    endif
endfunction

function sg__PagedButtons_Shop_set_buttonsCount takes integer i,integer v returns nothing
    if(i<8191) then
        set s__PagedButtons_Shop_buttonsCount[i]=v
    elseif(i<57337) then
        if(i<16382) then
            set s__PagedButtons_Shop_2buttonsCount[i-8191]=v
        elseif(i<32764) then
            if(i<24573) then
                set s__PagedButtons_Shop_3buttonsCount[i-16382]=v
            else
                set s__PagedButtons_Shop_4buttonsCount[i-24573]=v
            endif
        elseif(i<40955) then
            set s__PagedButtons_Shop_5buttonsCount[i-32764]=v
        elseif(i<49146) then
            set s__PagedButtons_Shop_6buttonsCount[i-40955]=v
        else
            set s__PagedButtons_Shop_7buttonsCount[i-49146]=v
        endif
    elseif(i<65528) then
        set s__PagedButtons_Shop_8buttonsCount[i-57337]=v
    elseif(i<81910) then
        if(i<73719) then
            set s__PagedButtons_Shop_9buttonsCount[i-65528]=v
        else
            set s__PagedButtons_Shop_10buttonsCount[i-73719]=v
        endif
    elseif(i<90101) then
        set s__PagedButtons_Shop_11buttonsCount[i-81910]=v
    elseif(i<98292) then
        set s__PagedButtons_Shop_12buttonsCount[i-90101]=v
    else
        set s__PagedButtons_Shop_13buttonsCount[i-98292]=v
    endif
endfunction

function sg__PagedButtons_Shop_get_pages takes integer i returns integer
    if(i<8191) then
        return s__PagedButtons_Shop_pages[i]
    elseif(i<57337) then
        if(i<16382) then
            return s__PagedButtons_Shop_2pages[i-8191]
        elseif(i<32764) then
            if(i<24573) then
                return s__PagedButtons_Shop_3pages[i-16382]
            else
                return s__PagedButtons_Shop_4pages[i-24573]
            endif
        elseif(i<40955) then
            return s__PagedButtons_Shop_5pages[i-32764]
        elseif(i<49146) then
            return s__PagedButtons_Shop_6pages[i-40955]
        else
            return s__PagedButtons_Shop_7pages[i-49146]
        endif
    elseif(i<65528) then
        return s__PagedButtons_Shop_8pages[i-57337]
    elseif(i<81910) then
        if(i<73719) then
            return s__PagedButtons_Shop_9pages[i-65528]
        else
            return s__PagedButtons_Shop_10pages[i-73719]
        endif
    elseif(i<90101) then
        return s__PagedButtons_Shop_11pages[i-81910]
    elseif(i<98292) then
        return s__PagedButtons_Shop_12pages[i-90101]
    else
        return s__PagedButtons_Shop_13pages[i-98292]
    endif
endfunction

function sg__PagedButtons_Shop_set_pages takes integer i,integer v returns nothing
    if(i<8191) then
        set s__PagedButtons_Shop_pages[i]=v
    elseif(i<57337) then
        if(i<16382) then
            set s__PagedButtons_Shop_2pages[i-8191]=v
        elseif(i<32764) then
            if(i<24573) then
                set s__PagedButtons_Shop_3pages[i-16382]=v
            else
                set s__PagedButtons_Shop_4pages[i-24573]=v
            endif
        elseif(i<40955) then
            set s__PagedButtons_Shop_5pages[i-32764]=v
        elseif(i<49146) then
            set s__PagedButtons_Shop_6pages[i-40955]=v
        else
            set s__PagedButtons_Shop_7pages[i-49146]=v
        endif
    elseif(i<65528) then
        set s__PagedButtons_Shop_8pages[i-57337]=v
    elseif(i<81910) then
        if(i<73719) then
            set s__PagedButtons_Shop_9pages[i-65528]=v
        else
            set s__PagedButtons_Shop_10pages[i-73719]=v
        endif
    elseif(i<90101) then
        set s__PagedButtons_Shop_11pages[i-81910]=v
    elseif(i<98292) then
        set s__PagedButtons_Shop_12pages[i-90101]=v
    else
        set s__PagedButtons_Shop_13pages[i-98292]=v
    endif
endfunction

function sg__PagedButtons_Shop_get_maxPages takes integer i returns integer
    if(i<8191) then
        return s__PagedButtons_Shop_maxPages[i]
    elseif(i<57337) then
        if(i<16382) then
            return s__PagedButtons_Shop_2maxPages[i-8191]
        elseif(i<32764) then
            if(i<24573) then
                return s__PagedButtons_Shop_3maxPages[i-16382]
            else
                return s__PagedButtons_Shop_4maxPages[i-24573]
            endif
        elseif(i<40955) then
            return s__PagedButtons_Shop_5maxPages[i-32764]
        elseif(i<49146) then
            return s__PagedButtons_Shop_6maxPages[i-40955]
        else
            return s__PagedButtons_Shop_7maxPages[i-49146]
        endif
    elseif(i<65528) then
        return s__PagedButtons_Shop_8maxPages[i-57337]
    elseif(i<81910) then
        if(i<73719) then
            return s__PagedButtons_Shop_9maxPages[i-65528]
        else
            return s__PagedButtons_Shop_10maxPages[i-73719]
        endif
    elseif(i<90101) then
        return s__PagedButtons_Shop_11maxPages[i-81910]
    elseif(i<98292) then
        return s__PagedButtons_Shop_12maxPages[i-90101]
    else
        return s__PagedButtons_Shop_13maxPages[i-98292]
    endif
endfunction

function sg__PagedButtons_Shop_set_maxPages takes integer i,integer v returns nothing
    if(i<8191) then
        set s__PagedButtons_Shop_maxPages[i]=v
    elseif(i<57337) then
        if(i<16382) then
            set s__PagedButtons_Shop_2maxPages[i-8191]=v
        elseif(i<32764) then
            if(i<24573) then
                set s__PagedButtons_Shop_3maxPages[i-16382]=v
            else
                set s__PagedButtons_Shop_4maxPages[i-24573]=v
            endif
        elseif(i<40955) then
            set s__PagedButtons_Shop_5maxPages[i-32764]=v
        elseif(i<49146) then
            set s__PagedButtons_Shop_6maxPages[i-40955]=v
        else
            set s__PagedButtons_Shop_7maxPages[i-49146]=v
        endif
    elseif(i<65528) then
        set s__PagedButtons_Shop_8maxPages[i-57337]=v
    elseif(i<81910) then
        if(i<73719) then
            set s__PagedButtons_Shop_9maxPages[i-65528]=v
        else
            set s__PagedButtons_Shop_10maxPages[i-73719]=v
        endif
    elseif(i<90101) then
        set s__PagedButtons_Shop_11maxPages[i-81910]=v
    elseif(i<98292) then
        set s__PagedButtons_Shop_12maxPages[i-90101]=v
    else
        set s__PagedButtons_Shop_13maxPages[i-98292]=v
    endif
endfunction

function sg__PagedButtons_Page_get_name takes integer i returns string
    if(i<8191) then
        return s__PagedButtons_Page_name[i]
    elseif(i<57337) then
        if(i<16382) then
            return s__PagedButtons_Page_2name[i-8191]
        elseif(i<32764) then
            if(i<24573) then
                return s__PagedButtons_Page_3name[i-16382]
            else
                return s__PagedButtons_Page_4name[i-24573]
            endif
        elseif(i<40955) then
            return s__PagedButtons_Page_5name[i-32764]
        elseif(i<49146) then
            return s__PagedButtons_Page_6name[i-40955]
        else
            return s__PagedButtons_Page_7name[i-49146]
        endif
    elseif(i<65528) then
        return s__PagedButtons_Page_8name[i-57337]
    elseif(i<81910) then
        if(i<73719) then
            return s__PagedButtons_Page_9name[i-65528]
        else
            return s__PagedButtons_Page_10name[i-73719]
        endif
    elseif(i<90101) then
        return s__PagedButtons_Page_11name[i-81910]
    elseif(i<98292) then
        return s__PagedButtons_Page_12name[i-90101]
    else
        return s__PagedButtons_Page_13name[i-98292]
    endif
endfunction

function sg__PagedButtons_Page_set_name takes integer i,string v returns nothing
    if(i<8191) then
        set s__PagedButtons_Page_name[i]=v
    elseif(i<57337) then
        if(i<16382) then
            set s__PagedButtons_Page_2name[i-8191]=v
        elseif(i<32764) then
            if(i<24573) then
                set s__PagedButtons_Page_3name[i-16382]=v
            else
                set s__PagedButtons_Page_4name[i-24573]=v
            endif
        elseif(i<40955) then
            set s__PagedButtons_Page_5name[i-32764]=v
        elseif(i<49146) then
            set s__PagedButtons_Page_6name[i-40955]=v
        else
            set s__PagedButtons_Page_7name[i-49146]=v
        endif
    elseif(i<65528) then
        set s__PagedButtons_Page_8name[i-57337]=v
    elseif(i<81910) then
        if(i<73719) then
            set s__PagedButtons_Page_9name[i-65528]=v
        else
            set s__PagedButtons_Page_10name[i-73719]=v
        endif
    elseif(i<90101) then
        set s__PagedButtons_Page_11name[i-81910]=v
    elseif(i<98292) then
        set s__PagedButtons_Page_12name[i-90101]=v
    else
        set s__PagedButtons_Page_13name[i-98292]=v
    endif
endfunction

function sg__PagedButtons_SlotType_get_shop takes integer i returns unit
    if(i<8191) then
        return s__PagedButtons_SlotType_shop[i]
    elseif(i<57337) then
        if(i<16382) then
            return s__PagedButtons_SlotType_2shop[i-8191]
        elseif(i<32764) then
            if(i<24573) then
                return s__PagedButtons_SlotType_3shop[i-16382]
            else
                return s__PagedButtons_SlotType_4shop[i-24573]
            endif
        elseif(i<40955) then
            return s__PagedButtons_SlotType_5shop[i-32764]
        elseif(i<49146) then
            return s__PagedButtons_SlotType_6shop[i-40955]
        else
            return s__PagedButtons_SlotType_7shop[i-49146]
        endif
    elseif(i<65528) then
        return s__PagedButtons_SlotType_8shop[i-57337]
    elseif(i<81910) then
        if(i<73719) then
            return s__PagedButtons_SlotType_9shop[i-65528]
        else
            return s__PagedButtons_SlotType_10shop[i-73719]
        endif
    elseif(i<90101) then
        return s__PagedButtons_SlotType_11shop[i-81910]
    elseif(i<98292) then
        return s__PagedButtons_SlotType_12shop[i-90101]
    else
        return s__PagedButtons_SlotType_13shop[i-98292]
    endif
endfunction

function sg__PagedButtons_SlotType_set_shop takes integer i,unit v returns nothing
    if(i<8191) then
        set s__PagedButtons_SlotType_shop[i]=v
    elseif(i<57337) then
        if(i<16382) then
            set s__PagedButtons_SlotType_2shop[i-8191]=v
        elseif(i<32764) then
            if(i<24573) then
                set s__PagedButtons_SlotType_3shop[i-16382]=v
            else
                set s__PagedButtons_SlotType_4shop[i-24573]=v
            endif
        elseif(i<40955) then
            set s__PagedButtons_SlotType_5shop[i-32764]=v
        elseif(i<49146) then
            set s__PagedButtons_SlotType_6shop[i-40955]=v
        else
            set s__PagedButtons_SlotType_7shop[i-49146]=v
        endif
    elseif(i<65528) then
        set s__PagedButtons_SlotType_8shop[i-57337]=v
    elseif(i<81910) then
        if(i<73719) then
            set s__PagedButtons_SlotType_9shop[i-65528]=v
        else
            set s__PagedButtons_SlotType_10shop[i-73719]=v
        endif
    elseif(i<90101) then
        set s__PagedButtons_SlotType_11shop[i-81910]=v
    elseif(i<98292) then
        set s__PagedButtons_SlotType_12shop[i-90101]=v
    else
        set s__PagedButtons_SlotType_13shop[i-98292]=v
    endif
endfunction

function sg__PagedButtons_SlotType_get_id takes integer i returns integer
    if(i<8191) then
        return s__PagedButtons_SlotType_id[i]
    elseif(i<57337) then
        if(i<16382) then
            return s__PagedButtons_SlotType_2id[i-8191]
        elseif(i<32764) then
            if(i<24573) then
                return s__PagedButtons_SlotType_3id[i-16382]
            else
                return s__PagedButtons_SlotType_4id[i-24573]
            endif
        elseif(i<40955) then
            return s__PagedButtons_SlotType_5id[i-32764]
        elseif(i<49146) then
            return s__PagedButtons_SlotType_6id[i-40955]
        else
            return s__PagedButtons_SlotType_7id[i-49146]
        endif
    elseif(i<65528) then
        return s__PagedButtons_SlotType_8id[i-57337]
    elseif(i<81910) then
        if(i<73719) then
            return s__PagedButtons_SlotType_9id[i-65528]
        else
            return s__PagedButtons_SlotType_10id[i-73719]
        endif
    elseif(i<90101) then
        return s__PagedButtons_SlotType_11id[i-81910]
    elseif(i<98292) then
        return s__PagedButtons_SlotType_12id[i-90101]
    else
        return s__PagedButtons_SlotType_13id[i-98292]
    endif
endfunction

function sg__PagedButtons_SlotType_set_id takes integer i,integer v returns nothing
    if(i<8191) then
        set s__PagedButtons_SlotType_id[i]=v
    elseif(i<57337) then
        if(i<16382) then
            set s__PagedButtons_SlotType_2id[i-8191]=v
        elseif(i<32764) then
            if(i<24573) then
                set s__PagedButtons_SlotType_3id[i-16382]=v
            else
                set s__PagedButtons_SlotType_4id[i-24573]=v
            endif
        elseif(i<40955) then
            set s__PagedButtons_SlotType_5id[i-32764]=v
        elseif(i<49146) then
            set s__PagedButtons_SlotType_6id[i-40955]=v
        else
            set s__PagedButtons_SlotType_7id[i-49146]=v
        endif
    elseif(i<65528) then
        set s__PagedButtons_SlotType_8id[i-57337]=v
    elseif(i<81910) then
        if(i<73719) then
            set s__PagedButtons_SlotType_9id[i-65528]=v
        else
            set s__PagedButtons_SlotType_10id[i-73719]=v
        endif
    elseif(i<90101) then
        set s__PagedButtons_SlotType_11id[i-81910]=v
    elseif(i<98292) then
        set s__PagedButtons_SlotType_12id[i-90101]=v
    else
        set s__PagedButtons_SlotType_13id[i-98292]=v
    endif
endfunction

function sg__PagedButtons_SlotType_get_startStock takes integer i returns integer
    if(i<8191) then
        return s__PagedButtons_SlotType_startStock[i]
    elseif(i<57337) then
        if(i<16382) then
            return s__PagedButtons_SlotType_2startStock[i-8191]
        elseif(i<32764) then
            if(i<24573) then
                return s__PagedButtons_SlotType_3startStock[i-16382]
            else
                return s__PagedButtons_SlotType_4startStock[i-24573]
            endif
        elseif(i<40955) then
            return s__PagedButtons_SlotType_5startStock[i-32764]
        elseif(i<49146) then
            return s__PagedButtons_SlotType_6startStock[i-40955]
        else
            return s__PagedButtons_SlotType_7startStock[i-49146]
        endif
    elseif(i<65528) then
        return s__PagedButtons_SlotType_8startStock[i-57337]
    elseif(i<81910) then
        if(i<73719) then
            return s__PagedButtons_SlotType_9startStock[i-65528]
        else
            return s__PagedButtons_SlotType_10startStock[i-73719]
        endif
    elseif(i<90101) then
        return s__PagedButtons_SlotType_11startStock[i-81910]
    elseif(i<98292) then
        return s__PagedButtons_SlotType_12startStock[i-90101]
    else
        return s__PagedButtons_SlotType_13startStock[i-98292]
    endif
endfunction

function sg__PagedButtons_SlotType_set_startStock takes integer i,integer v returns nothing
    if(i<8191) then
        set s__PagedButtons_SlotType_startStock[i]=v
    elseif(i<57337) then
        if(i<16382) then
            set s__PagedButtons_SlotType_2startStock[i-8191]=v
        elseif(i<32764) then
            if(i<24573) then
                set s__PagedButtons_SlotType_3startStock[i-16382]=v
            else
                set s__PagedButtons_SlotType_4startStock[i-24573]=v
            endif
        elseif(i<40955) then
            set s__PagedButtons_SlotType_5startStock[i-32764]=v
        elseif(i<49146) then
            set s__PagedButtons_SlotType_6startStock[i-40955]=v
        else
            set s__PagedButtons_SlotType_7startStock[i-49146]=v
        endif
    elseif(i<65528) then
        set s__PagedButtons_SlotType_8startStock[i-57337]=v
    elseif(i<81910) then
        if(i<73719) then
            set s__PagedButtons_SlotType_9startStock[i-65528]=v
        else
            set s__PagedButtons_SlotType_10startStock[i-73719]=v
        endif
    elseif(i<90101) then
        set s__PagedButtons_SlotType_11startStock[i-81910]=v
    elseif(i<98292) then
        set s__PagedButtons_SlotType_12startStock[i-90101]=v
    else
        set s__PagedButtons_SlotType_13startStock[i-98292]=v
    endif
endfunction

function sg__PagedButtons_SlotType_get_maxStock takes integer i returns integer
    if(i<8191) then
        return s__PagedButtons_SlotType_maxStock[i]
    elseif(i<57337) then
        if(i<16382) then
            return s__PagedButtons_SlotType_2maxStock[i-8191]
        elseif(i<32764) then
            if(i<24573) then
                return s__PagedButtons_SlotType_3maxStock[i-16382]
            else
                return s__PagedButtons_SlotType_4maxStock[i-24573]
            endif
        elseif(i<40955) then
            return s__PagedButtons_SlotType_5maxStock[i-32764]
        elseif(i<49146) then
            return s__PagedButtons_SlotType_6maxStock[i-40955]
        else
            return s__PagedButtons_SlotType_7maxStock[i-49146]
        endif
    elseif(i<65528) then
        return s__PagedButtons_SlotType_8maxStock[i-57337]
    elseif(i<81910) then
        if(i<73719) then
            return s__PagedButtons_SlotType_9maxStock[i-65528]
        else
            return s__PagedButtons_SlotType_10maxStock[i-73719]
        endif
    elseif(i<90101) then
        return s__PagedButtons_SlotType_11maxStock[i-81910]
    elseif(i<98292) then
        return s__PagedButtons_SlotType_12maxStock[i-90101]
    else
        return s__PagedButtons_SlotType_13maxStock[i-98292]
    endif
endfunction

function sg__PagedButtons_SlotType_set_maxStock takes integer i,integer v returns nothing
    if(i<8191) then
        set s__PagedButtons_SlotType_maxStock[i]=v
    elseif(i<57337) then
        if(i<16382) then
            set s__PagedButtons_SlotType_2maxStock[i-8191]=v
        elseif(i<32764) then
            if(i<24573) then
                set s__PagedButtons_SlotType_3maxStock[i-16382]=v
            else
                set s__PagedButtons_SlotType_4maxStock[i-24573]=v
            endif
        elseif(i<40955) then
            set s__PagedButtons_SlotType_5maxStock[i-32764]=v
        elseif(i<49146) then
            set s__PagedButtons_SlotType_6maxStock[i-40955]=v
        else
            set s__PagedButtons_SlotType_7maxStock[i-49146]=v
        endif
    elseif(i<65528) then
        set s__PagedButtons_SlotType_8maxStock[i-57337]=v
    elseif(i<81910) then
        if(i<73719) then
            set s__PagedButtons_SlotType_9maxStock[i-65528]=v
        else
            set s__PagedButtons_SlotType_10maxStock[i-73719]=v
        endif
    elseif(i<90101) then
        set s__PagedButtons_SlotType_11maxStock[i-81910]=v
    elseif(i<98292) then
        set s__PagedButtons_SlotType_12maxStock[i-90101]=v
    else
        set s__PagedButtons_SlotType_13maxStock[i-98292]=v
    endif
endfunction

function sg__PagedButtons_SlotType_get_currentStock takes integer i returns integer
    if(i<8191) then
        return s__PagedButtons_SlotType_currentStock[i]
    elseif(i<57337) then
        if(i<16382) then
            return s__PagedButtons_SlotType_2currentStock[i-8191]
        elseif(i<32764) then
            if(i<24573) then
                return s__PagedButtons_SlotType_3currentStock[i-16382]
            else
                return s__PagedButtons_SlotType_4currentStock[i-24573]
            endif
        elseif(i<40955) then
            return s__PagedButtons_SlotType_5currentStock[i-32764]
        elseif(i<49146) then
            return s__PagedButtons_SlotType_6currentStock[i-40955]
        else
            return s__PagedButtons_SlotType_7currentStock[i-49146]
        endif
    elseif(i<65528) then
        return s__PagedButtons_SlotType_8currentStock[i-57337]
    elseif(i<81910) then
        if(i<73719) then
            return s__PagedButtons_SlotType_9currentStock[i-65528]
        else
            return s__PagedButtons_SlotType_10currentStock[i-73719]
        endif
    elseif(i<90101) then
        return s__PagedButtons_SlotType_11currentStock[i-81910]
    elseif(i<98292) then
        return s__PagedButtons_SlotType_12currentStock[i-90101]
    else
        return s__PagedButtons_SlotType_13currentStock[i-98292]
    endif
endfunction

function sg__PagedButtons_SlotType_set_currentStock takes integer i,integer v returns nothing
    if(i<8191) then
        set s__PagedButtons_SlotType_currentStock[i]=v
    elseif(i<57337) then
        if(i<16382) then
            set s__PagedButtons_SlotType_2currentStock[i-8191]=v
        elseif(i<32764) then
            if(i<24573) then
                set s__PagedButtons_SlotType_3currentStock[i-16382]=v
            else
                set s__PagedButtons_SlotType_4currentStock[i-24573]=v
            endif
        elseif(i<40955) then
            set s__PagedButtons_SlotType_5currentStock[i-32764]=v
        elseif(i<49146) then
            set s__PagedButtons_SlotType_6currentStock[i-40955]=v
        else
            set s__PagedButtons_SlotType_7currentStock[i-49146]=v
        endif
    elseif(i<65528) then
        set s__PagedButtons_SlotType_8currentStock[i-57337]=v
    elseif(i<81910) then
        if(i<73719) then
            set s__PagedButtons_SlotType_9currentStock[i-65528]=v
        else
            set s__PagedButtons_SlotType_10currentStock[i-73719]=v
        endif
    elseif(i<90101) then
        set s__PagedButtons_SlotType_11currentStock[i-81910]=v
    elseif(i<98292) then
        set s__PagedButtons_SlotType_12currentStock[i-90101]=v
    else
        set s__PagedButtons_SlotType_13currentStock[i-98292]=v
    endif
endfunction

function sg__PagedButtons_SlotType_get_startDelay takes integer i returns integer
    if(i<8191) then
        return s__PagedButtons_SlotType_startDelay[i]
    elseif(i<57337) then
        if(i<16382) then
            return s__PagedButtons_SlotType_2startDelay[i-8191]
        elseif(i<32764) then
            if(i<24573) then
                return s__PagedButtons_SlotType_3startDelay[i-16382]
            else
                return s__PagedButtons_SlotType_4startDelay[i-24573]
            endif
        elseif(i<40955) then
            return s__PagedButtons_SlotType_5startDelay[i-32764]
        elseif(i<49146) then
            return s__PagedButtons_SlotType_6startDelay[i-40955]
        else
            return s__PagedButtons_SlotType_7startDelay[i-49146]
        endif
    elseif(i<65528) then
        return s__PagedButtons_SlotType_8startDelay[i-57337]
    elseif(i<81910) then
        if(i<73719) then
            return s__PagedButtons_SlotType_9startDelay[i-65528]
        else
            return s__PagedButtons_SlotType_10startDelay[i-73719]
        endif
    elseif(i<90101) then
        return s__PagedButtons_SlotType_11startDelay[i-81910]
    elseif(i<98292) then
        return s__PagedButtons_SlotType_12startDelay[i-90101]
    else
        return s__PagedButtons_SlotType_13startDelay[i-98292]
    endif
endfunction

function sg__PagedButtons_SlotType_set_startDelay takes integer i,integer v returns nothing
    if(i<8191) then
        set s__PagedButtons_SlotType_startDelay[i]=v
    elseif(i<57337) then
        if(i<16382) then
            set s__PagedButtons_SlotType_2startDelay[i-8191]=v
        elseif(i<32764) then
            if(i<24573) then
                set s__PagedButtons_SlotType_3startDelay[i-16382]=v
            else
                set s__PagedButtons_SlotType_4startDelay[i-24573]=v
            endif
        elseif(i<40955) then
            set s__PagedButtons_SlotType_5startDelay[i-32764]=v
        elseif(i<49146) then
            set s__PagedButtons_SlotType_6startDelay[i-40955]=v
        else
            set s__PagedButtons_SlotType_7startDelay[i-49146]=v
        endif
    elseif(i<65528) then
        set s__PagedButtons_SlotType_8startDelay[i-57337]=v
    elseif(i<81910) then
        if(i<73719) then
            set s__PagedButtons_SlotType_9startDelay[i-65528]=v
        else
            set s__PagedButtons_SlotType_10startDelay[i-73719]=v
        endif
    elseif(i<90101) then
        set s__PagedButtons_SlotType_11startDelay[i-81910]=v
    elseif(i<98292) then
        set s__PagedButtons_SlotType_12startDelay[i-90101]=v
    else
        set s__PagedButtons_SlotType_13startDelay[i-98292]=v
    endif
endfunction

function sg__PagedButtons_SlotType_get_replenishInterval takes integer i returns integer
    if(i<8191) then
        return s__PagedButtons_SlotType_replenishInterval[i]
    elseif(i<57337) then
        if(i<16382) then
            return s__PagedButtons_SlotType_2replenishInterval[i-8191]
        elseif(i<32764) then
            if(i<24573) then
                return s__PagedButtons_SlotType_3replenishInterval[i-16382]
            else
                return s__PagedButtons_SlotType_4replenishInterval[i-24573]
            endif
        elseif(i<40955) then
            return s__PagedButtons_SlotType_5replenishInterval[i-32764]
        elseif(i<49146) then
            return s__PagedButtons_SlotType_6replenishInterval[i-40955]
        else
            return s__PagedButtons_SlotType_7replenishInterval[i-49146]
        endif
    elseif(i<65528) then
        return s__PagedButtons_SlotType_8replenishInterval[i-57337]
    elseif(i<81910) then
        if(i<73719) then
            return s__PagedButtons_SlotType_9replenishInterval[i-65528]
        else
            return s__PagedButtons_SlotType_10replenishInterval[i-73719]
        endif
    elseif(i<90101) then
        return s__PagedButtons_SlotType_11replenishInterval[i-81910]
    elseif(i<98292) then
        return s__PagedButtons_SlotType_12replenishInterval[i-90101]
    else
        return s__PagedButtons_SlotType_13replenishInterval[i-98292]
    endif
endfunction

function sg__PagedButtons_SlotType_set_replenishInterval takes integer i,integer v returns nothing
    if(i<8191) then
        set s__PagedButtons_SlotType_replenishInterval[i]=v
    elseif(i<57337) then
        if(i<16382) then
            set s__PagedButtons_SlotType_2replenishInterval[i-8191]=v
        elseif(i<32764) then
            if(i<24573) then
                set s__PagedButtons_SlotType_3replenishInterval[i-16382]=v
            else
                set s__PagedButtons_SlotType_4replenishInterval[i-24573]=v
            endif
        elseif(i<40955) then
            set s__PagedButtons_SlotType_5replenishInterval[i-32764]=v
        elseif(i<49146) then
            set s__PagedButtons_SlotType_6replenishInterval[i-40955]=v
        else
            set s__PagedButtons_SlotType_7replenishInterval[i-49146]=v
        endif
    elseif(i<65528) then
        set s__PagedButtons_SlotType_8replenishInterval[i-57337]=v
    elseif(i<81910) then
        if(i<73719) then
            set s__PagedButtons_SlotType_9replenishInterval[i-65528]=v
        else
            set s__PagedButtons_SlotType_10replenishInterval[i-73719]=v
        endif
    elseif(i<90101) then
        set s__PagedButtons_SlotType_11replenishInterval[i-81910]=v
    elseif(i<98292) then
        set s__PagedButtons_SlotType_12replenishInterval[i-90101]=v
    else
        set s__PagedButtons_SlotType_13replenishInterval[i-98292]=v
    endif
endfunction

function sg__PagedButtons_SlotType_get_replenish takes integer i returns boolean
    if(i<8191) then
        return s__PagedButtons_SlotType_replenish[i]
    elseif(i<57337) then
        if(i<16382) then
            return s__PagedButtons_SlotType_2replenish[i-8191]
        elseif(i<32764) then
            if(i<24573) then
                return s__PagedButtons_SlotType_3replenish[i-16382]
            else
                return s__PagedButtons_SlotType_4replenish[i-24573]
            endif
        elseif(i<40955) then
            return s__PagedButtons_SlotType_5replenish[i-32764]
        elseif(i<49146) then
            return s__PagedButtons_SlotType_6replenish[i-40955]
        else
            return s__PagedButtons_SlotType_7replenish[i-49146]
        endif
    elseif(i<65528) then
        return s__PagedButtons_SlotType_8replenish[i-57337]
    elseif(i<81910) then
        if(i<73719) then
            return s__PagedButtons_SlotType_9replenish[i-65528]
        else
            return s__PagedButtons_SlotType_10replenish[i-73719]
        endif
    elseif(i<90101) then
        return s__PagedButtons_SlotType_11replenish[i-81910]
    elseif(i<98292) then
        return s__PagedButtons_SlotType_12replenish[i-90101]
    else
        return s__PagedButtons_SlotType_13replenish[i-98292]
    endif
endfunction

function sg__PagedButtons_SlotType_set_replenish takes integer i,boolean v returns nothing
    if(i<8191) then
        set s__PagedButtons_SlotType_replenish[i]=v
    elseif(i<57337) then
        if(i<16382) then
            set s__PagedButtons_SlotType_2replenish[i-8191]=v
        elseif(i<32764) then
            if(i<24573) then
                set s__PagedButtons_SlotType_3replenish[i-16382]=v
            else
                set s__PagedButtons_SlotType_4replenish[i-24573]=v
            endif
        elseif(i<40955) then
            set s__PagedButtons_SlotType_5replenish[i-32764]=v
        elseif(i<49146) then
            set s__PagedButtons_SlotType_6replenish[i-40955]=v
        else
            set s__PagedButtons_SlotType_7replenish[i-49146]=v
        endif
    elseif(i<65528) then
        set s__PagedButtons_SlotType_8replenish[i-57337]=v
    elseif(i<81910) then
        if(i<73719) then
            set s__PagedButtons_SlotType_9replenish[i-65528]=v
        else
            set s__PagedButtons_SlotType_10replenish[i-73719]=v
        endif
    elseif(i<90101) then
        set s__PagedButtons_SlotType_11replenish[i-81910]=v
    elseif(i<98292) then
        set s__PagedButtons_SlotType_12replenish[i-90101]=v
    else
        set s__PagedButtons_SlotType_13replenish[i-98292]=v
    endif
endfunction

function sg__PagedButtons_SlotType_get_elapsedTimeStartDelay takes integer i returns integer
    if(i<8191) then
        return s__PagedButtons_SlotType_elapsedTimeStartDelay[i]
    elseif(i<57337) then
        if(i<16382) then
            return s__PagedButtons_SlotType_2elapsedTimeStartDelay[i-8191]
        elseif(i<32764) then
            if(i<24573) then
                return s__PagedButtons_SlotType_3elapsedTimeStartDelay[i-16382]
            else
                return s__PagedButtons_SlotType_4elapsedTimeStartDelay[i-24573]
            endif
        elseif(i<40955) then
            return s__PagedButtons_SlotType_5elapsedTimeStartDelay[i-32764]
        elseif(i<49146) then
            return s__PagedButtons_SlotType_6elapsedTimeStartDelay[i-40955]
        else
            return s__PagedButtons_SlotType_7elapsedTimeStartDelay[i-49146]
        endif
    elseif(i<65528) then
        return s__PagedButtons_SlotType_8elapsedTimeStartDelay[i-57337]
    elseif(i<81910) then
        if(i<73719) then
            return s__PagedButtons_SlotType_9elapsedTimeStartDelay[i-65528]
        else
            return s__PagedButtons_SlotType_10elapsedTimeStartDelay[i-73719]
        endif
    elseif(i<90101) then
        return s__PagedButtons_SlotType_11elapsedTimeStartDelay[i-81910]
    elseif(i<98292) then
        return s__PagedButtons_SlotType_12elapsedTimeStartDelay[i-90101]
    else
        return s__PagedButtons_SlotType_13elapsedTimeStartDelay[i-98292]
    endif
endfunction

function sg__PagedButtons_SlotType_set_elapsedTimeStartDelay takes integer i,integer v returns nothing
    if(i<8191) then
        set s__PagedButtons_SlotType_elapsedTimeStartDelay[i]=v
    elseif(i<57337) then
        if(i<16382) then
            set s__PagedButtons_SlotType_2elapsedTimeStartDelay[i-8191]=v
        elseif(i<32764) then
            if(i<24573) then
                set s__PagedButtons_SlotType_3elapsedTimeStartDelay[i-16382]=v
            else
                set s__PagedButtons_SlotType_4elapsedTimeStartDelay[i-24573]=v
            endif
        elseif(i<40955) then
            set s__PagedButtons_SlotType_5elapsedTimeStartDelay[i-32764]=v
        elseif(i<49146) then
            set s__PagedButtons_SlotType_6elapsedTimeStartDelay[i-40955]=v
        else
            set s__PagedButtons_SlotType_7elapsedTimeStartDelay[i-49146]=v
        endif
    elseif(i<65528) then
        set s__PagedButtons_SlotType_8elapsedTimeStartDelay[i-57337]=v
    elseif(i<81910) then
        if(i<73719) then
            set s__PagedButtons_SlotType_9elapsedTimeStartDelay[i-65528]=v
        else
            set s__PagedButtons_SlotType_10elapsedTimeStartDelay[i-73719]=v
        endif
    elseif(i<90101) then
        set s__PagedButtons_SlotType_11elapsedTimeStartDelay[i-81910]=v
    elseif(i<98292) then
        set s__PagedButtons_SlotType_12elapsedTimeStartDelay[i-90101]=v
    else
        set s__PagedButtons_SlotType_13elapsedTimeStartDelay[i-98292]=v
    endif
endfunction

function sg__PagedButtons_SlotType_get_elapsedTimeReplenishInterval takes integer i returns integer
    if(i<8191) then
        return s__PagedButtons_SlotType_elapsedTimeReplenishInterval[i]
    elseif(i<57337) then
        if(i<16382) then
            return s__PagedButtons_SlotType_2elapsedTimeReplenishInterval[i-8191]
        elseif(i<32764) then
            if(i<24573) then
                return s__PagedButtons_SlotType_3elapsedTimeReplenishInterval[i-16382]
            else
                return s__PagedButtons_SlotType_4elapsedTimeReplenishInterval[i-24573]
            endif
        elseif(i<40955) then
            return s__PagedButtons_SlotType_5elapsedTimeReplenishInterval[i-32764]
        elseif(i<49146) then
            return s__PagedButtons_SlotType_6elapsedTimeReplenishInterval[i-40955]
        else
            return s__PagedButtons_SlotType_7elapsedTimeReplenishInterval[i-49146]
        endif
    elseif(i<65528) then
        return s__PagedButtons_SlotType_8elapsedTimeReplenishInterval[i-57337]
    elseif(i<81910) then
        if(i<73719) then
            return s__PagedButtons_SlotType_9elapsedTimeReplenishInterval[i-65528]
        else
            return s__PagedButtons_SlotType_10elapsedTimeReplenishInterval[i-73719]
        endif
    elseif(i<90101) then
        return s__PagedButtons_SlotType_11elapsedTimeReplenishInterval[i-81910]
    elseif(i<98292) then
        return s__PagedButtons_SlotType_12elapsedTimeReplenishInterval[i-90101]
    else
        return s__PagedButtons_SlotType_13elapsedTimeReplenishInterval[i-98292]
    endif
endfunction

function sg__PagedButtons_SlotType_set_elapsedTimeReplenishInterval takes integer i,integer v returns nothing
    if(i<8191) then
        set s__PagedButtons_SlotType_elapsedTimeReplenishInterval[i]=v
    elseif(i<57337) then
        if(i<16382) then
            set s__PagedButtons_SlotType_2elapsedTimeReplenishInterval[i-8191]=v
        elseif(i<32764) then
            if(i<24573) then
                set s__PagedButtons_SlotType_3elapsedTimeReplenishInterval[i-16382]=v
            else
                set s__PagedButtons_SlotType_4elapsedTimeReplenishInterval[i-24573]=v
            endif
        elseif(i<40955) then
            set s__PagedButtons_SlotType_5elapsedTimeReplenishInterval[i-32764]=v
        elseif(i<49146) then
            set s__PagedButtons_SlotType_6elapsedTimeReplenishInterval[i-40955]=v
        else
            set s__PagedButtons_SlotType_7elapsedTimeReplenishInterval[i-49146]=v
        endif
    elseif(i<65528) then
        set s__PagedButtons_SlotType_8elapsedTimeReplenishInterval[i-57337]=v
    elseif(i<81910) then
        if(i<73719) then
            set s__PagedButtons_SlotType_9elapsedTimeReplenishInterval[i-65528]=v
        else
            set s__PagedButtons_SlotType_10elapsedTimeReplenishInterval[i-73719]=v
        endif
    elseif(i<90101) then
        set s__PagedButtons_SlotType_11elapsedTimeReplenishInterval[i-81910]=v
    elseif(i<98292) then
        set s__PagedButtons_SlotType_12elapsedTimeReplenishInterval[i-90101]=v
    else
        set s__PagedButtons_SlotType_13elapsedTimeReplenishInterval[i-98292]=v
    endif
endfunction

function sg__PagedButtons_SlotType_get_startDelayDone takes integer i returns boolean
    if(i<8191) then
        return s__PagedButtons_SlotType_startDelayDone[i]
    elseif(i<57337) then
        if(i<16382) then
            return s__PagedButtons_SlotType_2startDelayDone[i-8191]
        elseif(i<32764) then
            if(i<24573) then
                return s__PagedButtons_SlotType_3startDelayDone[i-16382]
            else
                return s__PagedButtons_SlotType_4startDelayDone[i-24573]
            endif
        elseif(i<40955) then
            return s__PagedButtons_SlotType_5startDelayDone[i-32764]
        elseif(i<49146) then
            return s__PagedButtons_SlotType_6startDelayDone[i-40955]
        else
            return s__PagedButtons_SlotType_7startDelayDone[i-49146]
        endif
    elseif(i<65528) then
        return s__PagedButtons_SlotType_8startDelayDone[i-57337]
    elseif(i<81910) then
        if(i<73719) then
            return s__PagedButtons_SlotType_9startDelayDone[i-65528]
        else
            return s__PagedButtons_SlotType_10startDelayDone[i-73719]
        endif
    elseif(i<90101) then
        return s__PagedButtons_SlotType_11startDelayDone[i-81910]
    elseif(i<98292) then
        return s__PagedButtons_SlotType_12startDelayDone[i-90101]
    else
        return s__PagedButtons_SlotType_13startDelayDone[i-98292]
    endif
endfunction

function sg__PagedButtons_SlotType_set_startDelayDone takes integer i,boolean v returns nothing
    if(i<8191) then
        set s__PagedButtons_SlotType_startDelayDone[i]=v
    elseif(i<57337) then
        if(i<16382) then
            set s__PagedButtons_SlotType_2startDelayDone[i-8191]=v
        elseif(i<32764) then
            if(i<24573) then
                set s__PagedButtons_SlotType_3startDelayDone[i-16382]=v
            else
                set s__PagedButtons_SlotType_4startDelayDone[i-24573]=v
            endif
        elseif(i<40955) then
            set s__PagedButtons_SlotType_5startDelayDone[i-32764]=v
        elseif(i<49146) then
            set s__PagedButtons_SlotType_6startDelayDone[i-40955]=v
        else
            set s__PagedButtons_SlotType_7startDelayDone[i-49146]=v
        endif
    elseif(i<65528) then
        set s__PagedButtons_SlotType_8startDelayDone[i-57337]=v
    elseif(i<81910) then
        if(i<73719) then
            set s__PagedButtons_SlotType_9startDelayDone[i-65528]=v
        else
            set s__PagedButtons_SlotType_10startDelayDone[i-73719]=v
        endif
    elseif(i<90101) then
        set s__PagedButtons_SlotType_11startDelayDone[i-81910]=v
    elseif(i<98292) then
        set s__PagedButtons_SlotType_12startDelayDone[i-90101]=v
    else
        set s__PagedButtons_SlotType_13startDelayDone[i-98292]=v
    endif
endfunction

//Generated allocator of PagedButtons_Type
function s__PagedButtons_Type__allocate takes nothing returns integer
 local integer this=si__PagedButtons_Type_F
    if (this!=0) then
        if(this<8191) then
            set si__PagedButtons_Type_F=si__PagedButtons_Type_V[this]
        elseif(this<57337) then
            if(this<16382) then
                set si__PagedButtons_Type_F=si__PagedButtons_Type_2V[this-8191]
            elseif(this<32764) then
                if(this<24573) then
                    set si__PagedButtons_Type_F=si__PagedButtons_Type_3V[this-16382]
                else
                    set si__PagedButtons_Type_F=si__PagedButtons_Type_4V[this-24573]
                endif
            elseif(this<40955) then
                set si__PagedButtons_Type_F=si__PagedButtons_Type_5V[this-32764]
            elseif(this<49146) then
                set si__PagedButtons_Type_F=si__PagedButtons_Type_6V[this-40955]
            else
                set si__PagedButtons_Type_F=si__PagedButtons_Type_7V[this-49146]
            endif
        elseif(this<65528) then
            set si__PagedButtons_Type_F=si__PagedButtons_Type_8V[this-57337]
        elseif(this<81910) then
            if(this<73719) then
                set si__PagedButtons_Type_F=si__PagedButtons_Type_9V[this-65528]
            else
                set si__PagedButtons_Type_F=si__PagedButtons_Type_10V[this-73719]
            endif
        elseif(this<90101) then
            set si__PagedButtons_Type_F=si__PagedButtons_Type_11V[this-81910]
        elseif(this<98292) then
            set si__PagedButtons_Type_F=si__PagedButtons_Type_12V[this-90101]
        else
            set si__PagedButtons_Type_F=si__PagedButtons_Type_13V[this-98292]
        endif
    else
        set si__PagedButtons_Type_I=si__PagedButtons_Type_I+1
        set this=si__PagedButtons_Type_I
    endif
    if (this>100000) then
        return 0
    endif

    if(this<8191) then
        set s__PagedButtons_Type_shown[this]= false
        set s__PagedButtons_Type_enabled[this]= true
    elseif(this<57337) then
        if(this<16382) then
            set s__PagedButtons_Type_2shown[this-8191]= false
            set s__PagedButtons_Type_2enabled[this-8191]= true
        elseif(this<32764) then
            if(this<24573) then
                set s__PagedButtons_Type_3shown[this-16382]= false
                set s__PagedButtons_Type_3enabled[this-16382]= true
            else
                set s__PagedButtons_Type_4shown[this-24573]= false
                set s__PagedButtons_Type_4enabled[this-24573]= true
            endif
        elseif(this<40955) then
            set s__PagedButtons_Type_5shown[this-32764]= false
            set s__PagedButtons_Type_5enabled[this-32764]= true
        elseif(this<49146) then
            set s__PagedButtons_Type_6shown[this-40955]= false
            set s__PagedButtons_Type_6enabled[this-40955]= true
        else
            set s__PagedButtons_Type_7shown[this-49146]= false
            set s__PagedButtons_Type_7enabled[this-49146]= true
        endif
    elseif(this<65528) then
        set s__PagedButtons_Type_8shown[this-57337]= false
        set s__PagedButtons_Type_8enabled[this-57337]= true
    elseif(this<81910) then
        if(this<73719) then
            set s__PagedButtons_Type_9shown[this-65528]= false
            set s__PagedButtons_Type_9enabled[this-65528]= true
        else
            set s__PagedButtons_Type_10shown[this-73719]= false
            set s__PagedButtons_Type_10enabled[this-73719]= true
        endif
    elseif(this<90101) then
        set s__PagedButtons_Type_11shown[this-81910]= false
        set s__PagedButtons_Type_11enabled[this-81910]= true
    elseif(this<98292) then
        set s__PagedButtons_Type_12shown[this-90101]= false
        set s__PagedButtons_Type_12enabled[this-90101]= true
    else
        set s__PagedButtons_Type_13shown[this-98292]= false
        set s__PagedButtons_Type_13enabled[this-98292]= true
    endif
    if(this<8191) then
        set si__PagedButtons_Type_type[this]=1
    elseif(this<57337) then
        if(this<16382) then
            set si__PagedButtons_Type_2type[this-8191]=1
        elseif(this<32764) then
            if(this<24573) then
                set si__PagedButtons_Type_3type[this-16382]=1
            else
                set si__PagedButtons_Type_4type[this-24573]=1
            endif
        elseif(this<40955) then
            set si__PagedButtons_Type_5type[this-32764]=1
        elseif(this<49146) then
            set si__PagedButtons_Type_6type[this-40955]=1
        else
            set si__PagedButtons_Type_7type[this-49146]=1
        endif
    elseif(this<65528) then
        set si__PagedButtons_Type_8type[this-57337]=1
    elseif(this<81910) then
        if(this<73719) then
            set si__PagedButtons_Type_9type[this-65528]=1
        else
            set si__PagedButtons_Type_10type[this-73719]=1
        endif
    elseif(this<90101) then
        set si__PagedButtons_Type_11type[this-81910]=1
    elseif(this<98292) then
        set si__PagedButtons_Type_12type[this-90101]=1
    else
        set si__PagedButtons_Type_13type[this-98292]=1
    endif
    if(this<8191) then
        set si__PagedButtons_Type_V[this]=-1
    elseif(this<57337) then
        if(this<16382) then
            set si__PagedButtons_Type_2V[this-8191]=-1
        elseif(this<32764) then
            if(this<24573) then
                set si__PagedButtons_Type_3V[this-16382]=-1
            else
                set si__PagedButtons_Type_4V[this-24573]=-1
            endif
        elseif(this<40955) then
            set si__PagedButtons_Type_5V[this-32764]=-1
        elseif(this<49146) then
            set si__PagedButtons_Type_6V[this-40955]=-1
        else
            set si__PagedButtons_Type_7V[this-49146]=-1
        endif
    elseif(this<65528) then
        set si__PagedButtons_Type_8V[this-57337]=-1
    elseif(this<81910) then
        if(this<73719) then
            set si__PagedButtons_Type_9V[this-65528]=-1
        else
            set si__PagedButtons_Type_10V[this-73719]=-1
        endif
    elseif(this<90101) then
        set si__PagedButtons_Type_11V[this-81910]=-1
    elseif(this<98292) then
        set si__PagedButtons_Type_12V[this-90101]=-1
    else
        set si__PagedButtons_Type_13V[this-98292]=-1
    endif
 return this
endfunction

//Generated destructor of PagedButtons_Type
function sc__PagedButtons_Type_deallocate takes integer this returns nothing
 local integer used
    if this==null then
        return
    else
        if(this<8191) then
            set used=si__PagedButtons_Type_V[this]
        elseif(this<57337) then
            if(this<16382) then
                set used=si__PagedButtons_Type_2V[this-8191]
            elseif(this<32764) then
                if(this<24573) then
                    set used=si__PagedButtons_Type_3V[this-16382]
                else
                    set used=si__PagedButtons_Type_4V[this-24573]
                endif
            elseif(this<40955) then
                set used=si__PagedButtons_Type_5V[this-32764]
            elseif(this<49146) then
                set used=si__PagedButtons_Type_6V[this-40955]
            else
                set used=si__PagedButtons_Type_7V[this-49146]
            endif
        elseif(this<65528) then
            set used=si__PagedButtons_Type_8V[this-57337]
        elseif(this<81910) then
            if(this<73719) then
                set used=si__PagedButtons_Type_9V[this-65528]
            else
                set used=si__PagedButtons_Type_10V[this-73719]
            endif
        elseif(this<90101) then
            set used=si__PagedButtons_Type_11V[this-81910]
        elseif(this<98292) then
            set used=si__PagedButtons_Type_12V[this-90101]
        else
            set used=si__PagedButtons_Type_13V[this-98292]
        endif
        if (used!=-1) then
            return
        endif
    endif
    set f__arg_this=this
    if(this<8191) then
        call TriggerEvaluate(st__PagedButtons_Type_onDestroy[si__PagedButtons_Type_type[this]])
    elseif(this<57337) then
        if(this<16382) then
            call TriggerEvaluate(st__PagedButtons_Type_onDestroy[si__PagedButtons_Type_2type[this-8191]])
        elseif(this<32764) then
            if(this<24573) then
                call TriggerEvaluate(st__PagedButtons_Type_onDestroy[si__PagedButtons_Type_3type[this-16382]])
            else
                call TriggerEvaluate(st__PagedButtons_Type_onDestroy[si__PagedButtons_Type_4type[this-24573]])
            endif
        elseif(this<40955) then
            call TriggerEvaluate(st__PagedButtons_Type_onDestroy[si__PagedButtons_Type_5type[this-32764]])
        elseif(this<49146) then
            call TriggerEvaluate(st__PagedButtons_Type_onDestroy[si__PagedButtons_Type_6type[this-40955]])
        else
            call TriggerEvaluate(st__PagedButtons_Type_onDestroy[si__PagedButtons_Type_7type[this-49146]])
        endif
    elseif(this<65528) then
        call TriggerEvaluate(st__PagedButtons_Type_onDestroy[si__PagedButtons_Type_8type[this-57337]])
    elseif(this<81910) then
        if(this<73719) then
            call TriggerEvaluate(st__PagedButtons_Type_onDestroy[si__PagedButtons_Type_9type[this-65528]])
        else
            call TriggerEvaluate(st__PagedButtons_Type_onDestroy[si__PagedButtons_Type_10type[this-73719]])
        endif
    elseif(this<90101) then
        call TriggerEvaluate(st__PagedButtons_Type_onDestroy[si__PagedButtons_Type_11type[this-81910]])
    elseif(this<98292) then
        call TriggerEvaluate(st__PagedButtons_Type_onDestroy[si__PagedButtons_Type_12type[this-90101]])
    else
        call TriggerEvaluate(st__PagedButtons_Type_onDestroy[si__PagedButtons_Type_13type[this-98292]])
    endif
    if(this<8191) then
        set si__PagedButtons_Type_V[this]=si__PagedButtons_Type_F
    elseif(this<57337) then
        if(this<16382) then
            set si__PagedButtons_Type_2V[this-8191]=si__PagedButtons_Type_F
        elseif(this<32764) then
            if(this<24573) then
                set si__PagedButtons_Type_3V[this-16382]=si__PagedButtons_Type_F
            else
                set si__PagedButtons_Type_4V[this-24573]=si__PagedButtons_Type_F
            endif
        elseif(this<40955) then
            set si__PagedButtons_Type_5V[this-32764]=si__PagedButtons_Type_F
        elseif(this<49146) then
            set si__PagedButtons_Type_6V[this-40955]=si__PagedButtons_Type_F
        else
            set si__PagedButtons_Type_7V[this-49146]=si__PagedButtons_Type_F
        endif
    elseif(this<65528) then
        set si__PagedButtons_Type_8V[this-57337]=si__PagedButtons_Type_F
    elseif(this<81910) then
        if(this<73719) then
            set si__PagedButtons_Type_9V[this-65528]=si__PagedButtons_Type_F
        else
            set si__PagedButtons_Type_10V[this-73719]=si__PagedButtons_Type_F
        endif
    elseif(this<90101) then
        set si__PagedButtons_Type_11V[this-81910]=si__PagedButtons_Type_F
    elseif(this<98292) then
        set si__PagedButtons_Type_12V[this-90101]=si__PagedButtons_Type_F
    else
        set si__PagedButtons_Type_13V[this-98292]=si__PagedButtons_Type_F
    endif
    set si__PagedButtons_Type_F=this
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

//Generated allocator of PagedButtons_Shop
function s__PagedButtons_Shop__allocate takes nothing returns integer
 local integer this=si__PagedButtons_Shop_F
    if (this!=0) then
        if(this<8191) then
            set si__PagedButtons_Shop_F=si__PagedButtons_Shop_V[this]
        elseif(this<57337) then
            if(this<16382) then
                set si__PagedButtons_Shop_F=si__PagedButtons_Shop_2V[this-8191]
            elseif(this<32764) then
                if(this<24573) then
                    set si__PagedButtons_Shop_F=si__PagedButtons_Shop_3V[this-16382]
                else
                    set si__PagedButtons_Shop_F=si__PagedButtons_Shop_4V[this-24573]
                endif
            elseif(this<40955) then
                set si__PagedButtons_Shop_F=si__PagedButtons_Shop_5V[this-32764]
            elseif(this<49146) then
                set si__PagedButtons_Shop_F=si__PagedButtons_Shop_6V[this-40955]
            else
                set si__PagedButtons_Shop_F=si__PagedButtons_Shop_7V[this-49146]
            endif
        elseif(this<65528) then
            set si__PagedButtons_Shop_F=si__PagedButtons_Shop_8V[this-57337]
        elseif(this<81910) then
            if(this<73719) then
                set si__PagedButtons_Shop_F=si__PagedButtons_Shop_9V[this-65528]
            else
                set si__PagedButtons_Shop_F=si__PagedButtons_Shop_10V[this-73719]
            endif
        elseif(this<90101) then
            set si__PagedButtons_Shop_F=si__PagedButtons_Shop_11V[this-81910]
        elseif(this<98292) then
            set si__PagedButtons_Shop_F=si__PagedButtons_Shop_12V[this-90101]
        else
            set si__PagedButtons_Shop_F=si__PagedButtons_Shop_13V[this-98292]
        endif
    else
        set si__PagedButtons_Shop_I=si__PagedButtons_Shop_I+1
        set this=si__PagedButtons_Shop_I
    endif
    if (this>99) then
        return 0
    endif
    if(this<8191) then
        set s__PagedButtons_Shop_buttons[this]=(this-1)*1000
    elseif(this<57337) then
        if(this<16382) then
            set s__PagedButtons_Shop_2buttons[this-8191]=(this-1)*1000
        elseif(this<32764) then
            if(this<24573) then
                set s__PagedButtons_Shop_3buttons[this-16382]=(this-1)*1000
            else
                set s__PagedButtons_Shop_4buttons[this-24573]=(this-1)*1000
            endif
        elseif(this<40955) then
            set s__PagedButtons_Shop_5buttons[this-32764]=(this-1)*1000
        elseif(this<49146) then
            set s__PagedButtons_Shop_6buttons[this-40955]=(this-1)*1000
        else
            set s__PagedButtons_Shop_7buttons[this-49146]=(this-1)*1000
        endif
    elseif(this<65528) then
        set s__PagedButtons_Shop_8buttons[this-57337]=(this-1)*1000
    elseif(this<81910) then
        if(this<73719) then
            set s__PagedButtons_Shop_9buttons[this-65528]=(this-1)*1000
        else
            set s__PagedButtons_Shop_10buttons[this-73719]=(this-1)*1000
        endif
    elseif(this<90101) then
        set s__PagedButtons_Shop_11buttons[this-81910]=(this-1)*1000
    elseif(this<98292) then
        set s__PagedButtons_Shop_12buttons[this-90101]=(this-1)*1000
    else
        set s__PagedButtons_Shop_13buttons[this-98292]=(this-1)*1000
    endif
    if(this<8191) then
        set s__PagedButtons_Shop_pages[this]=(this-1)*500
    elseif(this<57337) then
        if(this<16382) then
            set s__PagedButtons_Shop_2pages[this-8191]=(this-1)*500
        elseif(this<32764) then
            if(this<24573) then
                set s__PagedButtons_Shop_3pages[this-16382]=(this-1)*500
            else
                set s__PagedButtons_Shop_4pages[this-24573]=(this-1)*500
            endif
        elseif(this<40955) then
            set s__PagedButtons_Shop_5pages[this-32764]=(this-1)*500
        elseif(this<49146) then
            set s__PagedButtons_Shop_6pages[this-40955]=(this-1)*500
        else
            set s__PagedButtons_Shop_7pages[this-49146]=(this-1)*500
        endif
    elseif(this<65528) then
        set s__PagedButtons_Shop_8pages[this-57337]=(this-1)*500
    elseif(this<81910) then
        if(this<73719) then
            set s__PagedButtons_Shop_9pages[this-65528]=(this-1)*500
        else
            set s__PagedButtons_Shop_10pages[this-73719]=(this-1)*500
        endif
    elseif(this<90101) then
        set s__PagedButtons_Shop_11pages[this-81910]=(this-1)*500
    elseif(this<98292) then
        set s__PagedButtons_Shop_12pages[this-90101]=(this-1)*500
    else
        set s__PagedButtons_Shop_13pages[this-98292]=(this-1)*500
    endif
    if(this<8191) then
        set s__PagedButtons_Shop_slotsPerPage[this]= PagedButtons_SLOTS_PER_PAGE
        set s__PagedButtons_Shop_currentPage[this]= 0
        set s__PagedButtons_Shop_buttonsCount[this]= 0
        set s__PagedButtons_Shop_maxPages[this]= 0
    elseif(this<57337) then
        if(this<16382) then
            set s__PagedButtons_Shop_2slotsPerPage[this-8191]= PagedButtons_SLOTS_PER_PAGE
            set s__PagedButtons_Shop_2currentPage[this-8191]= 0
            set s__PagedButtons_Shop_2buttonsCount[this-8191]= 0
            set s__PagedButtons_Shop_2maxPages[this-8191]= 0
        elseif(this<32764) then
            if(this<24573) then
                set s__PagedButtons_Shop_3slotsPerPage[this-16382]= PagedButtons_SLOTS_PER_PAGE
                set s__PagedButtons_Shop_3currentPage[this-16382]= 0
                set s__PagedButtons_Shop_3buttonsCount[this-16382]= 0
                set s__PagedButtons_Shop_3maxPages[this-16382]= 0
            else
                set s__PagedButtons_Shop_4slotsPerPage[this-24573]= PagedButtons_SLOTS_PER_PAGE
                set s__PagedButtons_Shop_4currentPage[this-24573]= 0
                set s__PagedButtons_Shop_4buttonsCount[this-24573]= 0
                set s__PagedButtons_Shop_4maxPages[this-24573]= 0
            endif
        elseif(this<40955) then
            set s__PagedButtons_Shop_5slotsPerPage[this-32764]= PagedButtons_SLOTS_PER_PAGE
            set s__PagedButtons_Shop_5currentPage[this-32764]= 0
            set s__PagedButtons_Shop_5buttonsCount[this-32764]= 0
            set s__PagedButtons_Shop_5maxPages[this-32764]= 0
        elseif(this<49146) then
            set s__PagedButtons_Shop_6slotsPerPage[this-40955]= PagedButtons_SLOTS_PER_PAGE
            set s__PagedButtons_Shop_6currentPage[this-40955]= 0
            set s__PagedButtons_Shop_6buttonsCount[this-40955]= 0
            set s__PagedButtons_Shop_6maxPages[this-40955]= 0
        else
            set s__PagedButtons_Shop_7slotsPerPage[this-49146]= PagedButtons_SLOTS_PER_PAGE
            set s__PagedButtons_Shop_7currentPage[this-49146]= 0
            set s__PagedButtons_Shop_7buttonsCount[this-49146]= 0
            set s__PagedButtons_Shop_7maxPages[this-49146]= 0
        endif
    elseif(this<65528) then
        set s__PagedButtons_Shop_8slotsPerPage[this-57337]= PagedButtons_SLOTS_PER_PAGE
        set s__PagedButtons_Shop_8currentPage[this-57337]= 0
        set s__PagedButtons_Shop_8buttonsCount[this-57337]= 0
        set s__PagedButtons_Shop_8maxPages[this-57337]= 0
    elseif(this<81910) then
        if(this<73719) then
            set s__PagedButtons_Shop_9slotsPerPage[this-65528]= PagedButtons_SLOTS_PER_PAGE
            set s__PagedButtons_Shop_9currentPage[this-65528]= 0
            set s__PagedButtons_Shop_9buttonsCount[this-65528]= 0
            set s__PagedButtons_Shop_9maxPages[this-65528]= 0
        else
            set s__PagedButtons_Shop_10slotsPerPage[this-73719]= PagedButtons_SLOTS_PER_PAGE
            set s__PagedButtons_Shop_10currentPage[this-73719]= 0
            set s__PagedButtons_Shop_10buttonsCount[this-73719]= 0
            set s__PagedButtons_Shop_10maxPages[this-73719]= 0
        endif
    elseif(this<90101) then
        set s__PagedButtons_Shop_11slotsPerPage[this-81910]= PagedButtons_SLOTS_PER_PAGE
        set s__PagedButtons_Shop_11currentPage[this-81910]= 0
        set s__PagedButtons_Shop_11buttonsCount[this-81910]= 0
        set s__PagedButtons_Shop_11maxPages[this-81910]= 0
    elseif(this<98292) then
        set s__PagedButtons_Shop_12slotsPerPage[this-90101]= PagedButtons_SLOTS_PER_PAGE
        set s__PagedButtons_Shop_12currentPage[this-90101]= 0
        set s__PagedButtons_Shop_12buttonsCount[this-90101]= 0
        set s__PagedButtons_Shop_12maxPages[this-90101]= 0
    else
        set s__PagedButtons_Shop_13slotsPerPage[this-98292]= PagedButtons_SLOTS_PER_PAGE
        set s__PagedButtons_Shop_13currentPage[this-98292]= 0
        set s__PagedButtons_Shop_13buttonsCount[this-98292]= 0
        set s__PagedButtons_Shop_13maxPages[this-98292]= 0
    endif
    if(this<8191) then
        set si__PagedButtons_Shop_V[this]=-1
    elseif(this<57337) then
        if(this<16382) then
            set si__PagedButtons_Shop_2V[this-8191]=-1
        elseif(this<32764) then
            if(this<24573) then
                set si__PagedButtons_Shop_3V[this-16382]=-1
            else
                set si__PagedButtons_Shop_4V[this-24573]=-1
            endif
        elseif(this<40955) then
            set si__PagedButtons_Shop_5V[this-32764]=-1
        elseif(this<49146) then
            set si__PagedButtons_Shop_6V[this-40955]=-1
        else
            set si__PagedButtons_Shop_7V[this-49146]=-1
        endif
    elseif(this<65528) then
        set si__PagedButtons_Shop_8V[this-57337]=-1
    elseif(this<81910) then
        if(this<73719) then
            set si__PagedButtons_Shop_9V[this-65528]=-1
        else
            set si__PagedButtons_Shop_10V[this-73719]=-1
        endif
    elseif(this<90101) then
        set si__PagedButtons_Shop_11V[this-81910]=-1
    elseif(this<98292) then
        set si__PagedButtons_Shop_12V[this-90101]=-1
    else
        set si__PagedButtons_Shop_13V[this-98292]=-1
    endif
 return this
endfunction

//Generated destructor of PagedButtons_Shop
function s__PagedButtons_Shop_deallocate takes integer this returns nothing
 local integer used
    if this==null then
        return
    else
        if(this<8191) then
            set used=si__PagedButtons_Shop_V[this]
        elseif(this<57337) then
            if(this<16382) then
                set used=si__PagedButtons_Shop_2V[this-8191]
            elseif(this<32764) then
                if(this<24573) then
                    set used=si__PagedButtons_Shop_3V[this-16382]
                else
                    set used=si__PagedButtons_Shop_4V[this-24573]
                endif
            elseif(this<40955) then
                set used=si__PagedButtons_Shop_5V[this-32764]
            elseif(this<49146) then
                set used=si__PagedButtons_Shop_6V[this-40955]
            else
                set used=si__PagedButtons_Shop_7V[this-49146]
            endif
        elseif(this<65528) then
            set used=si__PagedButtons_Shop_8V[this-57337]
        elseif(this<81910) then
            if(this<73719) then
                set used=si__PagedButtons_Shop_9V[this-65528]
            else
                set used=si__PagedButtons_Shop_10V[this-73719]
            endif
        elseif(this<90101) then
            set used=si__PagedButtons_Shop_11V[this-81910]
        elseif(this<98292) then
            set used=si__PagedButtons_Shop_12V[this-90101]
        else
            set used=si__PagedButtons_Shop_13V[this-98292]
        endif
        if (used!=-1) then
            return
        endif
    endif
    if(this<8191) then
        set si__PagedButtons_Shop_V[this]=si__PagedButtons_Shop_F
    elseif(this<57337) then
        if(this<16382) then
            set si__PagedButtons_Shop_2V[this-8191]=si__PagedButtons_Shop_F
        elseif(this<32764) then
            if(this<24573) then
                set si__PagedButtons_Shop_3V[this-16382]=si__PagedButtons_Shop_F
            else
                set si__PagedButtons_Shop_4V[this-24573]=si__PagedButtons_Shop_F
            endif
        elseif(this<40955) then
            set si__PagedButtons_Shop_5V[this-32764]=si__PagedButtons_Shop_F
        elseif(this<49146) then
            set si__PagedButtons_Shop_6V[this-40955]=si__PagedButtons_Shop_F
        else
            set si__PagedButtons_Shop_7V[this-49146]=si__PagedButtons_Shop_F
        endif
    elseif(this<65528) then
        set si__PagedButtons_Shop_8V[this-57337]=si__PagedButtons_Shop_F
    elseif(this<81910) then
        if(this<73719) then
            set si__PagedButtons_Shop_9V[this-65528]=si__PagedButtons_Shop_F
        else
            set si__PagedButtons_Shop_10V[this-73719]=si__PagedButtons_Shop_F
        endif
    elseif(this<90101) then
        set si__PagedButtons_Shop_11V[this-81910]=si__PagedButtons_Shop_F
    elseif(this<98292) then
        set si__PagedButtons_Shop_12V[this-90101]=si__PagedButtons_Shop_F
    else
        set si__PagedButtons_Shop_13V[this-98292]=si__PagedButtons_Shop_F
    endif
    set si__PagedButtons_Shop_F=this
endfunction

//Generated allocator of PagedButtons_Page
function s__PagedButtons_Page__allocate takes nothing returns integer
 local integer this=si__PagedButtons_Page_F
    if (this!=0) then
        if(this<8191) then
            set si__PagedButtons_Page_F=si__PagedButtons_Page_V[this]
        elseif(this<57337) then
            if(this<16382) then
                set si__PagedButtons_Page_F=si__PagedButtons_Page_2V[this-8191]
            elseif(this<32764) then
                if(this<24573) then
                    set si__PagedButtons_Page_F=si__PagedButtons_Page_3V[this-16382]
                else
                    set si__PagedButtons_Page_F=si__PagedButtons_Page_4V[this-24573]
                endif
            elseif(this<40955) then
                set si__PagedButtons_Page_F=si__PagedButtons_Page_5V[this-32764]
            elseif(this<49146) then
                set si__PagedButtons_Page_F=si__PagedButtons_Page_6V[this-40955]
            else
                set si__PagedButtons_Page_F=si__PagedButtons_Page_7V[this-49146]
            endif
        elseif(this<65528) then
            set si__PagedButtons_Page_F=si__PagedButtons_Page_8V[this-57337]
        elseif(this<81910) then
            if(this<73719) then
                set si__PagedButtons_Page_F=si__PagedButtons_Page_9V[this-65528]
            else
                set si__PagedButtons_Page_F=si__PagedButtons_Page_10V[this-73719]
            endif
        elseif(this<90101) then
            set si__PagedButtons_Page_F=si__PagedButtons_Page_11V[this-81910]
        elseif(this<98292) then
            set si__PagedButtons_Page_F=si__PagedButtons_Page_12V[this-90101]
        else
            set si__PagedButtons_Page_F=si__PagedButtons_Page_13V[this-98292]
        endif
    else
        set si__PagedButtons_Page_I=si__PagedButtons_Page_I+1
        set this=si__PagedButtons_Page_I
    endif
    if (this>100000) then
        return 0
    endif

    if(this<8191) then
        set si__PagedButtons_Page_V[this]=-1
    elseif(this<57337) then
        if(this<16382) then
            set si__PagedButtons_Page_2V[this-8191]=-1
        elseif(this<32764) then
            if(this<24573) then
                set si__PagedButtons_Page_3V[this-16382]=-1
            else
                set si__PagedButtons_Page_4V[this-24573]=-1
            endif
        elseif(this<40955) then
            set si__PagedButtons_Page_5V[this-32764]=-1
        elseif(this<49146) then
            set si__PagedButtons_Page_6V[this-40955]=-1
        else
            set si__PagedButtons_Page_7V[this-49146]=-1
        endif
    elseif(this<65528) then
        set si__PagedButtons_Page_8V[this-57337]=-1
    elseif(this<81910) then
        if(this<73719) then
            set si__PagedButtons_Page_9V[this-65528]=-1
        else
            set si__PagedButtons_Page_10V[this-73719]=-1
        endif
    elseif(this<90101) then
        set si__PagedButtons_Page_11V[this-81910]=-1
    elseif(this<98292) then
        set si__PagedButtons_Page_12V[this-90101]=-1
    else
        set si__PagedButtons_Page_13V[this-98292]=-1
    endif
 return this
endfunction

//Generated destructor of PagedButtons_Page
function s__PagedButtons_Page_deallocate takes integer this returns nothing
 local integer used
    if this==null then
        return
    else
        if(this<8191) then
            set used=si__PagedButtons_Page_V[this]
        elseif(this<57337) then
            if(this<16382) then
                set used=si__PagedButtons_Page_2V[this-8191]
            elseif(this<32764) then
                if(this<24573) then
                    set used=si__PagedButtons_Page_3V[this-16382]
                else
                    set used=si__PagedButtons_Page_4V[this-24573]
                endif
            elseif(this<40955) then
                set used=si__PagedButtons_Page_5V[this-32764]
            elseif(this<49146) then
                set used=si__PagedButtons_Page_6V[this-40955]
            else
                set used=si__PagedButtons_Page_7V[this-49146]
            endif
        elseif(this<65528) then
            set used=si__PagedButtons_Page_8V[this-57337]
        elseif(this<81910) then
            if(this<73719) then
                set used=si__PagedButtons_Page_9V[this-65528]
            else
                set used=si__PagedButtons_Page_10V[this-73719]
            endif
        elseif(this<90101) then
            set used=si__PagedButtons_Page_11V[this-81910]
        elseif(this<98292) then
            set used=si__PagedButtons_Page_12V[this-90101]
        else
            set used=si__PagedButtons_Page_13V[this-98292]
        endif
        if (used!=-1) then
            return
        endif
    endif
    if(this<8191) then
        set si__PagedButtons_Page_V[this]=si__PagedButtons_Page_F
    elseif(this<57337) then
        if(this<16382) then
            set si__PagedButtons_Page_2V[this-8191]=si__PagedButtons_Page_F
        elseif(this<32764) then
            if(this<24573) then
                set si__PagedButtons_Page_3V[this-16382]=si__PagedButtons_Page_F
            else
                set si__PagedButtons_Page_4V[this-24573]=si__PagedButtons_Page_F
            endif
        elseif(this<40955) then
            set si__PagedButtons_Page_5V[this-32764]=si__PagedButtons_Page_F
        elseif(this<49146) then
            set si__PagedButtons_Page_6V[this-40955]=si__PagedButtons_Page_F
        else
            set si__PagedButtons_Page_7V[this-49146]=si__PagedButtons_Page_F
        endif
    elseif(this<65528) then
        set si__PagedButtons_Page_8V[this-57337]=si__PagedButtons_Page_F
    elseif(this<81910) then
        if(this<73719) then
            set si__PagedButtons_Page_9V[this-65528]=si__PagedButtons_Page_F
        else
            set si__PagedButtons_Page_10V[this-73719]=si__PagedButtons_Page_F
        endif
    elseif(this<90101) then
        set si__PagedButtons_Page_11V[this-81910]=si__PagedButtons_Page_F
    elseif(this<98292) then
        set si__PagedButtons_Page_12V[this-90101]=si__PagedButtons_Page_F
    else
        set si__PagedButtons_Page_13V[this-98292]=si__PagedButtons_Page_F
    endif
    set si__PagedButtons_Page_F=this
endfunction

//Generated method caller for PagedButtons_SlotType.onDestroy
function sc__PagedButtons_SlotType_onDestroy takes integer this returns nothing
    set f__arg_this=this
    call TriggerEvaluate(st__PagedButtons_Type_onDestroy[3])
endfunction

//Generated allocator of PagedButtons_SlotType
function s__PagedButtons_SlotType__allocate takes nothing returns integer
 local integer this=s__PagedButtons_Type__allocate()
 local integer kthis
    if(this==0) then
        return 0
    endif
    if(this<8191) then
        set si__PagedButtons_Type_type[this]=3
    elseif(this<57337) then
        if(this<16382) then
            set si__PagedButtons_Type_2type[this-8191]=3
        elseif(this<32764) then
            if(this<24573) then
                set si__PagedButtons_Type_3type[this-16382]=3
            else
                set si__PagedButtons_Type_4type[this-24573]=3
            endif
        elseif(this<40955) then
            set si__PagedButtons_Type_5type[this-32764]=3
        elseif(this<49146) then
            set si__PagedButtons_Type_6type[this-40955]=3
        else
            set si__PagedButtons_Type_7type[this-49146]=3
        endif
    elseif(this<65528) then
        set si__PagedButtons_Type_8type[this-57337]=3
    elseif(this<81910) then
        if(this<73719) then
            set si__PagedButtons_Type_9type[this-65528]=3
        else
            set si__PagedButtons_Type_10type[this-73719]=3
        endif
    elseif(this<90101) then
        set si__PagedButtons_Type_11type[this-81910]=3
    elseif(this<98292) then
        set si__PagedButtons_Type_12type[this-90101]=3
    else
        set si__PagedButtons_Type_13type[this-98292]=3
    endif
    set kthis=this

    if(this<8191) then
        set s__PagedButtons_SlotType_replenish[this]= true
        set s__PagedButtons_SlotType_startDelayDone[this]= false
    elseif(this<57337) then
        if(this<16382) then
            set s__PagedButtons_SlotType_2replenish[this-8191]= true
            set s__PagedButtons_SlotType_2startDelayDone[this-8191]= false
        elseif(this<32764) then
            if(this<24573) then
                set s__PagedButtons_SlotType_3replenish[this-16382]= true
                set s__PagedButtons_SlotType_3startDelayDone[this-16382]= false
            else
                set s__PagedButtons_SlotType_4replenish[this-24573]= true
                set s__PagedButtons_SlotType_4startDelayDone[this-24573]= false
            endif
        elseif(this<40955) then
            set s__PagedButtons_SlotType_5replenish[this-32764]= true
            set s__PagedButtons_SlotType_5startDelayDone[this-32764]= false
        elseif(this<49146) then
            set s__PagedButtons_SlotType_6replenish[this-40955]= true
            set s__PagedButtons_SlotType_6startDelayDone[this-40955]= false
        else
            set s__PagedButtons_SlotType_7replenish[this-49146]= true
            set s__PagedButtons_SlotType_7startDelayDone[this-49146]= false
        endif
    elseif(this<65528) then
        set s__PagedButtons_SlotType_8replenish[this-57337]= true
        set s__PagedButtons_SlotType_8startDelayDone[this-57337]= false
    elseif(this<81910) then
        if(this<73719) then
            set s__PagedButtons_SlotType_9replenish[this-65528]= true
            set s__PagedButtons_SlotType_9startDelayDone[this-65528]= false
        else
            set s__PagedButtons_SlotType_10replenish[this-73719]= true
            set s__PagedButtons_SlotType_10startDelayDone[this-73719]= false
        endif
    elseif(this<90101) then
        set s__PagedButtons_SlotType_11replenish[this-81910]= true
        set s__PagedButtons_SlotType_11startDelayDone[this-81910]= false
    elseif(this<98292) then
        set s__PagedButtons_SlotType_12replenish[this-90101]= true
        set s__PagedButtons_SlotType_12startDelayDone[this-90101]= false
    else
        set s__PagedButtons_SlotType_13replenish[this-98292]= true
        set s__PagedButtons_SlotType_13startDelayDone[this-98292]= false
    endif
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
    if(this<8191) then
        set si__PagedButtons_Type_type[this]=2
    elseif(this<57337) then
        if(this<16382) then
            set si__PagedButtons_Type_2type[this-8191]=2
        elseif(this<32764) then
            if(this<24573) then
                set si__PagedButtons_Type_3type[this-16382]=2
            else
                set si__PagedButtons_Type_4type[this-24573]=2
            endif
        elseif(this<40955) then
            set si__PagedButtons_Type_5type[this-32764]=2
        elseif(this<49146) then
            set si__PagedButtons_Type_6type[this-40955]=2
        else
            set si__PagedButtons_Type_7type[this-49146]=2
        endif
    elseif(this<65528) then
        set si__PagedButtons_Type_8type[this-57337]=2
    elseif(this<81910) then
        if(this<73719) then
            set si__PagedButtons_Type_9type[this-65528]=2
        else
            set si__PagedButtons_Type_10type[this-73719]=2
        endif
    elseif(this<90101) then
        set si__PagedButtons_Type_11type[this-81910]=2
    elseif(this<98292) then
        set si__PagedButtons_Type_12type[this-90101]=2
    else
        set si__PagedButtons_Type_13type[this-98292]=2
    endif
    set kthis=this

 return this
endfunction

function sc___prototype22_execute takes integer i,unit a1 returns nothing
    set f__arg_unit1=a1

    call TriggerExecute(st___prototype22[i])
endfunction
function sc___prototype22_evaluate takes integer i,unit a1 returns boolean
    set f__arg_unit1=a1

    call TriggerEvaluate(st___prototype22[i])
 return f__result_boolean
endfunction
function sc___prototype51_execute takes integer i,integer a1,unit a2 returns nothing
    set f__arg_integer1=a1
    set f__arg_unit1=a2

    call TriggerExecute(st___prototype51[i])
endfunction
function sc___prototype51_evaluate takes integer i,integer a1,unit a2 returns integer
    set f__arg_integer1=a1
    set f__arg_unit1=a2

    call TriggerEvaluate(st___prototype51[i])
 return f__result_integer
endfunction
function h__RemoveUnit takes unit a0 returns nothing
    //hook: DisablePagedButtons
    call sc___prototype22_evaluate(1,a0)
    //hook: DisableItemCraftingUnit
    call sc___prototype22_evaluate(2,a0)
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
//library FrameSaver:


function FrameSaverAdd takes code func returns nothing
    call TriggerAddAction(FrameSaver__saveTrigger, func)
endfunction

function FrameSaverAddEx takes code func,code func2 returns nothing
    call TriggerAddAction(FrameSaver__saveTrigger, (func)) // INLINED!!
    call TriggerAddAction(FrameSaver__afterSaveTrigger, func2)
endfunction

function FrameSaver__TimerFunctionAfterSave takes nothing returns nothing
    call TriggerExecute(FrameSaver__afterSaveTrigger)
endfunction

function FrameSaver__TriggerActionStartAfterSaveTimer takes nothing returns nothing
    call TimerStart(FrameSaver__t, FrameSaver__DELAY, false, function FrameSaver__TimerFunctionAfterSave)
endfunction

function FrameSaver__TriggerActionCancelAfterSaveTimer takes nothing returns nothing
    call PauseTimer(FrameSaver__t)
endfunction

function FrameSaver__Init takes nothing returns nothing
    call TriggerRegisterGameEvent(FrameSaver__saveTrigger, EVENT_GAME_SAVE)
    call TriggerAddAction(FrameSaver__saveTrigger, function FrameSaver__TriggerActionStartAfterSaveTimer)
    
    call TriggerRegisterGameEvent(FrameSaver__loadTrigger, EVENT_GAME_LOADED)
    call TriggerAddAction(FrameSaver__loadTrigger, function FrameSaver__TriggerActionCancelAfterSaveTimer)
endfunction


//library FrameSaver ends
//library ItemTypeUtils:


// https://www.hiveworkshop.com/threads/detecting-item-price.120355/

// This is the x position where we create the dummy units. Dont place it in the water.
function ItemTypeUtils__GetShopDummyX takes nothing returns real
    return GetRectCenterX(gg_rct_Shop_Dummy)
endfunction

// This is the y position where we create the dummy units. Dont place it in the water.
function ItemTypeUtils__GetShopDummyY takes nothing returns real
    return GetRectCenterY(gg_rct_Shop_Dummy)
endfunction

function GetItemValueGoldFresh takes integer i returns integer
    local real x= (GetRectCenterX(gg_rct_Shop_Dummy)) // INLINED!!
    local real y= (GetRectCenterY(gg_rct_Shop_Dummy)) // INLINED!!
    local unit u1= CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), ItemTypeUtils__SHOP, x, y, 0)
    local unit u2= CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), ItemTypeUtils__SELL_UNIT, x, y - 100, 90)
    local item a= UnitAddItemByIdSwapped(i, u2)
    local integer g1= GetPlayerState(Player(PLAYER_NEUTRAL_PASSIVE), PLAYER_STATE_RESOURCE_GOLD)
    local integer g2= 0
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
    if ( not HaveSavedInteger(ItemTypeUtils__h, i, 0) ) then
        call SaveInteger(ItemTypeUtils__h, i, 0, GetItemValueGoldFresh(i))
    endif
    return LoadInteger(ItemTypeUtils__h, i, 0)
endfunction

function GetItemValueLumberFresh takes integer i returns integer
    local real x= (GetRectCenterX(gg_rct_Shop_Dummy)) // INLINED!!
    local real y= (GetRectCenterY(gg_rct_Shop_Dummy)) // INLINED!!
    local unit u1= CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), ItemTypeUtils__SHOP, x, y, 0)
    local unit u2= CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), ItemTypeUtils__SELL_UNIT, x, y - 100, 90)
    local item a= UnitAddItemByIdSwapped(i, u2)
    local integer g1= GetPlayerState(Player(PLAYER_NEUTRAL_PASSIVE), PLAYER_STATE_RESOURCE_LUMBER)
    local integer g2= 0
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
    if ( not HaveSavedInteger(ItemTypeUtils__h, i, 1) ) then
        call SaveInteger(ItemTypeUtils__h, i, 1, GetItemValueLumberFresh(i))
    endif
    return LoadInteger(ItemTypeUtils__h, i, 1)
endfunction

function GetItemTypePerishableFresh takes integer i returns boolean
    local item tmpItem= CreateItem(i, 0.0, 0.0)
    local boolean result= BlzGetItemBooleanField(tmpItem, ITEM_BF_PERISHABLE)
    call RemoveItem(tmpItem)
    set tmpItem=null

    return result
endfunction

function GetItemTypePerishable takes integer i returns boolean
    if ( not HaveSavedBoolean(ItemTypeUtils__h, i, 2) ) then
        call SaveBoolean(ItemTypeUtils__h, i, 2, GetItemTypePerishableFresh(i))
    endif
    return LoadBoolean(ItemTypeUtils__h, i, 2)
endfunction

function GetItemTypeModelFresh takes integer i returns string
    local item tmpItem= CreateItem(i, 0.0, 0.0)
    local string result= BlzGetItemStringField(tmpItem, ITEM_SF_MODEL_USED)
    call RemoveItem(tmpItem)
    set tmpItem=null

    return result
endfunction

function GetItemTypeModel takes integer i returns string
    if ( not HaveSavedBoolean(ItemTypeUtils__h, i, 3) ) then
        call SaveStr(ItemTypeUtils__h, i, 3, GetItemTypeModelFresh(i))
    endif
    return LoadStr(ItemTypeUtils__h, i, 3)
endfunction


//library ItemTypeUtils ends
//library OpLimit:

function NewOpLimit takes code callback returns nothing
    call ForForce(bj_FORCE_PLAYER[0], callback)
endfunction


//library OpLimit ends
//library PagedButtons:



function GetAutoUpdateStockTimerHandleId takes nothing returns integer
    return GetHandleId(PagedButtons__autoUpdateStockTimer)
endfunction

function GetTriggerShop takes nothing returns unit
    return PagedButtons__triggerShop
endfunction

function GetTriggerPreviousPage takes nothing returns integer
    return PagedButtons__triggerPreviousPage
endfunction

function GetTriggerAvailableObject takes nothing returns integer
    return PagedButtons__triggerAvailableObject
endfunction

function TriggerRegisterChangePagedButtons takes trigger whichTrigger returns nothing
    set PagedButtons__callbackTriggersChangePageButtons[PagedButtons__callbackTriggersChangePageButtonsCounter]=whichTrigger
    set PagedButtons__callbackTriggersChangePageButtonsCounter=PagedButtons__callbackTriggersChangePageButtonsCounter + 1
endfunction

function TriggerRegisterObjectAvailable takes trigger whichTrigger returns nothing
    set PagedButtons__callbackTriggersObjectAvailable[PagedButtons__callbackTriggersObjectAvailableCounter]=whichTrigger
    set PagedButtons__callbackTriggersObjectAvailableCounter=PagedButtons__callbackTriggersObjectAvailableCounter + 1
endfunction

function PagedButtons__ExecuteChangedPageButtonsCallbacks takes unit shop,integer previousPage returns nothing
    local integer i= 0
    set PagedButtons__triggerShop=shop
    set PagedButtons__triggerPreviousPage=previousPage
    set i=0
    loop
        exitwhen ( i == PagedButtons__callbackTriggersChangePageButtonsCounter )
        if ( IsTriggerEnabled(PagedButtons__callbackTriggersChangePageButtons[i]) ) then
            call ConditionalTriggerExecute(PagedButtons__callbackTriggersChangePageButtons[i])
        endif
        set i=i + 1
    endloop
endfunction

function PagedButtons__ExecuteObjectAvailableCallbacks takes unit shop,integer objectId returns nothing
    local integer i= 0
    set PagedButtons__triggerShop=shop
    set PagedButtons__triggerAvailableObject=objectId
    set i=0
    loop
        exitwhen ( i == PagedButtons__callbackTriggersObjectAvailableCounter )
        if ( IsTriggerEnabled(PagedButtons__callbackTriggersObjectAvailable[i]) ) then
            call ConditionalTriggerExecute(PagedButtons__callbackTriggersObjectAvailable[i])
        endif
        set i=i + 1
    endloop
endfunction

    
    function s__PagedButtons_Type_isSpacer takes integer this returns boolean
        return sg__PagedButtons_Type_get_whichType(this) == PagedButtons_BUTTON_TYPE_SPACER
    endfunction
    

// Use a separate type for spacers to save memory.

    function s__PagedButtons_SpacerType_create takes nothing returns integer
        local integer this= s__PagedButtons_SpacerType__allocate()
        call sg__PagedButtons_Type_set_whichType(this,PagedButtons_BUTTON_TYPE_SPACER)
        return this
    endfunction
    
    function s__PagedButtons_SpacerType_onDestroy takes integer this returns nothing
    endfunction

    

    function s__PagedButtons_SlotType_create takes unit shop,integer id,integer whichType,integer currentStock,integer startStock,integer maxStock,integer startDelay,integer replenishInterval returns integer
        local integer this= s__PagedButtons_SlotType__allocate()
        call sg__PagedButtons_SlotType_set_shop(this,shop)
        call sg__PagedButtons_SlotType_set_id(this,id)
        call sg__PagedButtons_Type_set_whichType(this,whichType)
        call sg__PagedButtons_SlotType_set_currentStock(this,currentStock)
        call sg__PagedButtons_SlotType_set_startStock(this,startStock)
        call sg__PagedButtons_SlotType_set_maxStock(this,maxStock)
        call sg__PagedButtons_SlotType_set_startDelay(this,startDelay)
        call sg__PagedButtons_SlotType_set_replenishInterval(this,replenishInterval)
        call sg__PagedButtons_SlotType_set_elapsedTimeStartDelay(this,0)
        call sg__PagedButtons_SlotType_set_elapsedTimeReplenishInterval(this,0)
        
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
            if ( sg__PagedButtons_SlotType_get_replenish(this) ) then
                set updated=false
                
                if ( not sg__PagedButtons_SlotType_get_startDelayDone(this) ) then
                    call sg__PagedButtons_SlotType_set_elapsedTimeStartDelay(this,sg__PagedButtons_SlotType_get_elapsedTimeStartDelay(this) + elapsedSeconds)
                    if ( sg__PagedButtons_SlotType_get_elapsedTimeStartDelay(this) >= sg__PagedButtons_SlotType_get_startDelay(this) ) then
                        if ( sg__PagedButtons_SlotType_get_currentStock(this) < sg__PagedButtons_SlotType_get_maxStock(this) ) then
                            call sg__PagedButtons_SlotType_set_currentStock(this,sg__PagedButtons_SlotType_get_currentStock(this) + 1)
                            set updated=true
                        endif
                        call sg__PagedButtons_SlotType_set_elapsedTimeStartDelay(this,0)
                        call sg__PagedButtons_SlotType_set_startDelayDone(this,true)
                    endif
                endif
                
                if ( sg__PagedButtons_SlotType_get_currentStock(this) < sg__PagedButtons_SlotType_get_maxStock(this) ) then
                    call sg__PagedButtons_SlotType_set_elapsedTimeReplenishInterval(this,sg__PagedButtons_SlotType_get_elapsedTimeReplenishInterval(this) + elapsedSeconds)
                    //if (this.id == BOOTS_OF_SPEED) then
                    //    call BJDebugMsg("Elapsed seconds for " + GetObjectName(this.id) + " - " + I2S(elapsedSeconds) + " resulting in total elapsed: " + I2S(this.elapsedTimeReplenishInterval))
                    //endif
                    if ( sg__PagedButtons_SlotType_get_elapsedTimeReplenishInterval(this) >= sg__PagedButtons_SlotType_get_replenishInterval(this) ) then
                        if ( sg__PagedButtons_SlotType_get_currentStock(this) < sg__PagedButtons_SlotType_get_maxStock(this) ) then
                            call sg__PagedButtons_SlotType_set_currentStock(this,sg__PagedButtons_SlotType_get_currentStock(this) + 1)
                            set updated=true
                        endif
                        call sg__PagedButtons_SlotType_set_elapsedTimeReplenishInterval(this,0)
                    endif
                endif
                if ( updated ) then
                    if ( sg__PagedButtons_Type_get_shown(this) and sg__PagedButtons_Type_get_enabled(this) ) then
                        if ( sg__PagedButtons_Type_get_whichType(this) == PagedButtons_BUTTON_TYPE_UNIT ) then
                            // TODO Removes different unit when the stock is still in delay.
                            call AddUnitToStock(sg__PagedButtons_SlotType_get_shop(this), sg__PagedButtons_SlotType_get_id(this), sg__PagedButtons_SlotType_get_currentStock(this), sg__PagedButtons_SlotType_get_maxStock(this))
                        elseif ( sg__PagedButtons_Type_get_whichType(this) == PagedButtons_BUTTON_TYPE_ITEM ) then
                            // TODO Removes different item when the stock is still in delay.
                            //call BJDebugMsg("Making item available again: " + GetObjectName(this.id))
                            call AddItemToStock(sg__PagedButtons_SlotType_get_shop(this), sg__PagedButtons_SlotType_get_id(this), sg__PagedButtons_SlotType_get_currentStock(this), sg__PagedButtons_SlotType_get_maxStock(this))
                        else
                            // Do nothing for abilities.
                        endif
                    endif
                    
                    call PagedButtons__ExecuteObjectAvailableCallbacks(sg__PagedButtons_SlotType_get_shop(this) , sg__PagedButtons_SlotType_get_id(this))
                endif
            endif
            set i=i + 1
        endloop
    endfunction



    
    function s__PagedButtons_Shop_removeButton takes integer this,integer index returns nothing
        loop
            exitwhen ( index >= sg__PagedButtons_Shop_get_buttonsCount(this) )
            call sg___PagedButtons_Shop_buttons_set(sg__PagedButtons_Shop_get_buttons(this)+index,sg___PagedButtons_Shop_buttons_get(sg__PagedButtons_Shop_get_buttons(this)+index + 1))
            call sg___PagedButtons_Shop_buttons_set(sg__PagedButtons_Shop_get_buttons(this)+index + 1,0)
            set index=index + 1
        endloop
        call sg__PagedButtons_Shop_set_buttonsCount(this,sg__PagedButtons_Shop_get_buttonsCount(this) - 1)
    endfunction
    
    function s__PagedButtons_Shop_create takes string name returns integer
        local integer this= s__PagedButtons_Shop__allocate()
        call sg__PagedButtons_Shop_set_name(this,name)
        return this
    endfunction
    

function GetPagedButtonsShop takes unit shop returns integer
    return LoadInteger(PagedButtons__h, GetHandleId(shop), 0)
endfunction

function SetPagedButtonsShop takes unit shop,integer s returns nothing
    call SaveInteger(PagedButtons__h, GetHandleId(shop), 0, s)
endfunction

function GetPagedButtonsCount takes unit shop returns integer
    local integer s= (LoadInteger(PagedButtons__h, GetHandleId((shop)), 0)) // INLINED!!
    if ( s != 0 ) then
        return sg__PagedButtons_Shop_get_buttonsCount(s)
    endif
    return 0
endfunction

function GetPagedButtonsNonSpacerButtonsCount takes unit shop returns integer
    local integer x= (LoadInteger(PagedButtons__h, GetHandleId((shop)), 0)) // INLINED!!
    local integer result= 0
    local integer t= 0
    local integer i= 0
    loop
        exitwhen ( i >= sg__PagedButtons_Shop_get_buttonsCount(x) )
        set t=sg___PagedButtons_Shop_buttons_get(sg__PagedButtons_Shop_get_buttons(x)+i)
        if ( not (sg__PagedButtons_Type_get_whichType((t)) == PagedButtons_BUTTON_TYPE_SPACER) ) then // INLINED!!
            set result=result + 1
        endif
        set i=i + 1
    endloop
    return result
endfunction

function GetPagedButton takes unit shop,integer index returns integer
    local integer x= (LoadInteger(PagedButtons__h, GetHandleId((shop)), 0)) // INLINED!!
    
    return sg___PagedButtons_Shop_buttons_get(sg__PagedButtons_Shop_get_buttons(x)+index)
endfunction

function GetPagedButtonIndex takes unit shop,integer id returns integer
    local integer x= (LoadInteger(PagedButtons__h, GetHandleId((shop)), 0)) // INLINED!!
    local integer t= 0
    local integer s= 0
    local integer i= 0
    loop
        exitwhen ( i >= sg__PagedButtons_Shop_get_buttonsCount(x) )
        set t=sg___PagedButtons_Shop_buttons_get(sg__PagedButtons_Shop_get_buttons(x)+i)
        if ( not (sg__PagedButtons_Type_get_whichType((t)) == PagedButtons_BUTTON_TYPE_SPACER) ) then // INLINED!!
            set s=(t)
            if ( sg__PagedButtons_SlotType_get_id(s) == id ) then
                return i
            endif
        endif
        set i=i + 1
    endloop
    return - 1
endfunction

function GetPagedButtonIndexEx takes unit shop,integer id,integer index returns integer
    local integer x= (LoadInteger(PagedButtons__h, GetHandleId((shop)), 0)) // INLINED!!
    local integer t= 0
    local integer s= 0
    local integer i= 0
    local integer currentIndex= 0
    loop
        exitwhen ( i >= sg__PagedButtons_Shop_get_buttonsCount(x) )
        set t=sg___PagedButtons_Shop_buttons_get(sg__PagedButtons_Shop_get_buttons(x)+i)
        if ( not (sg__PagedButtons_Type_get_whichType((t)) == PagedButtons_BUTTON_TYPE_SPACER) ) then // INLINED!!
            set s=(t)
            if ( sg__PagedButtons_SlotType_get_id(s) == id ) then
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
    local integer x= (LoadInteger(PagedButtons__h, GetHandleId((shop)), 0)) // INLINED!!
    local integer t= 0
    local integer s= 0
    local integer i= 0
    local integer count= 0
    loop
        exitwhen ( i >= sg__PagedButtons_Shop_get_buttonsCount(x) )
        set t=sg___PagedButtons_Shop_buttons_get(sg__PagedButtons_Shop_get_buttons(x)+i)
        if ( not (sg__PagedButtons_Type_get_whichType((t)) == PagedButtons_BUTTON_TYPE_SPACER) ) then // INLINED!!
            set s=(t)
            if ( sg__PagedButtons_SlotType_get_id(s) == id ) then
                set count=count + 1
            endif
        endif
        set i=i + 1
    endloop
    return count
endfunction

function IsPagedButtonShown takes unit shop,integer index returns boolean
    return sg__PagedButtons_Type_get_shown(GetPagedButton(shop , index))
endfunction

function IsPagedButtonEnabled takes unit shop,integer index returns boolean
    return sg__PagedButtons_Type_get_enabled(GetPagedButton(shop , index))
endfunction

function GetPagedButtonId takes unit shop,integer index returns integer
    if ( GetPagedButton(shop , index) == 0 ) then
        return 0
    endif
    return sg__PagedButtons_SlotType_get_id((GetPagedButton(shop , index)))
endfunction

function IsPagedButtonUnit takes unit shop,integer index returns boolean
    return sg__PagedButtons_Type_get_whichType(GetPagedButton(shop , index)) == PagedButtons_BUTTON_TYPE_UNIT
endfunction

function IsPagedButtonItem takes unit shop,integer index returns boolean
    return sg__PagedButtons_Type_get_whichType(GetPagedButton(shop , index)) == PagedButtons_BUTTON_TYPE_ITEM
endfunction

function IsPagedButtonAbility takes unit shop,integer index returns boolean
    return sg__PagedButtons_Type_get_whichType(GetPagedButton(shop , index)) == PagedButtons_BUTTON_TYPE_ABILITY
endfunction

function IsPagedButtonSpacer takes unit shop,integer index returns boolean
    return sg__PagedButtons_Type_get_whichType(GetPagedButton(shop , index)) == PagedButtons_BUTTON_TYPE_SPACER
endfunction

function GetPagedButtonType takes unit shop,integer id returns integer
    local integer x= (LoadInteger(PagedButtons__h, GetHandleId((shop)), 0)) // INLINED!!
    local integer result= 0
    local integer t= 0
    local integer s= 0
    local integer i= 0
    loop
        exitwhen ( i >= sg__PagedButtons_Shop_get_buttonsCount(x) or result != 0 )
        set t=sg___PagedButtons_Shop_buttons_get(sg__PagedButtons_Shop_get_buttons(x)+i)
        if ( not (sg__PagedButtons_Type_get_whichType((t)) == PagedButtons_BUTTON_TYPE_SPACER) ) then // INLINED!!
            set s=(t)
            if ( sg__PagedButtons_SlotType_get_id(s) == id ) then
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
        return sg__PagedButtons_Type_get_whichType(s) == PagedButtons_BUTTON_TYPE_UNIT
    endif
    return false
endfunction

function GetPagedButtonsSlotsPerPage takes unit shop returns integer
    local integer s= (LoadInteger(PagedButtons__h, GetHandleId((shop)), 0)) // INLINED!!
    if ( s != 0 ) then
        return sg__PagedButtons_Shop_get_slotsPerPage(s)
    endif
    return 0
endfunction

function GetPagedButtonsPage takes unit shop returns integer
    local integer s= (LoadInteger(PagedButtons__h, GetHandleId((shop)), 0)) // INLINED!!
    if ( s != 0 ) then
        return sg__PagedButtons_Shop_get_currentPage(s)
    endif
    return 0
endfunction

function GetPagedButtonsMaxPages takes unit shop returns integer
    local integer s= (LoadInteger(PagedButtons__h, GetHandleId((shop)), 0)) // INLINED!!
    if ( s != 0 ) then
        return sg__PagedButtons_Shop_get_maxPages(s)
    endif
    return 0
endfunction

function GetPagedButtonsShopPage takes unit shop,integer page returns integer
    local integer s= (LoadInteger(PagedButtons__h, GetHandleId((shop)), 0)) // INLINED!!
    if ( s != 0 and page >= 0 and page < sg__PagedButtons_Shop_get_maxPages(s) ) then
        return sg___PagedButtons_Shop_pages_get(sg__PagedButtons_Shop_get_pages(s)+page)
    endif
    return 0
endfunction

function PagedButtons__PrintPages takes unit shop returns nothing
    local integer s= (LoadInteger(PagedButtons__h, GetHandleId((shop)), 0)) // INLINED!!
    local integer p= 0
    local integer i= 0
    if ( s != 0 ) then
        //call BJDebugMsg("Pages count: " + I2S(s.maxPages))
        loop
            exitwhen ( i >= sg__PagedButtons_Shop_get_maxPages(s) )
            set p=sg___PagedButtons_Shop_pages_get(sg__PagedButtons_Shop_get_pages(s)+i)
            //call BJDebugMsg("Page name: " + p.name)
            set i=i + 1
        endloop
    endif
endfunction

function GetPagedButtonsPageName takes unit shop,integer page returns string
    local integer p= GetPagedButtonsShopPage(shop , page)
    if ( p != 0 ) then
        //call BJDebugMsg("Shop " + GetUnitName(shop) + " page name of page " + I2S(page) + ": " + p.name)
        return sg__PagedButtons_Page_get_name(p)
    endif
    //call BJDebugMsg("Shop "  + GetUnitName(shop) + " page name of page " + I2S(page) + " is not set.")
    return null
endfunction

function SetPagedButtonsPageName takes unit shop,integer page,string name returns nothing
    local integer p= GetPagedButtonsShopPage(shop , page)
    if ( p != 0 ) then
        call sg__PagedButtons_Page_set_name(p,name)
    endif
    //call PrintPages(shop)
endfunction

function SetPagedButtonsCurrentPageName takes unit shop,string name returns nothing
    call SetPagedButtonsPageName(shop , GetPagedButtonsPage(shop) , name)
endfunction

function PagedButtons__ChangeShopUnitName takes unit shop returns nothing
    local integer s= (LoadInteger(PagedButtons__h, GetHandleId((shop)), 0)) // INLINED!!
    local integer currentPage= GetPagedButtonsPage(shop)
    local string pageName= GetPagedButtonsPageName(shop , sg__PagedButtons_Shop_get_currentPage(s))
    local string unitName= sg__PagedButtons_Shop_get_name(s)
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

function PagedButtons__ResetShopUnitName takes unit shop returns nothing
     local integer s= (LoadInteger(PagedButtons__h, GetHandleId((shop)), 0)) // INLINED!!
    local string unitName= sg__PagedButtons_Shop_get_name(s)
    if ( unitName == null ) then
        set unitName=""
    endif
    call BlzSetUnitName(shop, unitName)
endfunction

function PagedButtons__HidePagedButtonsCurrentPage takes unit shop returns nothing
    local integer x= (LoadInteger(PagedButtons__h, GetHandleId((shop)), 0)) // INLINED!!
    local integer maxPages= sg__PagedButtons_Shop_get_maxPages(x)
    local integer totalCounter= sg__PagedButtons_Shop_get_buttonsCount(x)
    local integer countUnits= 0
    local integer countItems= 0
    local integer slotsPerPage= sg__PagedButtons_Shop_get_slotsPerPage(x)
    local integer currentPage= sg__PagedButtons_Shop_get_currentPage(x)
    local integer i= currentPage * slotsPerPage
    local integer count= i + IMinBJ(slotsPerPage, totalCounter - currentPage * slotsPerPage)
    local integer t= GetPagedButton(shop , i)
    local integer s= 0
    loop
        exitwhen ( i >= count )
        set t=sg___PagedButtons_Shop_buttons_get(sg__PagedButtons_Shop_get_buttons(x)+i)
        if ( not (sg__PagedButtons_Type_get_whichType((t)) == PagedButtons_BUTTON_TYPE_SPACER) and sg__PagedButtons_Type_get_enabled(t) ) then // INLINED!!
            set s=(t)
            if ( sg__PagedButtons_Type_get_whichType(s) == PagedButtons_BUTTON_TYPE_UNIT ) then
                call RemoveUnitFromStock(shop, sg__PagedButtons_SlotType_get_id(s))
            elseif ( sg__PagedButtons_Type_get_whichType(s) == PagedButtons_BUTTON_TYPE_ITEM ) then
                call RemoveItemFromStock(shop, sg__PagedButtons_SlotType_get_id(s))
            else
                call UnitRemoveAbility(shop, sg__PagedButtons_SlotType_get_id(s))
            endif
        endif
        call sg__PagedButtons_Type_set_shown(t,false)
        set i=i + 1
    endloop
    call SetUnitTypeSlots(shop, 0)
    call SetItemTypeSlots(shop, 0)
endfunction

function PagedButtons__ShowPagedButtonsCurrentPage takes unit shop returns nothing
    local integer x= (LoadInteger(PagedButtons__h, GetHandleId((shop)), 0)) // INLINED!!
    local integer maxPages= sg__PagedButtons_Shop_get_maxPages(x)
    local integer currentPage= sg__PagedButtons_Shop_get_currentPage(x)
    local integer totalCounter= sg__PagedButtons_Shop_get_buttonsCount(x)
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
        set t=sg___PagedButtons_Shop_buttons_get(sg__PagedButtons_Shop_get_buttons(x)+i)
        //call BJDebugMsg("Checking instance " + I2S(t))
        if ( not (sg__PagedButtons_Type_get_whichType((t)) == PagedButtons_BUTTON_TYPE_SPACER) and sg__PagedButtons_Type_get_enabled(t) ) then // INLINED!!
            set s=(t)
            //call BJDebugMsg("Adding "  + GetObjectName(s.id))
            if ( sg__PagedButtons_Type_get_whichType(s) == PagedButtons_BUTTON_TYPE_UNIT ) then
                set countUnits=countUnits + 1
                call SetUnitTypeSlots(shop, countUnits)
                call AddUnitToStock(shop, sg__PagedButtons_SlotType_get_id(s), sg__PagedButtons_SlotType_get_currentStock(s), sg__PagedButtons_SlotType_get_maxStock(s))
            elseif ( sg__PagedButtons_Type_get_whichType(s) == PagedButtons_BUTTON_TYPE_ITEM ) then
                set countItems=countItems + 1
                call SetItemTypeSlots(shop, countItems)
                call AddItemToStock(shop, sg__PagedButtons_SlotType_get_id(s), sg__PagedButtons_SlotType_get_currentStock(s), sg__PagedButtons_SlotType_get_maxStock(s))
            else
                call UnitAddAbility(shop, sg__PagedButtons_SlotType_get_id(s))
            endif
        else
            //call BJDebugMsg("Not enabled or spacer.")
        endif
        call sg__PagedButtons_Type_set_shown(t,true)
        set i=i + 1
    endloop

    call PagedButtons__ChangeShopUnitName(shop)


// show the page buttons afterwards to make sure that they have a higher priority than the unit buttons
if ( not PagedButtons_HIDE_PAGE_BUTTONS_FOR_ONE_PAGE or maxPages > 1 ) then




    call AddUnitToStock(shop, PagedButtons_NEXT_PAGE_ID, nextPage, nextPage)
    call AddUnitToStock(shop, PagedButtons_PREVIOUS_PAGE_ID, previousPage, previousPage)

endif
endfunction

function SetPagedButtonsPage takes unit shop,integer page returns nothing
    local integer s= (LoadInteger(PagedButtons__h, GetHandleId((shop)), 0)) // INLINED!!
    local integer currentPage= sg__PagedButtons_Shop_get_currentPage(s)
    call PagedButtons__HidePagedButtonsCurrentPage(shop)
    call sg__PagedButtons_Shop_set_currentPage(s,page)
    call PagedButtons__ShowPagedButtonsCurrentPage(shop)

    call PagedButtons__ChangeShopUnitName(shop)

    call PagedButtons__ExecuteChangedPageButtonsCallbacks(shop , currentPage)
endfunction

function SetPagedButtonEnabled takes unit shop,integer index,boolean enabled returns nothing
    call sg__PagedButtons_Type_set_enabled(GetPagedButton(shop , index),enabled)
    // refresh
    call SetPagedButtonsPage(shop , GetPagedButtonsPage(shop))
endfunction

function PagedButtons__RefreshMaxPagesEx takes unit shop,integer maxPages returns nothing
    local integer s= (LoadInteger(PagedButtons__h, GetHandleId((shop)), 0)) // INLINED!!
    local integer oldMaxPages= sg__PagedButtons_Shop_get_maxPages(s)
    local integer i= 0
    call sg__PagedButtons_Shop_set_maxPages(s,maxPages)
    // create all missing pages instances
    if ( maxPages > oldMaxPages ) then
        set i=oldMaxPages
        loop
            exitwhen ( i >= maxPages )
            if ( sg___PagedButtons_Shop_pages_get(sg__PagedButtons_Shop_get_pages(s)+i) == 0 ) then
                call sg___PagedButtons_Shop_pages_set(sg__PagedButtons_Shop_get_pages(s)+i,s__PagedButtons_Page__allocate())
                if ( i > 0 ) then
                    call sg__PagedButtons_Page_set_name(sg___PagedButtons_Shop_pages_get(sg__PagedButtons_Shop_get_pages(s)+i),sg__PagedButtons_Page_get_name(sg___PagedButtons_Shop_pages_get(sg__PagedButtons_Shop_get_pages(s)+i - 1))) // copy the previous page name
                endif
            endif
            set i=i + 1
        endloop
    // remove too many pages instances
    elseif ( maxPages < oldMaxPages ) then
        set i=oldMaxPages
        loop
            exitwhen ( i < maxPages )
            if ( sg___PagedButtons_Shop_pages_get(sg__PagedButtons_Shop_get_pages(s)+i) == 0 ) then
                call sg___PagedButtons_Shop_pages_set(sg__PagedButtons_Shop_get_pages(s)+i,0)
                call s__PagedButtons_Page_deallocate(sg___PagedButtons_Shop_pages_get(sg__PagedButtons_Shop_get_pages(s)+i))
            endif
            set i=i - 1
        endloop
    endif
endfunction

function PagedButtons__RefreshMaxPages takes unit shop returns nothing
    local integer s= (LoadInteger(PagedButtons__h, GetHandleId((shop)), 0)) // INLINED!!
    local integer count= sg__PagedButtons_Shop_get_buttonsCount(s)
    local integer slots= sg__PagedButtons_Shop_get_slotsPerPage(s)
    local integer maxPages= count / slots
    if ( ModuloInteger(count, slots) > 0 ) then
        set maxPages=maxPages + 1
    endif
    set maxPages=IMaxBJ(maxPages, 1)
    call PagedButtons__RefreshMaxPagesEx(shop , maxPages)
endfunction

function RemovePagedButtonsIndex takes unit shop,integer index returns boolean
    local integer s= (LoadInteger(PagedButtons__h, GetHandleId((shop)), 0)) // INLINED!!
    local integer t= 0
    if ( s != 0 and index >= 0 and index <= sg__PagedButtons_Shop_get_buttonsCount(s) ) then
        set t=sg___PagedButtons_Shop_buttons_get(sg__PagedButtons_Shop_get_buttons(s)+index)
        if ( sg__PagedButtons_Type_get_shown(t) ) then
            if ( sg__PagedButtons_Type_get_whichType(t) == PagedButtons_BUTTON_TYPE_UNIT ) then
                call RemoveUnitFromStock(shop, sg__PagedButtons_SlotType_get_id((t)))
            elseif ( sg__PagedButtons_Type_get_whichType(t) == PagedButtons_BUTTON_TYPE_ITEM ) then
                call RemoveItemFromStock(shop, sg__PagedButtons_SlotType_get_id((t)))
            elseif ( sg__PagedButtons_Type_get_whichType(t) == PagedButtons_BUTTON_TYPE_ITEM ) then
                call UnitRemoveAbility(shop, sg__PagedButtons_SlotType_get_id((t)))
            endif
        endif
    
        call s__PagedButtons_Shop_removeButton(s,index)
        call sc__PagedButtons_Type_deallocate(t)
        
        // update buttons
        call PagedButtons__RefreshMaxPages(shop)
        call SetPagedButtonsPage(shop , IMaxBJ(0, IMinBJ(GetPagedButtonsPage(shop), sg__PagedButtons_Shop_get_maxPages(s) - 1)))
        
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
    local integer s= (LoadInteger(PagedButtons__h, GetHandleId((shop)), 0)) // INLINED!!
    call sg__PagedButtons_Shop_set_slotsPerPage(s,slots)
    call PagedButtons__RefreshMaxPages(shop)
    call SetPagedButtonsPage(shop , GetPagedButtonsPage(shop))
endfunction

function PagedButtons__AddPageButtonsIdType takes unit shop,integer id,integer whichType returns integer
    local integer startStock= 1
    local integer currentStock= 1
    local integer maxStock= 1
    local integer startDelay= 0
    local integer replenishInterval= 30

















    return s__PagedButtons_SlotType_create(shop , id , whichType , currentStock , startStock , maxStock , startDelay , replenishInterval)
endfunction

function AddPagedButtonsId takes unit shop,integer id,integer whichType returns integer
    local integer s= (LoadInteger(PagedButtons__h, GetHandleId((shop)), 0)) // INLINED!!
    local integer t= 0
    local integer index= 0
    
    if ( s == 0 ) then
        return - 1
    endif
    set index=sg__PagedButtons_Shop_get_buttonsCount(s)
    if ( whichType == PagedButtons_BUTTON_TYPE_SPACER ) then
        set t=s__PagedButtons_SpacerType_create()
    else
        set t=PagedButtons__AddPageButtonsIdType(shop , id , whichType)
    endif
    call sg___PagedButtons_Shop_buttons_set(sg__PagedButtons_Shop_get_buttons(s)+index,t)
    call sg__PagedButtons_Shop_set_buttonsCount(s,index + 1)
    call PagedButtons__RefreshMaxPages(shop)
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
    local integer s= (LoadInteger(PagedButtons__h, GetHandleId((shop)), 0)) // INLINED!!
    if ( s != 0 ) then
        return index / sg__PagedButtons_Shop_get_slotsPerPage(s)
    endif
    return 0
endfunction

function AddPagedButtonsSpacersRemaining takes unit shop returns nothing
    local integer s= (LoadInteger(PagedButtons__h, GetHandleId((shop)), 0)) // INLINED!!
    local integer mod= 0
    if ( s != 0 ) then
        set mod=ModuloInteger(sg__PagedButtons_Shop_get_buttonsCount(s), sg__PagedButtons_Shop_get_slotsPerPage(s))
        if ( mod > 0 ) then
            call AddPagedButtonsSpacers(shop , sg__PagedButtons_Shop_get_slotsPerPage(s) - mod)
        endif
    endif
endfunction

function NextPagedButtonsPage takes unit shop,string name returns integer
    local integer s= (LoadInteger(PagedButtons__h, GetHandleId((shop)), 0)) // INLINED!!
    local integer nextPage= 0
    if ( s != 0 ) then
        // find the next page
        loop
            exitwhen ( nextPage > sg__PagedButtons_Shop_get_maxPages(s) or StringLength(sg__PagedButtons_Page_get_name(sg___PagedButtons_Shop_pages_get(sg__PagedButtons_Shop_get_pages(s)+nextPage))) == 0 )
            set nextPage=nextPage + 1
        endloop
        if ( nextPage > 0 ) then
            //call BJDebugMsg("Adding remaining spacers for page " + I2S(nextPage))
            call AddPagedButtonsSpacersRemaining(shop)
        endif
        call PagedButtons__RefreshMaxPagesEx(shop , nextPage + 1)
        //call BJDebugMsg("Setting name for next page " + I2S(nextPage) + ": " + name)
        call SetPagedButtonsPageName(shop , nextPage , name)
    

        call PagedButtons__ChangeShopUnitName(shop)

    
        //call BJDebugMsg("Set name for next page " + I2S(nextPage) + " to name " + name)
        return nextPage
    endif
    
    return - 1
endfunction

function HasPagedButtons takes unit shop returns boolean
    return IsUnitInGroup(shop, PagedButtons__shops)
endfunction

function EnablePagedButtons takes unit shop returns boolean
    if ( not (IsUnitInGroup((shop), PagedButtons__shops)) ) then // INLINED!!
        call UnitAddAbility(shop, PagedButtons_ABILITY_ID_SELL_UNITS)
        call UnitAddAbility(shop, PagedButtons_ABILITY_ID_SELL_ITEMS)
        call GroupAddUnit(PagedButtons__shops, shop)
        call SaveInteger(PagedButtons__h, GetHandleId((shop )), 0, ( s__PagedButtons_Shop_create(GetUnitName(shop)))) // INLINED!!
        call SetPagedButtonsSlotsPerPage(shop , PagedButtons_SLOTS_PER_PAGE)
        
        return true
    endif
    
    return false
endfunction

function PagedButtons__DestroyPagedButtonsShopTypes takes unit shop returns nothing
    local integer s= (LoadInteger(PagedButtons__h, GetHandleId((shop)), 0)) // INLINED!!
    call s__PagedButtons_Shop_deallocate(s)
endfunction

function DisablePagedButtons takes unit shop returns boolean
    if ( (IsUnitInGroup((shop), PagedButtons__shops)) ) then // INLINED!!

    call PagedButtons__ResetShopUnitName(shop)

        call RemoveUnitFromStock(shop, PagedButtons_NEXT_PAGE_ID)
        call RemoveUnitFromStock(shop, PagedButtons_PREVIOUS_PAGE_ID)
        call GroupRemoveUnit(PagedButtons__shops, shop)
        call PagedButtons__HidePagedButtonsCurrentPage(shop)
        call PagedButtons__DestroyPagedButtonsShopTypes(shop)
        call FlushChildHashtable(PagedButtons__h, GetHandleId(shop))
        
        return true
    endif
    
    return false
endfunction

function ChangePagedButtonsToNextPage takes unit shop returns nothing
    local integer s= (LoadInteger(PagedButtons__h, GetHandleId((shop)), 0)) // INLINED!!
    local integer currentPage= sg__PagedButtons_Shop_get_currentPage(s)
    local integer maxPages= sg__PagedButtons_Shop_get_maxPages(s)
    if ( currentPage == maxPages - 1 ) then
        call SetPagedButtonsPage(shop , 0)
    else
        call SetPagedButtonsPage(shop , currentPage + 1)
    endif
endfunction

function ChangePagedButtonsToPreviousPage takes unit shop returns nothing
    local integer s= (LoadInteger(PagedButtons__h, GetHandleId((shop)), 0)) // INLINED!!
    local integer currentPage= sg__PagedButtons_Shop_get_currentPage(s)
    local integer maxPages= sg__PagedButtons_Shop_get_maxPages(s)
    if ( currentPage == 0 ) then
        call SetPagedButtonsPage(shop , maxPages - 1)
    else
        call SetPagedButtonsPage(shop , currentPage - 1)
    endif
endfunction

function PagedButtons__TriggerConditionDeath takes nothing returns boolean

    call DisablePagedButtons(GetTriggerUnit())

    return false
endfunction

function PagedButtons__TriggerConditionSell takes nothing returns boolean
    return (IsUnitInGroup((GetSellingUnit()), PagedButtons__shops)) // INLINED!!
endfunction

function PagedButtons__DisplayMsg takes unit shop,unit buyingUnit returns nothing
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

function PagedButtons__UpdateStocksById takes unit shop,integer id returns nothing
    local integer s= GetPagedButtonType(shop , id)
    if ( s != 0 ) then
        call sg__PagedButtons_SlotType_set_currentStock(s,IMaxBJ(sg__PagedButtons_SlotType_get_currentStock(s) - 1, 0))
    endif
endfunction

function PagedButtons__TriggerActionSellUnit takes nothing returns nothing
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



    endif
    set shop=null
endfunction

function PagedButtons__TriggerActionSellItem takes nothing returns nothing



endfunction

function PagedButtons__TriggerConditionIsMarketplace takes nothing returns boolean
    return GetUnitTypeId(GetSellingUnit()) == 'nmrk'
endfunction

function PagedButtons__Init takes nothing returns nothing

    set PagedButtons__deathTrigger=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(PagedButtons__deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(PagedButtons__deathTrigger, Condition(function PagedButtons__TriggerConditionDeath))


    call TriggerRegisterAnyUnitEventBJ(PagedButtons__sellUnitTrigger, EVENT_PLAYER_UNIT_SELL)
    call TriggerAddCondition(PagedButtons__sellUnitTrigger, Condition(function PagedButtons__TriggerConditionSell))
    call TriggerAddAction(PagedButtons__sellUnitTrigger, function PagedButtons__TriggerActionSellUnit)
    call TriggerRegisterAnyUnitEventBJ(PagedButtons__sellItemTrigger, EVENT_PLAYER_UNIT_SELL_ITEM)
    call TriggerAddCondition(PagedButtons__sellItemTrigger, Condition(function PagedButtons__TriggerConditionSell))
    call TriggerAddAction(PagedButtons__sellItemTrigger, function PagedButtons__TriggerActionSellItem)




    call TriggerAddCondition(bj_stockItemPurchased, Condition(function PagedButtons__TriggerConditionIsMarketplace))

endfunction


//processed hook: hook RemoveUnit DisablePagedButtons





//library PagedButtons ends
//library SimError:
//**************************************************************************************************
//*
//*  SimError
//*
//*     Mimic an interface error message
//*       call SimError(ForPlayer, msg)
//*         ForPlayer : The player to show the error
//*         msg       : The error
//*    
//*     To implement this function, copy this trigger and paste it in your map.
//* Unless of course you are actually reading the library from wc3c's scripts section, then just
//* paste the contents into some custom text trigger in your map.
//*
//**************************************************************************************************

//==================================================================================================
    //====================================================================================================

    function SimError takes player ForPlayer,string msg returns nothing
        set msg="\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n|cffffcc00" + msg + "|r"
        if ( GetLocalPlayer() == ForPlayer ) then
            call ClearTextMessages()
            call DisplayTimedTextToPlayer(ForPlayer, 0.52, 0.96, 2.00, msg)
            call StartSound(SimError__error)
        endif
    endfunction

    function SimError__Init takes nothing returns nothing
         set SimError__error=CreateSoundFromLabel("InterfaceError", false, false, false, 10, 10)
         //call StartSound( error ) //apparently the bug in which you play a sound for the first time
                                    //and it doesn't work is not there anymore in patch 1.22
    endfunction



//library SimError ends
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

function FormatTime takes real time returns string
    local integer hours= R2I(time / 3600.0)
    local integer minutes=  R2I(time - hours * 3600) / 60
    local integer seconds= R2I(time - hours * 3600 - minutes * 60)
    
    return I2SW(hours , 2) + ":" + I2SW(minutes , 2) + ":" + I2SW(seconds , 2)
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
//library PagedButtonsUI:


























function SetPagedButtonsUIEnabledForPlayer takes player whichPlayer,boolean enabled returns nothing
    set PagedButtonsUI__enabledForPlayer[GetPlayerId(whichPlayer)]=enabled
endfunction

function IsPagedButtonsUIEnabledForPlayer takes player whichPlayer returns boolean
    return PagedButtonsUI__enabledForPlayer[GetPlayerId(whichPlayer)]
endfunction

function PagedButtonsUI__GetButtonSlotIcon takes unit shop,integer index returns string
    return BlzGetAbilityIcon(GetPagedButtonId(shop , index))
endfunction

function PagedButtonsUI__GetMaxPageIndex takes integer playerId returns integer
     return GetPagedButtonsNonSpacerButtonsCount(PagedButtonsUI__UIShop[playerId]) / PagedButtonsUI_MAX_SLOTS
endfunction

function PagedButtonsUI__SetSlotChargesVisible takes integer i,boolean visible returns nothing
    call BlzFrameSetVisible(PagedButtonsUI__SlotChargesBackgroundFrame[i], visible)
    call BlzFrameSetVisible(PagedButtonsUI__SlotChargesFrame[i], visible)
endfunction

function PagedButtonsUI__SetTooltipVisible takes boolean visible returns nothing
    call BlzFrameSetVisible(PagedButtonsUI__TooltipIcon, visible)
    call BlzFrameSetVisible(PagedButtonsUI__PageNameText, visible)
    call BlzFrameSetVisible(PagedButtonsUI__SummonFrame, visible)
    call BlzFrameSetVisible(PagedButtonsUI__TooltipText, visible)
    call BlzFrameSetVisible(PagedButtonsUI__ItemGoldFrame, visible)
    call BlzFrameSetVisible(PagedButtonsUI__ItemGoldIconFrame, visible)
    call BlzFrameSetVisible(PagedButtonsUI__ItemLumberFrame, visible)
    call BlzFrameSetVisible(PagedButtonsUI__ItemLumberIconFrame, visible)
    call BlzFrameSetVisible(PagedButtonsUI__ItemFoodFrame, visible)
    call BlzFrameSetVisible(PagedButtonsUI__ItemFoodIconFrame, visible)



endfunction

function PagedButtonsUI__SetVisible takes boolean visible returns nothing
    call BlzFrameSetVisible(PagedButtonsUI__BackgroundFrame, visible)
    call BlzFrameSetVisible(PagedButtonsUI__TitleFrame, visible)
    call BlzFrameSetVisible(PagedButtonsUI__Checkbox, visible)
    
    call PagedButtonsUI__SetTooltipVisible(visible)
endfunction

function PagedButtonsUI__SetSlotVisible takes integer i,boolean visible returns nothing
    call BlzFrameSetVisible(PagedButtonsUI__SlotFrame[i], visible)
    call BlzFrameSetVisible(PagedButtonsUI__SlotBackdropFrame[i], visible)
    call BlzFrameSetVisible(PagedButtonsUI__SlotPageBackgroundFrame[i], visible)
    call BlzFrameSetVisible(PagedButtonsUI__SlotPageFrame[i], visible)
    if ( visible ) then
        set visible=PagedButtonsUI__checked // async
    endif
    call PagedButtonsUI__SetSlotChargesVisible(i , visible)
endfunction

function PagedButtonsUI__SetAllSlotChargesVisibleForPlayer takes player whichPlayer,boolean visible returns nothing
    local integer i= 0
    loop
        exitwhen ( i >= PagedButtonsUI_MAX_SLOTS )
        if ( whichPlayer == GetLocalPlayer() ) then
            if ( BlzFrameIsVisible(PagedButtonsUI__SlotFrame[i]) ) then
                call PagedButtonsUI__SetSlotChargesVisible(i , visible)
            endif
        endif
        set i=i + 1
    endloop
endfunction

function PagedButtonsUI__UpdateItemsForUI takes player whichPlayer returns nothing
    local integer playerId= GetPlayerId(whichPlayer)
    local integer objectId= 0
    local integer i= 0
    local unit shop= PagedButtonsUI__UIShop[playerId]
    local integer slot= 0
    local integer nonSpacerSlots= 0
    local integer startSlot= PagedButtonsUI__PagesIndex[playerId] * PagedButtonsUI_MAX_SLOTS
    local integer maxSlots= GetPagedButtonsCount(shop)
    local integer page= GetPagedButtonsPage(shop)
    local string pageName= GetPagedButtonsPageName(shop , page)
    local integer maxPageIndex= (GetPagedButtonsNonSpacerButtonsCount(PagedButtonsUI__UIShop[(playerId)]) / PagedButtonsUI_MAX_SLOTS) // INLINED!!
    local integer handleId= 0
    if ( pageName == null or StringLength(pageName) == 0 ) then
        set pageName=GetUnitName(shop)
    endif
    if ( maxPageIndex > 0 ) then
        set pageName=pageName + " (" + I2S(PagedButtonsUI__PagesIndex[playerId] + 1) + "/" + I2S(maxPageIndex + 1) + ")"
        if ( whichPlayer == GetLocalPlayer() ) then
            call BlzFrameSetVisible(PagedButtonsUI__NextPagesButton, true)
            call BlzFrameSetVisible(PagedButtonsUI__PreviousPagesButton, true)
        endif
    else
        if ( whichPlayer == GetLocalPlayer() ) then
            call BlzFrameSetVisible(PagedButtonsUI__NextPagesButton, false)
            call BlzFrameSetVisible(PagedButtonsUI__PreviousPagesButton, false)
        endif
    endif
    //call BJDebugMsg("max page index " + I2S(maxPageIndex))
    // set UIShop[playerId] = shop
    if ( whichPlayer == GetLocalPlayer() ) then
        call BlzFrameSetText(PagedButtonsUI__TitleFrame, pageName)
    endif
    loop
        exitwhen ( slot >= maxSlots or i >= PagedButtonsUI_MAX_SLOTS )
        if ( not (sg__PagedButtons_Type_get_whichType(GetPagedButton((shop ) , ( slot))) == PagedButtons_BUTTON_TYPE_SPACER) ) then // INLINED!!
            set nonSpacerSlots=nonSpacerSlots + 1
            if ( nonSpacerSlots > startSlot ) then
                set objectId=GetPagedButtonId(shop , slot)
                if ( PagedButtonsUI__UIVisible[playerId] ) then //  and GetItemCharges(index) > 0
                    if ( whichPlayer == GetLocalPlayer() ) then
                        //call BlzFrameSetTexture(SlotFrame[index], GetIconByItemType(udg_RucksackItemType[index]), 0, true)
                        call BlzFrameSetTexture(PagedButtonsUI__SlotBackdropFrame[i], BlzGetAbilityIcon(objectId), 0, true)
                        call BlzFrameSetText(PagedButtonsUI__SlotChargesFrame[i], "1") // I2S(GetItemCharges(index))
                        call BlzFrameSetText(PagedButtonsUI__SlotPageFrame[i], I2S(GetPagedButtonsPageByIndex(shop , slot) + 1))
                        call BlzFrameSetVisible(PagedButtonsUI__SlotChargesBackgroundFrame[i], PagedButtonsUI__checked)
                        call BlzFrameSetVisible(PagedButtonsUI__SlotChargesFrame[i], PagedButtonsUI__checked)




                        call BlzFrameSetVisible(PagedButtonsUI__SlotFrame[i], true)
                        call BlzFrameSetVisible(PagedButtonsUI__SlotBackdropFrame[i], true)
                    endif
                endif
                
                set handleId=GetHandleId(PagedButtonsUI__SlotClickTrigger[i])
                call SaveInteger(PagedButtonsUI__h, handleId, 0, slot)
                set handleId=GetHandleId(PagedButtonsUI__SlotTooltipOnTrigger[i])
                call SaveInteger(PagedButtonsUI__h, handleId, 0, slot)
                set handleId=GetHandleId(PagedButtonsUI__SlotTooltipOffTrigger[i])
                call SaveInteger(PagedButtonsUI__h, handleId, 0, slot)
                
                set i=i + 1
            endif
        endif
        
        set slot=slot + 1
    endloop
    
    loop
        exitwhen ( i >= PagedButtonsUI_MAX_SLOTS )
        if ( whichPlayer == GetLocalPlayer() ) then
            call PagedButtonsUI__SetSlotVisible(i , false)
        endif
        set i=i + 1
    endloop

endfunction

function PagedButtonsUI__UIExists takes nothing returns boolean
    return PagedButtonsUI__BackgroundFrame != null
endfunction

function PagedButtonsUI__GetPagesIndexFromPagedButtonsShopEx takes unit shop returns integer
    local integer currentPage= GetPagedButtonsPage(shop)
    local integer i= 0
    local integer max= GetPagedButtonsCount(shop)
    local integer countNonSpacerButtons= 0
    loop
        exitwhen ( i >= max )
        if ( GetPagedButtonsPageByIndex(shop , i) >= currentPage ) then
            return countNonSpacerButtons / PagedButtonsUI_MAX_SLOTS
        endif
        
        if ( not (sg__PagedButtons_Type_get_whichType(GetPagedButton((shop ) , ( i))) == PagedButtons_BUTTON_TYPE_SPACER) ) then // INLINED!!
            set countNonSpacerButtons=countNonSpacerButtons + 1
        endif
        set i=i + 1
    endloop
    return 0
endfunction

function PagedButtonsUI__GetPagesIndexFromPagedButtonsShop takes unit shop returns integer
    if ( (IsUnitInGroup((shop), PagedButtons__shops)) ) then // INLINED!!
        return PagedButtonsUI__GetPagesIndexFromPagedButtonsShopEx(shop)
    endif
    return 0
endfunction

function ShowPagedButtonsUI takes player whichPlayer,unit shop returns nothing
    local integer playerId= GetPlayerId(whichPlayer)
    if ( not (PagedButtonsUI__BackgroundFrame != null) ) then // INLINED!!
        return
    endif
    set PagedButtonsUI__UIVisible[playerId]=true
    set PagedButtonsUI__UIShop[playerId]=shop
    set PagedButtonsUI__PagesIndex[playerId]=PagedButtonsUI__GetPagesIndexFromPagedButtonsShop(shop)
    call PagedButtonsUI__UpdateItemsForUI(whichPlayer)
    if ( whichPlayer == GetLocalPlayer() ) then
        call PagedButtonsUI__SetVisible(true)
        call PagedButtonsUI__SetTooltipVisible(false)
    endif
endfunction

function PagedButtonsUI__HidePagedButtonsUISlots takes nothing returns nothing
    local integer i= 0
    loop
        exitwhen ( i == PagedButtonsUI_MAX_SLOTS )
        call PagedButtonsUI__SetSlotVisible(i , false)
        set i=i + 1
    endloop
endfunction

function HidePagedButtonsUI takes nothing returns nothing
    call PagedButtonsUI__SetVisible(false)
    call PagedButtonsUI__HidePagedButtonsUISlots()
endfunction

function HidePagedButtonsUIForPlayer takes player whichPlayer returns nothing
    local integer playerId= GetPlayerId(whichPlayer)
    local integer i= 0
    local integer index= 0
    if ( not (PagedButtonsUI__BackgroundFrame != null) ) then // INLINED!!
        return
    endif
    set PagedButtonsUI__UIVisible[playerId]=false
    set PagedButtonsUI__UIShop[playerId]=null
    set PagedButtonsUI__PagesIndex[playerId]=0






    if ( whichPlayer == GetLocalPlayer() ) then
        call PagedButtonsUI__SetVisible(false)
    endif
    set i=0
    loop
        exitwhen ( i == PagedButtonsUI_MAX_SLOTS )
        if ( whichPlayer == GetLocalPlayer() ) then
            call PagedButtonsUI__SetSlotVisible(i , false)
        endif
        set i=i + 1
    endloop
endfunction

function PagedButtonsUI__ClickItemFunction takes nothing returns nothing
    local integer handleId= GetHandleId(GetTriggeringTrigger())
    local integer slot= LoadInteger(PagedButtonsUI__h, handleId, 0)
    if ( GetLocalPlayer() == GetTriggerPlayer() ) then
        call BlzSendSyncData(PagedButtonsUI_PREFIX, I2S(slot))
    endif
endfunction

function PagedButtonsUI__CompareReals takes real a,real b returns boolean
     return a >= b and a <= b
endfunction


function PagedButtonsUI__StringSplit takes string source,integer index,string separator returns string
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

function PagedButtonsUI__SetTextAreaText takes framehandle f,string text returns nothing
    local string t= null
    local integer i= 0
    call BlzFrameSetText(f, "")
    loop
        set t=PagedButtonsUI__StringSplit(text , i , "|n")
        exitwhen ( t == null )
        if ( StringLength(t) == 0 ) then
            set t=" " // empty line
        endif
        call BlzFrameAddText(f, t)
        set i=i + 1
    endloop
endfunction

function PagedButtonsUI__EnterItemFunction takes nothing returns nothing
    local integer handleId= GetHandleId(GetTriggeringTrigger())
    local integer slot= LoadInteger(PagedButtonsUI__h, handleId, 0)
    local integer playerId= GetPlayerId(GetTriggerPlayer())
    local unit shop= PagedButtonsUI__UIShop[playerId]
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



    if ( slot >= 0 and slot < GetPagedButtonsCount(shop) ) then
        set pageName=GetPagedButtonsPageName(shop , page)
        set summonText=BlzGetAbilityTooltip(id, 0)
        if ( (sg__PagedButtons_Type_get_whichType(GetPagedButton((shop ) , ( slot))) == PagedButtons_BUTTON_TYPE_UNIT) ) then // INLINED!!
            if ( IsUnitIdType(id, UNIT_TYPE_HERO) ) then
                //call BJDebugMsg("Hero code " + A2S(id))




                set goldCost=PagedButtonsUI_HERO_GOLD_COST
                set lumberCost=PagedButtonsUI_HERO_LUMBER_COST

            else
                set goldCost=GetUnitGoldCost(id)
                set lumberCost=GetUnitWoodCost(id)
            endif
            set foodCost=GetFoodUsed(id)
        elseif ( (sg__PagedButtons_Type_get_whichType(GetPagedButton((shop ) , ( slot))) == PagedButtons_BUTTON_TYPE_ITEM) ) then // INLINED!!
            set goldCost=GetItemValueGold(id)
            set lumberCost=GetItemValueLumber(id)
        endif
        






        
        if ( summonText != null and StringLength(summonText) > 0 ) then
            if ( GetLocalPlayer() == GetTriggerPlayer() ) then
                call BlzFrameSetText(PagedButtonsUI__SummonFrame, summonText)
                call BlzFrameSetVisible(PagedButtonsUI__SummonFrame, true)
            endif
        endif
        
        if ( goldCost > 0 ) then
             if ( GetLocalPlayer() == GetTriggerPlayer() ) then
                call BlzFrameSetText(PagedButtonsUI__ItemGoldFrame, "|cffffcc00" + I2S(goldCost) + "|r")
                call BlzFrameSetVisible(PagedButtonsUI__ItemGoldIconFrame, true)
                call BlzFrameSetVisible(PagedButtonsUI__ItemGoldFrame, true)
            endif
        else
            if ( GetLocalPlayer() == GetTriggerPlayer() ) then
                call BlzFrameSetVisible(PagedButtonsUI__ItemGoldIconFrame, false)
                call BlzFrameSetVisible(PagedButtonsUI__ItemGoldFrame, false)
            endif
        endif
        
        if ( lumberCost > 0 ) then
             if ( GetLocalPlayer() == GetTriggerPlayer() ) then
                call BlzFrameSetText(PagedButtonsUI__ItemLumberFrame, "|cffffcc00" + I2S(lumberCost) + "|r")
                call BlzFrameSetVisible(PagedButtonsUI__ItemLumberIconFrame, true)
                call BlzFrameSetVisible(PagedButtonsUI__ItemLumberFrame, true)
            endif
        else
            if ( GetLocalPlayer() == GetTriggerPlayer() ) then
                call BlzFrameSetVisible(PagedButtonsUI__ItemLumberIconFrame, false)
                call BlzFrameSetVisible(PagedButtonsUI__ItemLumberFrame, false)
            endif
        endif
        
        if ( foodCost > 0 ) then
             if ( GetLocalPlayer() == GetTriggerPlayer() ) then
                call BlzFrameSetText(PagedButtonsUI__ItemFoodFrame, "|cffffcc00" + I2S(foodCost) + "|r")
                call BlzFrameSetVisible(PagedButtonsUI__ItemFoodIconFrame, true)
                call BlzFrameSetVisible(PagedButtonsUI__ItemFoodFrame, true)
            endif
        else
            if ( GetLocalPlayer() == GetTriggerPlayer() ) then
                call BlzFrameSetVisible(PagedButtonsUI__ItemFoodIconFrame, false)
                call BlzFrameSetVisible(PagedButtonsUI__ItemFoodFrame, false)
            endif
        endif
        //call BJDebugMsg("Entering item " + I2S(index))
        
        if ( pageName != null ) then
            if ( GetLocalPlayer() == GetTriggerPlayer() ) then
                call BlzFrameSetText(PagedButtonsUI__PageNameText, pageName)
                call BlzFrameSetVisible(PagedButtonsUI__PageNameText, true)
            endif
        else
            if ( GetLocalPlayer() == GetTriggerPlayer() ) then
                call BlzFrameSetVisible(PagedButtonsUI__PageNameText, false)
            endif
        endif

        if ( id != 0 ) then
            set tooltip=tooltip + BlzGetAbilityExtendedTooltip(id, 0)
        else
            set tooltip=tooltip + "Empty slot " + I2S(slot + 1) + " at page " + I2S(page + 1) + "."
            //call BlzFrameSetVisible(ItemGoldIconFrame[playerId], false)
        endif
        
        if ( id != 0 ) then
            if ( GetLocalPlayer() == GetTriggerPlayer() ) then
                call BlzFrameSetTexture(PagedButtonsUI__TooltipIcon, (BlzGetAbilityIcon(GetPagedButtonId((shop ) , ( slot)))), 0, false) // INLINED!!
                call BlzFrameSetVisible(PagedButtonsUI__TooltipIcon, true)
            endif
            set tooltip=tooltip + PagedButtonsUI_BUY_TEXT
        else
            if ( GetLocalPlayer() == GetTriggerPlayer() ) then
                call BlzFrameSetVisible(PagedButtonsUI__TooltipIcon, false)
            endif
            set tooltip=tooltip + PagedButtonsUI_OPEN_TEXT
        endif

        if ( GetLocalPlayer() == GetTriggerPlayer() ) then
            call PagedButtonsUI__SetTextAreaText(PagedButtonsUI__TooltipText , tooltip)
            //call BlzFrameSetText(TooltipText, tooltip)
            call BlzFrameSetVisible(PagedButtonsUI__TooltipText, true)
        endif
        



























    endif
    
    set shop=null
endfunction

function PagedButtonsUI__LeaveItemFunction takes nothing returns nothing
    
endfunction

function PagedButtonsUI__PreviousPagesFunction takes nothing returns nothing
    if ( GetLocalPlayer() == GetTriggerPlayer() ) then
        call BlzSendSyncData(PagedButtonsUI_PREFIX, "PreviousPage")
    endif
endfunction

function PagedButtonsUI__NextPagesFunction takes nothing returns nothing
    if ( GetLocalPlayer() == GetTriggerPlayer() ) then
        call BlzSendSyncData(PagedButtonsUI_PREFIX, "NextPage")
    endif
endfunction

function PagedButtonsUI__CheckedFunction takes nothing returns nothing
    if ( GetTriggerPlayer() == GetLocalPlayer() ) then
        set PagedButtonsUI__checked=true
    endif
    call PagedButtonsUI__SetAllSlotChargesVisibleForPlayer(GetTriggerPlayer() , true)
endfunction

function PagedButtonsUI__UncheckedFunction takes nothing returns nothing
    if ( GetTriggerPlayer() == GetLocalPlayer() ) then
        set PagedButtonsUI__checked=false
    endif
    call PagedButtonsUI__SetAllSlotChargesVisibleForPlayer(GetTriggerPlayer() , false)
endfunction

function PagedButtonsUI__CloseFunction takes nothing returns nothing
    if ( GetLocalPlayer() == GetTriggerPlayer() ) then
        call BlzSendSyncData(PagedButtonsUI_PREFIX, "Close")
    endif
endfunction

function PagedButtonsUI_CreateUI takes nothing returns nothing
    local integer i= 0
    local integer handleId= 0
    local real x= 0.0
    local real y= 0.0
    
    set PagedButtonsUI__BackgroundFrame=BlzCreateFrame("EscMenuBackdrop", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(PagedButtonsUI__BackgroundFrame, FRAMEPOINT_TOPLEFT, PagedButtonsUI_X, PagedButtonsUI_Y)
    call BlzFrameSetAbsPoint(PagedButtonsUI__BackgroundFrame, FRAMEPOINT_BOTTOMRIGHT, PagedButtonsUI_SIZE_X, PagedButtonsUI_Y - PagedButtonsUI_SIZE_Y)

    set y=PagedButtonsUI_TITLE_Y
    set PagedButtonsUI__TitleFrame=BlzCreateFrameByType("TEXT", "PagedButtonsUITitle", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(PagedButtonsUI__TitleFrame, FRAMEPOINT_TOPLEFT, 0.0, y)
    call BlzFrameSetAbsPoint(PagedButtonsUI__TitleFrame, FRAMEPOINT_BOTTOMRIGHT, PagedButtonsUI_SIZE_X, y - PagedButtonsUI_TITLE_HEIGHT)
    call BlzFrameSetTextAlignment(PagedButtonsUI__TitleFrame, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)

    set x=PagedButtonsUI_BUTTON_X
    set y=PagedButtonsUI_BUTTON_Y
    set i=0
    loop
        exitwhen ( i == PagedButtonsUI_MAX_SLOTS )
        set PagedButtonsUI__SlotFrame[i]=BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
        call BlzFrameSetAbsPoint(PagedButtonsUI__SlotFrame[i], FRAMEPOINT_TOPLEFT, x, y)
        call BlzFrameSetAbsPoint(PagedButtonsUI__SlotFrame[i], FRAMEPOINT_BOTTOMRIGHT, x + PagedButtonsUI_BUTTON_SIZE, y - PagedButtonsUI_BUTTON_SIZE)
        //call BlzFrameSetTexture(SlotFrame[index], GetIconByItemType(0), 0, true)
        //call BlzFrameSetText(SlotFrame[index], I2S(index))

        set PagedButtonsUI__SlotBackdropFrame[i]=BlzCreateFrameByType("BACKDROP", "PagedButtonsUIBackdropFrame" + I2S(i), PagedButtonsUI__SlotFrame[i], "", 1)
        call BlzFrameSetAllPoints(PagedButtonsUI__SlotBackdropFrame[i], PagedButtonsUI__SlotFrame[i])
//             call BlzFrameSetTexture(SlotBackdropFrame[index], "UI\\Widgets\\Console\\Human\\human-inventory-slotfiller.blp", 0, true)

        if ( PagedButtonsUI__SlotClickTrigger[i] != null ) then
            set handleId=GetHandleId(PagedButtonsUI__SlotClickTrigger[i])
            call FlushChildHashtable(PagedButtonsUI__h, handleId)
            call DestroyTrigger(PagedButtonsUI__SlotClickTrigger[i])
        endif
        set PagedButtonsUI__SlotClickTrigger[i]=CreateTrigger()
        call BlzTriggerRegisterFrameEvent(PagedButtonsUI__SlotClickTrigger[i], PagedButtonsUI__SlotFrame[i], FRAMEEVENT_CONTROL_CLICK)
        call TriggerAddAction(PagedButtonsUI__SlotClickTrigger[i], function PagedButtonsUI__ClickItemFunction)
        set handleId=GetHandleId(PagedButtonsUI__SlotClickTrigger[i])
        call SaveInteger(PagedButtonsUI__h, handleId, 0, i)

        if ( PagedButtonsUI__SlotTooltipOnTrigger[i] != null ) then
            set handleId=GetHandleId(PagedButtonsUI__SlotTooltipOnTrigger[i])
            call FlushChildHashtable(PagedButtonsUI__h, handleId)
            call DestroyTrigger(PagedButtonsUI__SlotTooltipOnTrigger[i])
        endif
        set PagedButtonsUI__SlotTooltipOnTrigger[i]=CreateTrigger()
        call BlzTriggerRegisterFrameEvent(PagedButtonsUI__SlotTooltipOnTrigger[i], PagedButtonsUI__SlotFrame[i], FRAMEEVENT_MOUSE_ENTER)
        call TriggerAddAction(PagedButtonsUI__SlotTooltipOnTrigger[i], function PagedButtonsUI__EnterItemFunction)
        set handleId=GetHandleId(PagedButtonsUI__SlotTooltipOnTrigger[i])
        call SaveInteger(PagedButtonsUI__h, handleId, 0, i)
        
        if ( PagedButtonsUI__SlotTooltipOffTrigger[i] != null ) then
            set handleId=GetHandleId(PagedButtonsUI__SlotTooltipOffTrigger[i])
            call FlushChildHashtable(PagedButtonsUI__h, handleId)
            call DestroyTrigger(PagedButtonsUI__SlotTooltipOffTrigger[i])
        endif
        set PagedButtonsUI__SlotTooltipOffTrigger[i]=CreateTrigger()
        call BlzTriggerRegisterFrameEvent(PagedButtonsUI__SlotTooltipOffTrigger[i], PagedButtonsUI__SlotFrame[i], FRAMEEVENT_MOUSE_LEAVE)
        call TriggerAddAction(PagedButtonsUI__SlotTooltipOffTrigger[i], function PagedButtonsUI__LeaveItemFunction)
        call SaveInteger(PagedButtonsUI__h, handleId, 0, i)

        // TODO Mouse down and mouse up to drag & drop to another bag or switch or do it like Warcraft's inventory with right click and left click. Add the icon of the item to the mouse cursor. If you click on the map it is dropped, if you click on the inventory it is dropped there.
        
        set PagedButtonsUI__SlotPageBackgroundFrame[i]=BlzCreateFrameByType("BACKDROP", "ItemBagBackrgroundFrame" + I2S(i), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
        call BlzFrameSetAbsPoint(PagedButtonsUI__SlotPageBackgroundFrame[i], FRAMEPOINT_TOPLEFT, x, y)
        call BlzFrameSetAbsPoint(PagedButtonsUI__SlotPageBackgroundFrame[i], FRAMEPOINT_BOTTOMRIGHT, x + PagedButtonsUI_CHARGES_BACKGROUND_SIZE, y - PagedButtonsUI_CHARGES_BACKGROUND_SIZE)
        call BlzFrameSetTexture(PagedButtonsUI__SlotPageBackgroundFrame[i], "ui\\widgets\\console\\human\\commandbutton\\human-button-lvls-overlay.blp", 0, true)
        call BlzFrameSetLevel(PagedButtonsUI__SlotPageBackgroundFrame[i], 1)

        set PagedButtonsUI__SlotPageFrame[i]=BlzCreateFrameByType("TEXT", "PagedButtonsUIBag" + I2S(i), PagedButtonsUI__SlotPageBackgroundFrame[i], "", 0)
        call BlzFrameSetAllPoints(PagedButtonsUI__SlotPageFrame[i], PagedButtonsUI__SlotPageBackgroundFrame[i])
        call BlzFrameSetText(PagedButtonsUI__SlotPageFrame[i], I2S(i + 1))
        call BlzFrameSetTextAlignment(PagedButtonsUI__SlotPageFrame[i], TEXT_JUSTIFY_CENTER, TEXT_JUSTIFY_CENTER)
        call BlzFrameSetScale(PagedButtonsUI__SlotPageFrame[i], 0.7)
        call BlzFrameSetEnable(PagedButtonsUI__SlotPageFrame[i], false)
        call BlzFrameSetLevel(PagedButtonsUI__SlotPageFrame[i], 2)
        
        set PagedButtonsUI__SlotChargesBackgroundFrame[i]=BlzCreateFrameByType("BACKDROP", "PagedButtonsUIItemChargesBackrgroundFrame" + I2S(i), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
        call BlzFrameSetAbsPoint(PagedButtonsUI__SlotChargesBackgroundFrame[i], FRAMEPOINT_TOPLEFT, x + PagedButtonsUI_BUTTON_SIZE - PagedButtonsUI_CHARGES_BACKGROUND_SIZE, y - PagedButtonsUI_BUTTON_SIZE + PagedButtonsUI_CHARGES_BACKGROUND_SIZE)
        call BlzFrameSetAbsPoint(PagedButtonsUI__SlotChargesBackgroundFrame[i], FRAMEPOINT_BOTTOMRIGHT, x + PagedButtonsUI_BUTTON_SIZE, y - PagedButtonsUI_BUTTON_SIZE)
        call BlzFrameSetTexture(PagedButtonsUI__SlotChargesBackgroundFrame[i], "ui\\widgets\\console\\human\\commandbutton\\human-button-lvls-overlay.blp", 0, true)
        call BlzFrameSetLevel(PagedButtonsUI__SlotChargesBackgroundFrame[i], 1)

        set PagedButtonsUI__SlotChargesFrame[i]=BlzCreateFrameByType("TEXT", "PagedButtonsUICharges" + I2S(i), PagedButtonsUI__SlotChargesBackgroundFrame[i], "", 0)
        call BlzFrameSetAllPoints(PagedButtonsUI__SlotChargesFrame[i], PagedButtonsUI__SlotChargesBackgroundFrame[i])
        call BlzFrameSetText(PagedButtonsUI__SlotChargesFrame[i], "|cffFFFFFFCharges|r")
        call BlzFrameSetTextAlignment(PagedButtonsUI__SlotChargesFrame[i], TEXT_JUSTIFY_CENTER, TEXT_JUSTIFY_CENTER)
        call BlzFrameSetScale(PagedButtonsUI__SlotChargesFrame[i], 0.7)
        call BlzFrameSetEnable(PagedButtonsUI__SlotChargesFrame[i], false)
        call BlzFrameSetLevel(PagedButtonsUI__SlotChargesFrame[i], 2)

        set x=x + PagedButtonsUI_BUTTON_SIZE + PagedButtonsUI_BUTTON_SPACE

        set i=i + 1

        // every 3 bags start another line
        if ( ModuloInteger(i, PagedButtonsUI_MAX_SLOTS_PER_LINE) == 0 ) then
            set x=PagedButtonsUI_BUTTON_X
            set y=y - PagedButtonsUI_BUTTON_SIZE - PagedButtonsUI_BUTTON_SPACE
        endif
    endloop

    set PagedButtonsUI__TooltipFrame=BlzCreateFrame("EscMenuBackdrop", PagedButtonsUI__BackgroundFrame, 0, 0)
    call BlzFrameSetAbsPoint(PagedButtonsUI__TooltipFrame, FRAMEPOINT_TOPLEFT, PagedButtonsUI_TOOLTIP_FRAME_X, PagedButtonsUI_TOOLTIP_FRAME_Y)
    call BlzFrameSetAbsPoint(PagedButtonsUI__TooltipFrame, FRAMEPOINT_BOTTOMRIGHT, PagedButtonsUI_TOOLTIP_FRAME_X + PagedButtonsUI_TOOLTIP_FRAME_WIDTH, PagedButtonsUI_TOOLTIP_FRAME_Y - PagedButtonsUI_TOOLTIP_FRAME_HEIGHT)
    
    set PagedButtonsUI__TooltipIcon=BlzCreateFrameByType("BACKDROP", "PagedButtonsUITooltipIconFrame", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(PagedButtonsUI__TooltipIcon, FRAMEPOINT_TOPLEFT, PagedButtonsUI_TOOLTIP_ICON_X, PagedButtonsUI_TOOLTIP_ICON_Y)
    call BlzFrameSetAbsPoint(PagedButtonsUI__TooltipIcon, FRAMEPOINT_BOTTOMRIGHT, PagedButtonsUI_TOOLTIP_ICON_X + PagedButtonsUI_TOOLTIP_ICON_SIZE, PagedButtonsUI_TOOLTIP_ICON_Y - PagedButtonsUI_TOOLTIP_ICON_SIZE)
    call BlzFrameSetTexture(PagedButtonsUI__TooltipIcon, "ReplaceableTextures\\WorldEditUI\\Editor-Random-Item.blp", 0, true)
    
    set PagedButtonsUI__PageNameText=BlzCreateFrameByType("TEXT", "PagedButtonsUITooltipPageName", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(PagedButtonsUI__PageNameText, FRAMEPOINT_TOPLEFT, PagedButtonsUI_TOOLTIP_PAGE_NAME_X, PagedButtonsUI_TOOLTIP_PAGE_NAME_Y)
    call BlzFrameSetAbsPoint(PagedButtonsUI__PageNameText, FRAMEPOINT_BOTTOMRIGHT, PagedButtonsUI_TOOLTIP_PAGE_NAME_X + PagedButtonsUI_TOOLTIP_PAGE_NAME_WIDTH, PagedButtonsUI_TOOLTIP_PAGE_NAME_Y - PagedButtonsUI_TOOLTIP_PAGE_NAME_HEIGHT)
    
    set PagedButtonsUI__SummonFrame=BlzCreateFrameByType("TEXT", "PagedButtonsUITooltipSummon", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(PagedButtonsUI__SummonFrame, FRAMEPOINT_TOPLEFT, PagedButtonsUI_SUMMON_X, PagedButtonsUI_SUMMON_Y)
    call BlzFrameSetAbsPoint(PagedButtonsUI__SummonFrame, FRAMEPOINT_BOTTOMRIGHT, PagedButtonsUI_SUMMON_X + PagedButtonsUI_TOOLTIP_WIDTH, PagedButtonsUI_SUMMON_Y - PagedButtonsUI_SUMMON_HEIGHT)

    set PagedButtonsUI__ItemGoldIconFrame=BlzCreateFrameByType("BACKDROP", "PagedButtonsUITooltipGoldFrame", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(PagedButtonsUI__ItemGoldIconFrame, FRAMEPOINT_TOPLEFT, PagedButtonsUI_COST_X, PagedButtonsUI_COST_Y)
    call BlzFrameSetAbsPoint(PagedButtonsUI__ItemGoldIconFrame, FRAMEPOINT_BOTTOMRIGHT, PagedButtonsUI_COST_X + PagedButtonsUI_COST_ICON_SIZE, PagedButtonsUI_COST_Y - PagedButtonsUI_COST_ICON_SIZE)
    call BlzFrameSetTexture(PagedButtonsUI__ItemGoldIconFrame, "UI\\Feedback\\Resources\\ResourceGold.blp", 0, true)
    
    set PagedButtonsUI__ItemGoldFrame=BlzCreateFrameByType("TEXT", "PagedButtonsUITooltipGold", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(PagedButtonsUI__ItemGoldFrame, FRAMEPOINT_TOPLEFT, PagedButtonsUI_COST_GOLD_X, PagedButtonsUI_COST_Y)
    call BlzFrameSetAbsPoint(PagedButtonsUI__ItemGoldFrame, FRAMEPOINT_BOTTOMRIGHT, PagedButtonsUI_COST_GOLD_X + PagedButtonsUI_COST_WIDTH, PagedButtonsUI_COST_Y - PagedButtonsUI_COST_HEIGHT)
    
    set PagedButtonsUI__ItemLumberIconFrame=BlzCreateFrameByType("BACKDROP", "PagedButtonsUITooltipLumberFrame", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(PagedButtonsUI__ItemLumberIconFrame, FRAMEPOINT_TOPLEFT, PagedButtonsUI_COST_ICON_LUMBER_X, PagedButtonsUI_COST_Y)
    call BlzFrameSetAbsPoint(PagedButtonsUI__ItemLumberIconFrame, FRAMEPOINT_BOTTOMRIGHT, PagedButtonsUI_COST_ICON_LUMBER_X + PagedButtonsUI_COST_ICON_SIZE, PagedButtonsUI_COST_Y - PagedButtonsUI_COST_ICON_SIZE)
    call BlzFrameSetTexture(PagedButtonsUI__ItemLumberIconFrame, "UI\\Feedback\\Resources\\ResourceLumber.blp", 0, true)
    
    set PagedButtonsUI__ItemLumberFrame=BlzCreateFrameByType("TEXT", "PagedButtonsUITooltipLumber", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(PagedButtonsUI__ItemLumberFrame, FRAMEPOINT_TOPLEFT, PagedButtonsUI_COST_LUMBER_X, PagedButtonsUI_COST_Y)
    call BlzFrameSetAbsPoint(PagedButtonsUI__ItemLumberFrame, FRAMEPOINT_BOTTOMRIGHT, PagedButtonsUI_COST_LUMBER_X + PagedButtonsUI_COST_WIDTH, PagedButtonsUI_COST_Y - PagedButtonsUI_COST_ICON_SIZE)
    
    set PagedButtonsUI__ItemFoodIconFrame=BlzCreateFrameByType("BACKDROP", "PagedButtonsUITooltipFoodFrame", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(PagedButtonsUI__ItemFoodIconFrame, FRAMEPOINT_TOPLEFT, PagedButtonsUI_COST_ICON_FOOD_X, PagedButtonsUI_COST_Y)
    call BlzFrameSetAbsPoint(PagedButtonsUI__ItemFoodIconFrame, FRAMEPOINT_BOTTOMRIGHT, PagedButtonsUI_COST_ICON_FOOD_X + PagedButtonsUI_COST_ICON_SIZE, PagedButtonsUI_COST_Y - PagedButtonsUI_COST_ICON_SIZE)
    call BlzFrameSetTexture(PagedButtonsUI__ItemFoodIconFrame, "UI\\Feedback\\Resources\\ResourceSupply.blp", 0, true)
    
    set PagedButtonsUI__ItemFoodFrame=BlzCreateFrameByType("TEXT", "PagedButtonsUITooltipFood", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(PagedButtonsUI__ItemFoodFrame, FRAMEPOINT_TOPLEFT, PagedButtonsUI_COST_FOOD_X, PagedButtonsUI_COST_Y)
    call BlzFrameSetAbsPoint(PagedButtonsUI__ItemFoodFrame, FRAMEPOINT_BOTTOMRIGHT, PagedButtonsUI_COST_FOOD_X + PagedButtonsUI_COST_WIDTH, PagedButtonsUI_COST_Y - PagedButtonsUI_COST_ICON_SIZE)
    
    set PagedButtonsUI__TooltipText=BlzCreateFrame("EscMenuTextAreaTemplate", PagedButtonsUI__BackgroundFrame, 0, 0)
    call BlzFrameSetAbsPoint(PagedButtonsUI__TooltipText, FRAMEPOINT_TOPLEFT, PagedButtonsUI_TOOLTIP_X, PagedButtonsUI_TOOLTIP_Y)
    call BlzFrameSetAbsPoint(PagedButtonsUI__TooltipText, FRAMEPOINT_BOTTOMRIGHT, PagedButtonsUI_TOOLTIP_X + PagedButtonsUI_TOOLTIP_WIDTH, PagedButtonsUI_TOOLTIP_Y - PagedButtonsUI_TOOLTIP_HEIGHT)
    call BlzFrameSetFont(PagedButtonsUI__TooltipText, "MasterFont", PagedButtonsUI_TOOLTIP_FONT_HEIGHT, 0)
    call BlzFrameSetEnable(PagedButtonsUI__TooltipText, false)
    call BlzFrameSetTextAlignment(PagedButtonsUI__TooltipText, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)
    call BlzFrameSetLevel(PagedButtonsUI__TooltipText, 1)
    
    //call BJDebugMsg("Icon " + GetIconByItemType(itemTypeId) + " for item type " + GetObjectName(itemTypeId))





    set PagedButtonsUI__NextPagesButton=BlzCreateFrame("ScriptDialogButton", PagedButtonsUI__BackgroundFrame, 0, 0)
    call BlzFrameSetAbsPoint(PagedButtonsUI__NextPagesButton, FRAMEPOINT_TOPLEFT, PagedButtonsUI_NEXT_PAGE_BUTTON_X, PagedButtonsUI_BOTTOM_BUTTONS_Y)
    call BlzFrameSetAbsPoint(PagedButtonsUI__NextPagesButton, FRAMEPOINT_BOTTOMRIGHT, PagedButtonsUI_NEXT_PAGE_BUTTON_X + PagedButtonsUI_PAGE_BUTTON_WIDTH, PagedButtonsUI_BOTTOM_BUTTONS_Y - PagedButtonsUI_CLOSE_BUTTON_HEIGHT)
    call BlzFrameSetText(PagedButtonsUI__NextPagesButton, PagedButtonsUI_NEXT_PAGE_TEXT)

    if ( PagedButtonsUI__NextPagesTrigger != null ) then
        call DestroyTrigger(PagedButtonsUI__NextPagesTrigger)
    endif
    set PagedButtonsUI__NextPagesTrigger=CreateTrigger()
    call BlzTriggerRegisterFrameEvent(PagedButtonsUI__NextPagesTrigger, PagedButtonsUI__NextPagesButton, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(PagedButtonsUI__NextPagesTrigger, function PagedButtonsUI__NextPagesFunction)
    
    set PagedButtonsUI__PreviousPagesButton=BlzCreateFrame("ScriptDialogButton", PagedButtonsUI__BackgroundFrame, 0, 0)
    call BlzFrameSetAbsPoint(PagedButtonsUI__PreviousPagesButton, FRAMEPOINT_TOPLEFT, PagedButtonsUI_PREVIOUS_PAGE_BUTTON_X, PagedButtonsUI_BOTTOM_BUTTONS_Y)
    call BlzFrameSetAbsPoint(PagedButtonsUI__PreviousPagesButton, FRAMEPOINT_BOTTOMRIGHT, PagedButtonsUI_PREVIOUS_PAGE_BUTTON_X + PagedButtonsUI_PAGE_BUTTON_WIDTH, PagedButtonsUI_BOTTOM_BUTTONS_Y - PagedButtonsUI_CLOSE_BUTTON_HEIGHT)
    call BlzFrameSetText(PagedButtonsUI__PreviousPagesButton, PagedButtonsUI_PREVIOUS_PAGE_TEXT)

    if ( PagedButtonsUI__PreviousPagesTrigger != null ) then
        call DestroyTrigger(PagedButtonsUI__PreviousPagesTrigger)
    endif
    set PagedButtonsUI__PreviousPagesTrigger=CreateTrigger()
    call BlzTriggerRegisterFrameEvent(PagedButtonsUI__PreviousPagesTrigger, PagedButtonsUI__PreviousPagesButton, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(PagedButtonsUI__PreviousPagesTrigger, function PagedButtonsUI__PreviousPagesFunction)

    set PagedButtonsUI__Checkbox=BlzCreateFrame("QuestCheckBox2", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(PagedButtonsUI__Checkbox, FRAMEPOINT_TOPLEFT, PagedButtonsUI_CHECKBOX_X, PagedButtonsUI_BOTTOM_BUTTONS_Y)
    call BlzFrameSetAbsPoint(PagedButtonsUI__Checkbox, FRAMEPOINT_BOTTOMRIGHT, PagedButtonsUI_CHECKBOX_X + PagedButtonsUI_CHECKBOX_SIZE, PagedButtonsUI_BOTTOM_BUTTONS_Y - PagedButtonsUI_CHECKBOX_SIZE)
    call BlzFrameSetEnable(PagedButtonsUI__Checkbox, true)
    call BlzFrameSetValue(PagedButtonsUI__Checkbox, 1.0)
   
    if ( PagedButtonsUI__CheckedTrigger != null ) then
        call DestroyTrigger(PagedButtonsUI__CheckedTrigger)
    endif
    set PagedButtonsUI__CheckedTrigger=CreateTrigger()
    call BlzTriggerRegisterFrameEvent(PagedButtonsUI__CheckedTrigger, PagedButtonsUI__Checkbox, FRAMEEVENT_CHECKBOX_CHECKED)
    call TriggerAddAction(PagedButtonsUI__CheckedTrigger, function PagedButtonsUI__CheckedFunction)
    
    if ( PagedButtonsUI__UncheckedTrigger != null ) then
        call DestroyTrigger(PagedButtonsUI__UncheckedTrigger)
    endif
    set PagedButtonsUI__UncheckedTrigger=CreateTrigger()
    call BlzTriggerRegisterFrameEvent(PagedButtonsUI__UncheckedTrigger, PagedButtonsUI__Checkbox, FRAMEEVENT_CHECKBOX_UNCHECKED)
    call TriggerAddAction(PagedButtonsUI__UncheckedTrigger, function PagedButtonsUI__UncheckedFunction)

    set PagedButtonsUI__CloseButton=BlzCreateFrame("ScriptDialogButton", PagedButtonsUI__BackgroundFrame, 0, 0)
    call BlzFrameSetAbsPoint(PagedButtonsUI__CloseButton, FRAMEPOINT_TOPLEFT, PagedButtonsUI_CLOSE_BUTTON_X, PagedButtonsUI_BOTTOM_BUTTONS_Y)
    call BlzFrameSetAbsPoint(PagedButtonsUI__CloseButton, FRAMEPOINT_BOTTOMRIGHT, PagedButtonsUI_CLOSE_BUTTON_X + PagedButtonsUI_CLOSE_BUTTON_WIDTH, PagedButtonsUI_BOTTOM_BUTTONS_Y - PagedButtonsUI_CLOSE_BUTTON_HEIGHT)
    call BlzFrameSetText(PagedButtonsUI__CloseButton, PagedButtonsUI_CLOSE_TEXT)

    if ( PagedButtonsUI__CloseTrigger != null ) then
        call DestroyTrigger(PagedButtonsUI__CloseTrigger)
    endif
    set PagedButtonsUI__CloseTrigger=CreateTrigger()
    call BlzTriggerRegisterFrameEvent(PagedButtonsUI__CloseTrigger, PagedButtonsUI__CloseButton, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(PagedButtonsUI__CloseTrigger, function PagedButtonsUI__CloseFunction)

    call HidePagedButtonsUI()
endfunction

function PagedButtonsUI__TriggerActionSelected takes nothing returns nothing
    if ( (IsUnitInGroup((GetTriggerUnit()), PagedButtons__shops)) and GetPagedButtonsCount(GetTriggerUnit()) > 0 and (PagedButtonsUI__enabledForPlayer[GetPlayerId((GetTriggerPlayer()))]) ) then // INLINED!!
        call ShowPagedButtonsUI(GetTriggerPlayer() , GetTriggerUnit())
    endif
endfunction

function PagedButtonsUI__TriggerConditionChangePage takes nothing returns boolean
    local unit shop= (PagedButtons__triggerShop) // INLINED!!
    local integer i= 0
    loop
        exitwhen ( i == bj_MAX_PLAYERS )
        if ( shop == PagedButtonsUI__UIShop[i] ) then
            call PagedButtonsUI__UpdateItemsForUI(Player(i))
        endif
        set i=i + 1
    endloop
    set shop=null
    return false
endfunction

function PagedButtonsUI__TriggerConditionDeath takes nothing returns boolean
    local unit shop= GetTriggerUnit()
    local integer i= 0
    loop
        exitwhen ( i == bj_MAX_PLAYERS )
        if ( shop == PagedButtonsUI__UIShop[i] ) then
            call HidePagedButtonsUIForPlayer(Player(i))
        endif
        set i=i + 1
    endloop
    set shop=null
    return false
endfunction

function PagedButtonsUI__TriggerActionSyncData takes nothing returns nothing
    local player whichPlayer= GetTriggerPlayer()
    local integer playerId= GetPlayerId(whichPlayer)
    local string data= BlzGetTriggerSyncData()
    local integer slot= 0
    local unit shop= PagedButtonsUI__UIShop[playerId]
    local integer id= 0
    local integer newPage= 0
    if ( data == "PreviousPage" ) then
        if ( PagedButtonsUI__PagesIndex[playerId] == 0 ) then
            set PagedButtonsUI__PagesIndex[playerId]=(GetPagedButtonsNonSpacerButtonsCount(PagedButtonsUI__UIShop[(playerId)]) / PagedButtonsUI_MAX_SLOTS) // INLINED!!
        else
            set PagedButtonsUI__PagesIndex[playerId]=PagedButtonsUI__PagesIndex[playerId] - 1
        endif
        call PagedButtonsUI__UpdateItemsForUI(whichPlayer)
        //call BJDebugMsg("Previous pages button with index " + I2S(PagesIndex[playerId]))
    elseif ( data == "NextPage" ) then
        if ( PagedButtonsUI__PagesIndex[playerId] < (GetPagedButtonsNonSpacerButtonsCount(PagedButtonsUI__UIShop[(playerId)]) / PagedButtonsUI_MAX_SLOTS) ) then // INLINED!!
            set PagedButtonsUI__PagesIndex[playerId]=PagedButtonsUI__PagesIndex[playerId] + 1
        else
            set PagedButtonsUI__PagesIndex[playerId]=0
        endif
        call PagedButtonsUI__UpdateItemsForUI(whichPlayer)
        //call BJDebugMsg("Next pages button with index " + I2S(PagesIndex[playerId]))
    elseif ( data == "Close" ) then
        call HidePagedButtonsUIForPlayer(whichPlayer)
    else
        set slot=S2I(data)
        set id=GetPagedButtonId(shop , slot)
        set newPage=GetPagedButtonsPageByIndex(shop , slot)
        if ( newPage < GetPagedButtonsMaxPages(shop) and newPage >= 0 ) then
            call SetPagedButtonsPage(shop , newPage)
            if ( id != 0 and ( (sg__PagedButtons_Type_get_whichType(GetPagedButton((shop ) , ( slot))) == PagedButtons_BUTTON_TYPE_UNIT) or (sg__PagedButtons_Type_get_whichType(GetPagedButton((shop ) , ( slot))) == PagedButtons_BUTTON_TYPE_ITEM) ) ) then // INLINED!!
                call IssueNeutralImmediateOrderById(whichPlayer, shop, id)
            endif
        endif
    endif
    set whichPlayer=null
    set shop=null
endfunction

function PagedButtonsUI__TimerFunctionStart takes nothing returns nothing
    local timer t= GetExpiredTimer()
    local integer i= 0
    local player slotPlayer= null
    loop
        exitwhen ( i == bj_MAX_PLAYERS )
        set slotPlayer=Player(i)
        if ( GetPlayerSlotState(slotPlayer) == PLAYER_SLOT_STATE_PLAYING and GetPlayerController(slotPlayer) == MAP_CONTROL_USER ) then
            set PagedButtonsUI__enabledForPlayer[i]=true
            call BlzTriggerRegisterPlayerSyncEvent(PagedButtonsUI__SyncTrigger, slotPlayer, PagedButtonsUI_PREFIX, false)






        endif
        set slotPlayer=null
        set i=i + 1
    endloop
    call TriggerAddAction(PagedButtonsUI__SyncTrigger, function PagedButtonsUI__TriggerActionSyncData)
    
    call BlzLoadTOCFile(PagedButtonsUI_TOC_FILE)
    
    call PagedButtonsUI_CreateUI()
    
    call TriggerRegisterAnyUnitEventBJ(PagedButtonsUI__selectionTrigger, EVENT_PLAYER_UNIT_SELECTED)
    // Barade: Using trigger conditions with selection events led to weird behavior, so use a trigger action here.
    call TriggerAddAction(PagedButtonsUI__selectionTrigger, function PagedButtonsUI__TriggerActionSelected)
    
    call TriggerRegisterChangePagedButtons(PagedButtonsUI__changePageButtonsTrigger)
    call TriggerAddCondition(PagedButtonsUI__changePageButtonsTrigger, Condition(function PagedButtonsUI__TriggerConditionChangePage))
    
    call TriggerRegisterAnyUnitEventBJ(PagedButtonsUI__deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(PagedButtonsUI__deathTrigger, Condition(function PagedButtonsUI__TriggerConditionDeath))

    call PauseTimer(t)
    call DestroyTimer(t)
    set t=null
endfunction

function PagedButtonsUI__Init takes nothing returns nothing
    local integer i= 0
    loop
        exitwhen ( i >= PagedButtonsUI_MAX_SLOTS )
        set PagedButtonsUI__SlotClickTrigger[i]=null
        set PagedButtonsUI__SlotTooltipOnTrigger[i]=null
        set PagedButtonsUI__SlotTooltipOffTrigger[i]=null
        set i=i + 1
    endloop

    call TimerStart(CreateTimer(), 0.0, false, function PagedButtonsUI__TimerFunctionStart)
    call TriggerAddAction(FrameLoader__actionTrigger, (function PagedButtonsUI_CreateUI)) // INLINED!!
    call TriggerAddAction(FrameSaver__saveTrigger, (function HidePagedButtonsUI)) // INLINED!!



endfunction


//library PagedButtonsUI ends
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
//library Crafting:



//processed: function interface CraftingRequirementCallback takes integer recipe, unit craftingUnit returns integer


function GetCraftingStockUpdateTimerHandleId takes nothing returns integer
    return GetHandleId(Crafting___itemCraftingStockUpdateTimer)
endfunction

function Crafting___Index2D takes integer Value1,integer Value2,integer MaxValue2 returns integer
    return ( ( Value1 * MaxValue2 ) + Value2 )
endfunction

function GetRecipesMax takes nothing returns integer
    return Crafting___recipesCounter
endfunction

function GetRecipeItemTypeId takes integer recipe returns integer
    return Crafting___recipesItemTypeIds[recipe]
endfunction

function GetRecipeUIItemTypeId takes integer recipe returns integer
    return Crafting___recipesUIItemTypeIds[recipe]
endfunction

function AddRecipe takes integer itemTypeId,integer uiItemTypeId returns integer
    local integer index= Crafting___recipesCounter
    set Crafting___recipesItemTypeIds[index]=itemTypeId
    set Crafting___recipesUIItemTypeIds[index]=uiItemTypeId
    set Crafting___recipesIsUnit[index]=false
    set Crafting___recipesIsSpacer[index]=false
    set Crafting___recipesPageName[index]=""
    set Crafting___recipesMinRequirements[index]=0
    set Crafting___recipesRequirementCounters[index]=0
    set Crafting___recipesCounter=Crafting___recipesCounter + 1
    set Crafting___lastCreatedRecipe=index
    return index
endfunction

function AddRecipeRequirementItem takes integer recipe,integer itemTypeId,integer charges,boolean consume returns integer
    local integer counter= Crafting___recipesRequirementCounters[recipe]
    local integer index= Crafting___Index2D(recipe , counter , Crafting_MAX_REQUIREMENTS)
    set Crafting___recipesRequirementItemTypeIds[index]=itemTypeId
    set Crafting___recipesRequirementCharges[index]=charges
    set Crafting___recipesRequirementConsume[index]=consume
    set Crafting___recipesRequirementCounters[recipe]=counter + 1
    set Crafting___recipesMinRequirements[recipe]=counter + 1
    return counter
endfunction

function SetRecipeIsUnit takes integer recipe,boolean flag returns nothing
    set Crafting___recipesIsUnit[recipe]=flag
endfunction

function GetRecipeIsUnit takes integer recipe returns boolean
    return Crafting___recipesIsUnit[recipe]
endfunction

function SetRecipeIsSpacer takes integer recipe,boolean flag returns nothing
    set Crafting___recipesIsSpacer[recipe]=flag
endfunction

function GetRecipeIsSpacer takes integer recipe returns boolean
    return Crafting___recipesIsSpacer[recipe]
endfunction

function AddRecipeSpacer takes string pageName returns integer
    local integer recipe= AddRecipe(0 , 0)
    set Crafting___recipesIsSpacer[(recipe )]=( true) // INLINED!!
    set Crafting___recipesPageName[recipe]=pageName
    return recipe
endfunction

function SetRecipePageName takes integer recipe,string pageName returns nothing
    set Crafting___recipesPageName[recipe]=pageName
endfunction

function GetRecipeNotAvailableForPlayer takes integer recipe,integer playerId returns boolean
    local integer index= Crafting___Index2D(recipe , playerId , bj_MAX_PLAYERS)
    return Crafting___recipesNotAvailableForPlayer[index]
endfunction

function SetRecipeNotAvailableForPlayer takes integer recipe,integer playerId,boolean notAvailable returns nothing
    local integer index= Crafting___Index2D(recipe , playerId , bj_MAX_PLAYERS)
    set Crafting___recipesNotAvailableForPlayer[index]=notAvailable
endfunction

function GetRecipeAvailableForPlayer takes integer recipe,integer playerId returns boolean
    local integer index= Crafting___Index2D(recipe , playerId , bj_MAX_PLAYERS)
    return not Crafting___recipesNotAvailableForPlayer[index]
endfunction

function SetRecipeAvailableForPlayer takes integer recipe,integer playerId,boolean available returns nothing
    local integer index= Crafting___Index2D(recipe , playerId , bj_MAX_PLAYERS)
    set Crafting___recipesNotAvailableForPlayer[index]=not available
endfunction

function GetLastCreatedRecipe takes nothing returns integer
    return Crafting___lastCreatedRecipe
endfunction

function SetLastRecipePageName takes string pageName returns nothing
    set Crafting___recipesPageName[Crafting___lastCreatedRecipe]=pageName
endfunction

function GetRecipeRequirementsCount takes integer recipe returns integer
    return Crafting___recipesRequirementCounters[recipe]
endfunction

function GetRecipeRequirementItemTypeId takes integer recipe,integer requirement returns integer
    local integer index= Crafting___Index2D(recipe , requirement , Crafting_MAX_REQUIREMENTS)
    return Crafting___recipesRequirementItemTypeIds[index]
endfunction

function GetRecipeRequirementCharges takes integer recipe,integer requirement returns integer
    local integer index= Crafting___Index2D(recipe , requirement , Crafting_MAX_REQUIREMENTS)
    return Crafting___recipesRequirementCharges[index]
endfunction

function GetRecipeRequirementConsume takes integer recipe,integer requirement returns boolean
    local integer index= Crafting___Index2D(recipe , requirement , Crafting_MAX_REQUIREMENTS)
    return Crafting___recipesRequirementConsume[index]
endfunction

function GetRecipeMinRequirements takes integer recipe returns integer
    return Crafting___recipesMinRequirements[recipe]
endfunction

function SetRecipeMinRequirements takes integer recipe,integer minRequirements returns nothing
    set Crafting___recipesMinRequirements[recipe]=minRequirements
endfunction

function SetRecipeRequirementCallback takes integer callback returns nothing
    set Crafting___recipeRequirementCallback=callback
endfunction

function SetRecipeRequirementCallbackTrigger takes trigger callback returns nothing
    set Crafting___recipeRequirementCallbackTrigger=callback
endfunction

function SetRecipeShowCallbackTrigger takes trigger callback returns nothing
    set Crafting___recipeShowCallbackTrigger=callback
endfunction

function TriggerRegisterItemCraftingEvent takes trigger whichTrigger returns integer
    local integer counter= Crafting___craftingCallbackTriggersCounter
    set Crafting___craftingCallbackTriggers[counter]=whichTrigger
    set Crafting___craftingCallbackTriggersCounter=Crafting___craftingCallbackTriggersCounter + 1
    return counter
endfunction

function TriggerRegisterUnitCraftingEvent takes trigger whichTrigger returns integer
    local integer counter= Crafting___craftingCallbackUnitTriggersCounter
    set Crafting___craftingCallbackUnitTriggers[counter]=whichTrigger
    set Crafting___craftingCallbackUnitTriggersCounter=Crafting___craftingCallbackUnitTriggersCounter + 1
    return counter
endfunction

function TriggerRegisterItemDisassembleEvent takes trigger whichTrigger returns integer
    local integer counter= Crafting___disassembleCallbackTriggersCounter
    set Crafting___disassembleCallbackTriggers[counter]=whichTrigger
    set Crafting___disassembleCallbackTriggersCounter=Crafting___disassembleCallbackTriggersCounter + 1
    return counter
endfunction

function GetTriggerRecipe takes nothing returns integer
    return Crafting___triggerRecipe
endfunction

function GetTriggerCraftingUnit takes nothing returns unit
    return Crafting___triggerCraftingUnit
endfunction

function GetTriggerCraftedItem takes nothing returns item
    return Crafting___triggerCraftedItem
endfunction

function GetTriggerCraftedUnit takes nothing returns unit
    return Crafting___triggerCraftedUnit
endfunction

function GetTriggerCraftedCharges takes nothing returns integer
    return Crafting___triggerCraftedCharges
endfunction

function Crafting___ExecuteCraftingCallbacks takes integer recipe,unit craftingUnit,item craftedItem returns nothing
    local integer i= 0
    set Crafting___triggerRecipe=recipe
    set Crafting___triggerCraftingUnit=craftingUnit
    set Crafting___triggerCraftedItem=craftedItem
    loop
        exitwhen ( i == Crafting___craftingCallbackTriggersCounter )
        if ( IsTriggerEnabled(Crafting___craftingCallbackTriggers[i]) ) then
            call ConditionalTriggerExecute(Crafting___craftingCallbackTriggers[i])
        endif
        set i=i + 1
    endloop
endfunction

function Crafting___ExecuteCraftingCallbacksUnit takes integer recipe,unit craftingUnit,unit craftedUnit returns nothing
    local integer i= 0
    set Crafting___triggerRecipe=recipe
    set Crafting___triggerCraftingUnit=craftingUnit
    set Crafting___triggerCraftedUnit=craftedUnit
    loop
        exitwhen ( i == Crafting___craftingCallbackUnitTriggersCounter )
        if ( IsTriggerEnabled(Crafting___craftingCallbackUnitTriggers[i]) ) then
            call ConditionalTriggerExecute(Crafting___craftingCallbackUnitTriggers[i])
        endif
        set i=i + 1
    endloop
endfunction

function Crafting___ExecuteDisassembleCallbacks takes integer recipe,unit craftingUnit,item craftedItem,unit craftedUnit returns nothing
    local integer i= 0
    set Crafting___triggerRecipe=recipe
    set Crafting___triggerCraftingUnit=craftingUnit
    set Crafting___triggerCraftedItem=craftedItem
    set Crafting___triggerCraftedUnit=craftedUnit
    loop
        exitwhen ( i == Crafting___disassembleCallbackTriggersCounter )
        if ( IsTriggerEnabled(Crafting___disassembleCallbackTriggers[i]) ) then
            call ConditionalTriggerExecute(Crafting___disassembleCallbackTriggers[i])
        endif
        set i=i + 1
    endloop
endfunction

function GetRecipeByItemTypeId takes integer itemTypeId returns integer
    local integer counter= Crafting___recipesCounter
    local integer recipe= 0
    loop
        exitwhen ( recipe == counter )
        if ( Crafting___recipesItemTypeIds[recipe] == itemTypeId ) then
            return recipe
        endif
        set recipe=recipe + 1
    endloop
    return - 1
endfunction

function Crafting___SetItemCraftingUnitGroup takes unit whichUnit,group whichGroup returns nothing
    call SaveGroupHandle(Crafting___itemCraftingUnitsHashTable, GetHandleId(whichUnit), Crafting___HASHTABLE_KEY_GROUP, whichGroup)
endfunction

function Crafting___GetItemCraftingUnitGroup takes unit whichUnit returns group
    return LoadGroupHandle(Crafting___itemCraftingUnitsHashTable, GetHandleId(whichUnit), Crafting___HASHTABLE_KEY_GROUP)
endfunction

function IsItemCraftingRecipeEnabled takes unit whichUnit,integer recipe returns boolean
    local integer counter= LoadInteger(Crafting___itemCraftingUnitsHashTable, GetHandleId(whichUnit), Crafting___HASHTABLE_KEY_DISABLED_RECIPES)
    local integer disabledRecipe= 0
    local integer i= 0
    loop
        exitwhen ( i >= counter )
        set disabledRecipe=LoadInteger(Crafting___itemCraftingUnitsHashTable, GetHandleId(whichUnit), Crafting___HASHTABLE_KEY_DISABLED_RECIPES + i)
        if ( disabledRecipe == recipe ) then
            return false
        endif
        set i=i + 1
    endloop
    return true
endfunction

function GetRecipeName takes integer recipe returns string
    return GetObjectName(Crafting___recipesUIItemTypeIds[recipe])
endfunction

function Crafting___CheckRecipeRequirement takes integer recipe,integer requirement,unit whichUnit,integer craftedCharges returns integer
    local integer index= Crafting___Index2D(recipe , requirement , Crafting_MAX_REQUIREMENTS)
    local integer requiredItemTypeId= Crafting___recipesRequirementItemTypeIds[index]
    local integer requiredCharges= Crafting___recipesRequirementCharges[index]
    local integer matchingCharges= 0
    local item slotItem= null
    local integer i= 0
    local integer j= 0
    
    if ( requiredItemTypeId != 0 ) then
        //call BJDebugMsg("CheckRecipeRequirement for recipe " + GetRecipeName(recipe) + " with requirement item " + GetObjectName(requiredItemTypeId))
    
        loop
            exitwhen ( i == bj_MAX_INVENTORY )
            set slotItem=UnitItemInSlot(whichUnit, i)
            if ( slotItem != null and GetItemTypeId(slotItem) == requiredItemTypeId ) then
                // check the callback for each charge separately
                set j=0
                loop
                    exitwhen ( j == IMaxBJ(GetItemCharges(slotItem), 1) )
                    if ( Crafting___recipeRequirementCallbackTrigger != null ) then
                        set Crafting___triggerRecipe=recipe
                        set Crafting___triggerCraftingUnit=whichUnit
                        set Crafting___triggerCraftedItem=null
                        set Crafting___triggerCraftedCharges=craftedCharges + matchingCharges / requiredCharges
                        exitwhen ( not TriggerEvaluate(Crafting___recipeRequirementCallbackTrigger) )
                    endif
                    set matchingCharges=matchingCharges + 1
                    set j=j + 1
                endloop
                
                //call BJDebugMsg("CheckRecipeRequirement " + I2S(matchingCharges) + " for recipe " + GetRecipeName(recipe) + " with slot item " + GetItemName(slotItem))
            endif

            set slotItem=null
            set i=i + 1
        endloop
        //call BJDebugMsg("Checking recipe requirement for recipe " + GetRecipeName(recipe) + " with item type " + GetObjectName(requiredItemTypeId) + " and found charges: " + I2S(matchingCharges) + " resulting in " + I2S( matchingCharges / recipesRequirementCharges[index]))
        return matchingCharges / requiredCharges
    endif

    return 0
endfunction

function Crafting___ConsumeRecipeRequirement takes integer recipe,integer requirement,integer charges,unit whichUnit returns integer
    local integer index= Crafting___Index2D(recipe , requirement , Crafting_MAX_REQUIREMENTS)
    local integer requiredItemTypeId= Crafting___recipesRequirementItemTypeIds[index]
    local integer matchingCharges= 0
    local integer reducedCharges= 0
    local item slotItem= null
    local integer i= 0
    local group whichGroup= (LoadGroupHandle(Crafting___itemCraftingUnitsHashTable, GetHandleId((whichUnit)), Crafting___HASHTABLE_KEY_GROUP)) // INLINED!!
    local integer j= 0
    local unit groupUnit= null
    if ( requiredItemTypeId != 0 ) then
        set j=0
        loop
            exitwhen ( j >= BlzGroupGetSize(whichGroup) )
            set groupUnit=BlzGroupUnitAt(whichGroup, j)
            loop
                exitwhen ( i == bj_MAX_INVENTORY )
                set slotItem=UnitItemInSlot(groupUnit, i)
                if ( slotItem != null and GetItemTypeId(slotItem) == requiredItemTypeId ) then
                    set reducedCharges=charges * Crafting___recipesRequirementCharges[index]
                    set matchingCharges=matchingCharges + reducedCharges
                    //call BJDebugMsg("Consuming " + I2S(reducedCharges) + " of item " + GetItemName(slotItem) + " from unit " + GetUnitName(groupUnit) + ".")
                    set reducedCharges=GetItemCharges(slotItem) - reducedCharges
                    if ( reducedCharges > 0 ) then
                        call SetItemCharges(slotItem, reducedCharges)
                    else
                        call RemoveItem(slotItem)
                    endif
                endif
                set i=i + 1
            endloop
            set groupUnit=null
            set j=j + 1
        endloop
    endif

    set whichGroup=null

    return reducedCharges
endfunction

function Crafting___CheckRecipeRequirements takes integer recipe,unit whichUnit returns integer
    local integer requirementCheckCounter= 0
    local integer result= 0
    local boolean initResult= false
    local integer matchingRequirements= 0
    local integer minRequirements= Crafting___recipesMinRequirements[recipe]
    local integer counter= Crafting___recipesRequirementCounters[recipe]
    local integer i= 0
    local group whichGroup= (LoadGroupHandle(Crafting___itemCraftingUnitsHashTable, GetHandleId((whichUnit)), Crafting___HASHTABLE_KEY_GROUP)) // INLINED!!
    local player owner= GetOwningPlayer(whichUnit)
    local integer j= 0

    if ( Crafting___recipeRequirementCallback != 0 ) then
        set result=sc___prototype51_evaluate(Crafting___recipeRequirementCallback,recipe , whichUnit)
    endif

    loop
        exitwhen ( i >= counter or matchingRequirements >= minRequirements )
        set j=0
        loop
            exitwhen ( j >= BlzGroupGetSize(whichGroup) or matchingRequirements >= minRequirements )
            set requirementCheckCounter=Crafting___CheckRecipeRequirement(recipe , i , BlzGroupUnitAt(whichGroup, j) , result)

            if ( requirementCheckCounter > 0 ) then
                // TODO What if there is yet another requirement which has more charges?
                set matchingRequirements=matchingRequirements + 1
                if ( not initResult ) then // initially result is 0
                    set result=requirementCheckCounter
                else
                    set result=IMinBJ(result, requirementCheckCounter)
                endif
                
                //call BJDebugMsg("Checking recipe requirement for recipe " + GetRecipeName(recipe) + " and found charges: " + I2S(requirementCheckCounter) + " resulting in requirements matching " + I2S(matchingRequirements))
            endif
            //call BJDebugMsg("Result: " + I2S(result))
            set j=j + 1
        endloop
        set i=i + 1
    endloop
    set whichGroup=null
    
    // food check
    if ( (Crafting___recipesIsUnit[(recipe)]) ) then // INLINED!!
        set result=IMinBJ(( GetPlayerState(owner, PLAYER_STATE_RESOURCE_FOOD_CAP) - GetPlayerState(owner, PLAYER_STATE_RESOURCE_FOOD_USED) ) / GetFoodUsed(Crafting___recipesItemTypeIds[recipe]), result)
    endif
    
    set owner=null
    
    // make sure that it matches at least the number of minimum requirements is reached
    if ( matchingRequirements >= minRequirements ) then
        return result
    endif
    
    return 0
endfunction

function Crafting___ConsumeRecipeRequirements takes integer recipe,integer charges,unit whichUnit returns integer
    local integer result= 0
    local integer counter= Crafting___recipesRequirementCounters[recipe]
    local integer matchingRequirements= 0
    local integer minRequirements= Crafting___recipesMinRequirements[recipe]
    local integer consumedRequirements= 0
    local boolean consume= false
    local integer i= 0
    loop
        exitwhen ( i == counter or matchingRequirements >= minRequirements )
        set consume=GetRecipeRequirementConsume(recipe , i)
        if ( consume ) then
            set consumedRequirements=Crafting___ConsumeRecipeRequirement(recipe , i , charges , whichUnit)
            set result=result + consumedRequirements
        endif
        if ( consumedRequirements > 0 or not consume ) then
            set matchingRequirements=matchingRequirements + 1
        endif
        set i=i + 1
    endloop
    return result
endfunction

function GetRecipeByUIItemTypeId takes integer uIItemTypeId returns integer
    local integer counter= Crafting___recipesCounter
    local integer recipe= 0
    loop
        exitwhen ( recipe == counter )
        if ( Crafting___recipesUIItemTypeIds[recipe] == uIItemTypeId ) then
            return recipe
        endif
        set recipe=recipe + 1
    endloop
    return - 1
endfunction

function Crafting___CheckAllRecipesRequirementsForPageEx takes unit whichUnit,integer page returns integer
    local integer result= 0
    local integer requirementCheckCounter= 0
    local integer startSlot= page * Crafting_MAX_SLOTS
    local integer maxSlot= startSlot + Crafting_MAX_SLOTS
    local integer slot= startSlot
    local integer recipe= 0
    local group whichGroup= (LoadGroupHandle(Crafting___itemCraftingUnitsHashTable, GetHandleId((whichUnit)), Crafting___HASHTABLE_KEY_GROUP)) // INLINED!!
    local integer j= 0
    local unit groupUnit= null
    //call BJDebugMsg("Checking " + I2S(counter) + " recipes for unit " + GetUnitName(whichUnit) + " at page " + I2S(page) + " with " + I2S(recipesPerPage) + " recipes per page.")
    loop
        exitwhen ( slot >= maxSlot )
        if ( not (sg__PagedButtons_Type_get_whichType(GetPagedButton((whichUnit ) , ( slot))) == PagedButtons_BUTTON_TYPE_SPACER) ) then // INLINED!!
            set recipe=GetRecipeByUIItemTypeId(GetPagedButtonId(whichUnit , slot))
            if ( recipe != - 1 ) then
                set requirementCheckCounter=Crafting___CheckRecipeRequirements(recipe , whichUnit)
                //call BJDebugMsg("Get requirement counter " + I2S(requirementCheckCounter) + " and group size " + I2S(BlzGroupGetSize(whichGroup)))
                set j=0
                loop
                    exitwhen ( j >= BlzGroupGetSize(whichGroup) )
                    set groupUnit=BlzGroupUnitAt(whichGroup, j)
                    if ( IsItemCraftingRecipeEnabled(groupUnit , recipe) ) then
                        //call BJDebugMsg("Item crafting is enabled." )
                        if ( requirementCheckCounter > 0 ) then
                            set result=result + 1
                           
                            //call BJDebugMsg("Adding UI item type " + GetObjectName(recipesUIItemTypeIds[recipe]) + " to unit " + GetUnitName(groupUnit))
                            call RemoveItemFromStock(groupUnit, Crafting___recipesUIItemTypeIds[recipe])
                            //call BJDebugMsg("Crafted item: " + GetObjectName(recipesUIItemTypeIds[recipe]) + " with stock " + I2S(requirementCheckCounter))
                            // Even although this is 2 it becomes like 1 or something by the paged buttons system?
                            call AddItemToStock(groupUnit, Crafting___recipesUIItemTypeIds[recipe], requirementCheckCounter, requirementCheckCounter)
                        else
                            //call BJDebugMsg("Removing UI item type " + GetObjectName(recipesUIItemTypeIds[recipe]) + " from unit " + GetUnitName(groupUnit))
                            call RemoveItemFromStock(groupUnit, Crafting___recipesUIItemTypeIds[recipe])
                            call AddItemToStock(groupUnit, Crafting___recipesUIItemTypeIds[recipe], 0, 1)
                        endif
                    //else
                        //call BJDebugMsg("Item crafting is disabled." )
                    else
                        call SimError(GetOwningPlayer(whichUnit) , s__AFormat_result(s__AFormat_s((s__AFormat_create((GetLocalizedString("RECIPE_IS_DISABLED")))),(GetObjectName(Crafting___recipesUIItemTypeIds[(recipe)]))))) // INLINED!!
                    endif
                    set groupUnit=null
                    set j=j + 1
                endloop
            endif
        endif
        set slot=slot + 1
    endloop
    set whichGroup=null
    return result
endfunction


function Crafting___CheckAllRecipesRequirementsForPageNewOpLimit takes nothing returns nothing
    call Crafting___CheckAllRecipesRequirementsForPageEx(Crafting___tmpUnit , Crafting___tmpInteger0)
endfunction

function Crafting___CheckAllRecipesRequirementsForPage takes unit whichUnit,integer page returns nothing
    set Crafting___tmpUnit=whichUnit
    set Crafting___tmpInteger0=page
    call ForForce(bj_FORCE_PLAYER[0], (function Crafting___CheckAllRecipesRequirementsForPageNewOpLimit)) // INLINED!!
endfunction

function Crafting___UpdateStocks takes unit whichUnit returns nothing
    call Crafting___CheckAllRecipesRequirementsForPage(whichUnit , GetPagedButtonsPage(whichUnit))
endfunction

function Crafting___ClearItemCraftingUnit takes unit whichUnit returns nothing
    local group whichGroup= (LoadGroupHandle(Crafting___itemCraftingUnitsHashTable, GetHandleId((whichUnit)), Crafting___HASHTABLE_KEY_GROUP)) // INLINED!!
    if ( whichGroup != null ) then
        call GroupRemoveUnit(whichGroup, whichUnit)
        if ( BlzGroupGetSize(whichGroup) == 0 ) then
            call GroupClear(whichGroup)
            call DestroyGroup(whichGroup)
        endif
        set whichGroup=null
    endif

    call FlushChildHashtable(Crafting___itemCraftingUnitsHashTable, GetHandleId(whichUnit))
endfunction

function SetItemCraftingRecipeEnabled takes unit whichUnit,integer recipe,boolean enabled returns nothing
    local integer page= GetPagedButtonsPage(whichUnit)
    local integer counter= LoadInteger(Crafting___itemCraftingUnitsHashTable, GetHandleId(whichUnit), Crafting___HASHTABLE_KEY_DISABLED_RECIPES)
    local integer disabledRecipe= 0
    local boolean found= false
    local integer i= 0
    if ( enabled ) then
        loop
            exitwhen ( i >= counter )
            set disabledRecipe=LoadInteger(Crafting___itemCraftingUnitsHashTable, GetHandleId(whichUnit), Crafting___HASHTABLE_KEY_DISABLED_RECIPES + i)
            if ( found == true ) then
                call SaveInteger(Crafting___itemCraftingUnitsHashTable, GetHandleId(whichUnit), Crafting___HASHTABLE_KEY_DISABLED_RECIPES + i - 1, disabledRecipe)
            endif
            if ( disabledRecipe == recipe ) then
                set found=true
            endif
            set i=i + 1
        endloop
        if ( found ) then
            call SaveInteger(Crafting___itemCraftingUnitsHashTable, GetHandleId(whichUnit), Crafting___HASHTABLE_KEY_DISABLED_RECIPES, counter - 1)
        endif
    else
        loop
            exitwhen ( i >= counter )
            set disabledRecipe=LoadInteger(Crafting___itemCraftingUnitsHashTable, GetHandleId(whichUnit), Crafting___HASHTABLE_KEY_DISABLED_RECIPES + i)
            if ( disabledRecipe == recipe ) then
                set found=true
            endif
            set i=i + 1
        endloop
        if ( not found ) then
            call SaveInteger(Crafting___itemCraftingUnitsHashTable, GetHandleId(whichUnit), Crafting___HASHTABLE_KEY_DISABLED_RECIPES + counter, recipe)
            call SaveInteger(Crafting___itemCraftingUnitsHashTable, GetHandleId(whichUnit), Crafting___HASHTABLE_KEY_DISABLED_RECIPES, counter + 1)
        endif
    endif
    call Crafting___CheckAllRecipesRequirementsForPage(whichUnit , page)
endfunction

function CraftItem takes item soldItem,unit sellingUnit,unit buyingUnit returns item
    local integer page= GetPagedButtonsPage(sellingUnit)
    local integer soldItemTypeId= GetItemTypeId(soldItem)
    local player owner= GetOwningPlayer(sellingUnit)
    local player ownerBuying= GetOwningPlayer(buyingUnit)
    local integer playerIdBuying= GetPlayerId(ownerBuying)
    local integer charges= 0
    local integer chargesWithFoodLimit= 0
    local integer availableFood= 0
    local item craftedItem= null
    local unit craftedUnit= null
    local item array additionalCraftedItems
    local integer additionalCraftedItemsCounter= 0
    local integer counter= Crafting___recipesCounter
    local integer j= 0
    local integer recipe= 0
    loop
        exitwhen ( recipe >= counter and craftedItem != null )
        if ( not (Crafting___recipesIsSpacer[(recipe)]) and Crafting___recipesUIItemTypeIds[recipe] == soldItemTypeId ) then // INLINED!!
            if ( GetRecipeAvailableForPlayer(recipe , playerIdBuying) ) then
                set charges=Crafting___CheckRecipeRequirements(recipe , sellingUnit)
                if ( charges > 0 ) then
                    call RemoveItem(soldItem)
                    set soldItem=null
                    
                    if ( (Crafting___recipesIsUnit[(recipe)]) ) then // INLINED!!
                        set availableFood=GetPlayerState(owner, PLAYER_STATE_RESOURCE_FOOD_CAP) - GetPlayerState(owner, PLAYER_STATE_RESOURCE_FOOD_USED)
                        set chargesWithFoodLimit=availableFood / GetFoodUsed(Crafting___recipesItemTypeIds[recipe])
                        set chargesWithFoodLimit=IMinBJ(chargesWithFoodLimit, charges)
                        if ( chargesWithFoodLimit > 0 ) then
                            if ( chargesWithFoodLimit < charges ) then
                                call SimError(owner , s__AFormat_result(s__AFormat_i((s__AFormat_create((GetLocalizedString("CAN_ONLY_SUMMON_FOOD_LIMIT")))),chargesWithFoodLimit))) // INLINED!!
                            endif
                        
                            set j=0
                            loop
                                exitwhen ( j >= chargesWithFoodLimit )
                                set craftedUnit=CreateUnit(owner, Crafting___recipesItemTypeIds[recipe], GetUnitX(sellingUnit), GetUnitY(sellingUnit), GetUnitFacing(sellingUnit))
                                call Crafting___ExecuteCraftingCallbacksUnit(recipe , sellingUnit , craftedUnit)
                                set j=j + 1
                            endloop

                            call Crafting___ConsumeRecipeRequirements(recipe , chargesWithFoodLimit , sellingUnit)
                        else
                            call SimError(owner , GetLocalizedString("NOT_ENOUGH_FOOD"))
                        endif
                    else
                        set craftedItem=CreateItem(Crafting___recipesItemTypeIds[recipe], GetUnitX(sellingUnit), GetUnitY(sellingUnit))
                        
                        if ( GetItemCharges(craftedItem) > 0 ) then
                            call SetItemCharges(craftedItem, charges)
                            call Crafting___ExecuteCraftingCallbacks(recipe , sellingUnit , craftedItem)
                        // create non charged items separately
                        else
                            call Crafting___ExecuteCraftingCallbacks(recipe , sellingUnit , craftedItem)
                            
                            set j=1
                            loop
                                exitwhen ( j >= charges )
                                set craftedItem=CreateItem(Crafting___recipesItemTypeIds[recipe], GetUnitX(sellingUnit), GetUnitY(sellingUnit))
                                call Crafting___ExecuteCraftingCallbacks(recipe , sellingUnit , craftedItem)
                                set additionalCraftedItems[additionalCraftedItemsCounter]=craftedItem
                                set additionalCraftedItemsCounter=additionalCraftedItemsCounter + 1
                                set j=j + 1
                            endloop
                        endif
                        
                        call Crafting___ConsumeRecipeRequirements(recipe , charges , sellingUnit)
                        
                        // add item after callbacks since it might lead to stacking and the crafted item may become null
                        // call ite also after consuming requirements since the inventory might have more slots now
                        call UnitAddItem(sellingUnit, craftedItem)
                        set j=0
                        loop
                            exitwhen ( j >= additionalCraftedItemsCounter )
                            call UnitAddItem(sellingUnit, additionalCraftedItems[j]) // TODO Drops the item next to the crafting unit.
                            set j=j + 1
                        endloop
                        
                    endif
                endif
            else
                call SimError(ownerBuying , s__AFormat_result(s__AFormat_s((s__AFormat_create((GetLocalizedString("X_IS_NOT_AVAILABLE")))),GetObjectName(Crafting___recipesItemTypeIds[recipe])))) // INLINED!!
            endif
        endif
        set recipe=recipe + 1
    endloop
    call Crafting___CheckAllRecipesRequirementsForPage(sellingUnit , page) // update all stocks but after crafting something we might need some delay to update stocks.
    set owner=null
    set ownerBuying=null
    return craftedItem
endfunction

function Crafting___ForGroupUpdateStocks takes nothing returns nothing
    call Crafting___UpdateStocks(GetEnumUnit())
endfunction

function Crafting___UpdateAllStocks takes nothing returns nothing
    call ForGroup(Crafting___itemCraftingUnits, function Crafting___ForGroupUpdateStocks)
endfunction

function Crafting___ShowRecipeForUnit takes integer recipe,unit whichUnit returns boolean
    if ( Crafting___recipeShowCallbackTrigger != null and IsTriggerEnabled(Crafting___recipeShowCallbackTrigger) ) then
        set Crafting___triggerRecipe=recipe
        set Crafting___triggerCraftingUnit=whichUnit
        return TriggerEvaluate(Crafting___recipeShowCallbackTrigger)
    endif
    return true
endfunction

function EnableItemCraftingUnit takes unit whichUnit returns nothing
    local integer playerId= GetPlayerId(GetOwningPlayer(whichUnit))
    local integer i= 0
    local integer index= 0
    local group whichGroup= CreateGroup()
    call GroupAddUnit(whichGroup, whichUnit)
    call GroupAddUnit(Crafting___itemCraftingUnits, whichUnit)
    call SaveGroupHandle(Crafting___itemCraftingUnitsHashTable, GetHandleId((whichUnit )), Crafting___HASHTABLE_KEY_GROUP, ( whichGroup)) // INLINED!!
    //call BJDebugMsg("Enable crafting for unit " + GetUnitName(whichUnit))
    call EnablePagedButtons(whichUnit)
    call SetPagedButtonsSlotsPerPage(whichUnit , Crafting_MAX_SLOTS)
    set i=0
    loop
        exitwhen ( i == Crafting___recipesCounter )
        //call BJDebugMsg("Recipe " + I2S(i) + ": " + GetObjectName(recipesUIItemTypeIds[i]))
        if ( GetRecipeAvailableForPlayer(i , playerId) and Crafting___ShowRecipeForUnit(i , whichUnit) ) then
            if ( Crafting___recipesIsSpacer[i] ) then
                call SetPagedButtonsCurrentPageName(whichUnit , Crafting___recipesPageName[i])
                call AddPagedButtonsSpacersRemaining(whichUnit)
            else
                if ( Crafting___recipesPageName[i] != null and StringLength(Crafting___recipesPageName[i]) > 0 ) then
                    call SetPagedButtonsCurrentPageName(whichUnit , Crafting___recipesPageName[i])
                endif
                set index=(AddPagedButtonsId((whichUnit ) , ( Crafting___recipesUIItemTypeIds[i]) , PagedButtons_BUTTON_TYPE_ITEM)) // INLINED!!
                call sg__PagedButtons_SlotType_set_replenish((GetPagedButton(whichUnit , index)),false) // prevents auto replenish
            endif
        endif
        set i=i + 1
    endloop
    //call CheckAllRecipesRequirementsForPage(whichUnit, 0, PagedButtonsSystem_SLOTS_PER_PAGE)

    if ( BlzGroupGetSize(Crafting___itemCraftingUnits) == 1 ) then
        // This timer is required since we can only set the maximum time to 3600 seconds.
        call TimerStart(Crafting___itemCraftingStockUpdateTimer, Crafting_UPDATE_INTERVAL, true, function Crafting___UpdateAllStocks)
    endif
endfunction

function IsItemCraftingUnitEnabled takes unit whichUnit returns boolean
    return IsUnitInGroup(whichUnit, Crafting___itemCraftingUnits)
endfunction

function DisableItemCraftingUnit takes unit whichUnit returns boolean
    if ( (IsUnitInGroup((whichUnit), Crafting___itemCraftingUnits)) ) then // INLINED!!
        call GroupRemoveUnit(Crafting___itemCraftingUnits, whichUnit)
        call DisablePagedButtons(whichUnit)

        call Crafting___ClearItemCraftingUnit(whichUnit)

        if ( BlzGroupGetSize(Crafting___itemCraftingUnits) == 0 ) then
            call PauseTimer(Crafting___itemCraftingStockUpdateTimer)
        endif
        
        return true
    endif
    return false
endfunction

function LinkItemCraftingUnitInventories takes unit whichUnit0,unit whichUnit1 returns group
    local group whichGroup0= (LoadGroupHandle(Crafting___itemCraftingUnitsHashTable, GetHandleId((whichUnit0)), Crafting___HASHTABLE_KEY_GROUP)) // INLINED!!
    local group whichGroup1= (LoadGroupHandle(Crafting___itemCraftingUnitsHashTable, GetHandleId((whichUnit1)), Crafting___HASHTABLE_KEY_GROUP)) // INLINED!!
    local integer i= 0

    if ( whichGroup0 == null ) then
        set whichGroup0=CreateGroup()
        call GroupAddUnit(whichGroup0, whichUnit0)
    endif

    if ( whichGroup1 == null ) then
        set whichGroup1=CreateGroup()
        call GroupAddUnit(whichGroup1, whichUnit1)
    endif

    if ( whichGroup0 != null and whichGroup1 != null ) then
        call GroupAddGroup(whichGroup1, whichGroup0)

        set i=0
        loop
            exitwhen ( i == BlzGroupGetSize(whichGroup0) )
            call SaveGroupHandle(Crafting___itemCraftingUnitsHashTable, GetHandleId((BlzGroupUnitAt(whichGroup0, i) )), Crafting___HASHTABLE_KEY_GROUP, ( whichGroup0)) // INLINED!!
            set i=i + 1
        endloop
        call GroupClear(whichGroup1)
        call DestroyGroup(whichGroup1)
        set whichGroup1=null
    endif
    
    call Crafting___UpdateStocks(whichUnit0)
    call Crafting___UpdateStocks(whichUnit1)

    return whichGroup0
endfunction

function LinkItemCraftingGroupInventories takes group source returns group
    local unit first= FirstOfGroup(source)
    local integer i= 1
    if ( first != null ) then
        loop
            exitwhen ( i == BlzGroupGetSize(source) )
            call LinkItemCraftingUnitInventories(BlzGroupUnitAt(source, i) , first)
            set i=i + 1
        endloop
        set first=null
        return (LoadGroupHandle(Crafting___itemCraftingUnitsHashTable, GetHandleId((first)), Crafting___HASHTABLE_KEY_GROUP)) // INLINED!!
    endif
    return null
endfunction

function UnlinkItemCraftingUnitInventories takes unit whichUnit0,unit whichUnit1 returns group
    local group whichGroup0= (LoadGroupHandle(Crafting___itemCraftingUnitsHashTable, GetHandleId((whichUnit0)), Crafting___HASHTABLE_KEY_GROUP)) // INLINED!!
    local group whichGroup1= (LoadGroupHandle(Crafting___itemCraftingUnitsHashTable, GetHandleId((whichUnit1)), Crafting___HASHTABLE_KEY_GROUP)) // INLINED!!

    if ( whichGroup0 != null ) then
        call GroupRemoveUnit(whichGroup0, whichUnit1)
    endif

    if ( whichGroup1 != null and IsUnitInGroup(whichUnit1, whichGroup1) ) then
        call GroupRemoveUnit(whichGroup1, whichUnit1)
        if ( BlzGroupGetSize(whichGroup1) == 0 ) then
            call GroupClear(whichGroup1)
            call DestroyGroup(whichGroup1)
            set whichGroup1=null
        endif
    endif

    set whichGroup1=CreateGroup()
    call GroupAddUnit(whichGroup1, whichUnit1)

    call SaveGroupHandle(Crafting___itemCraftingUnitsHashTable, GetHandleId((whichUnit1 )), Crafting___HASHTABLE_KEY_GROUP, ( whichGroup1)) // INLINED!!
    
    call Crafting___UpdateStocks(whichUnit0)
    call Crafting___UpdateStocks(whichUnit1)

    return whichGroup1
endfunction

function ItemCraftingUnitInventoriesAreLinked takes unit whichUnit0,unit whichUnit1 returns boolean
    local group whichGroup0= (LoadGroupHandle(Crafting___itemCraftingUnitsHashTable, GetHandleId((whichUnit0)), Crafting___HASHTABLE_KEY_GROUP)) // INLINED!!

    return IsUnitInGroup(whichUnit1, whichGroup0)
endfunction

function Crafting___TriggerConditionIsItemCraftingUnitEnabled takes nothing returns boolean
    return (IsUnitInGroup((GetTriggerUnit()), Crafting___itemCraftingUnits)) // INLINED!!
endfunction

function Crafting___TriggerActionCheckAllRecipesRequirements takes nothing returns nothing
    //call BJDebugMsg("Crafter " + GetUnitName(GetTriggerUnit()) + " picks up or drops an item.")
    call Crafting___UpdateStocks(GetTriggerUnit())
endfunction

function Crafting___TriggerActionCheckAllRecipesRequirementsDelayed takes nothing returns nothing
    //call BJDebugMsg("Crafter " + GetUnitName(GetTriggerUnit()) + " picks up or drops an item.")
    local unit triggerUnit= GetTriggerUnit()
    call TriggerSleepAction(0.0) // wait until item has been dropped
    call Crafting___UpdateStocks(triggerUnit)
    set triggerUnit=null
endfunction

function Crafting___TriggerActionCraftItem takes nothing returns nothing
    local unit shop= GetSellingUnit()
    call CraftItem(GetSoldItem() , shop , GetBuyingUnit())
    call TriggerSleepAction(0.0) // wait until we can refresh the stock
    call Crafting___UpdateStocks(shop)
    set shop=null
endfunction

function Crafting___TriggerConditionDisassemble takes nothing returns boolean
    return GetSpellAbilityId() == Crafting_DISASSEMBLE_ABILITY_ID
endfunction

function DisassembleItem takes item soldItem,unit sellingUnit returns integer
    local integer recipe= GetRecipeByItemTypeId(GetItemTypeId(soldItem))
    local integer i= 0
    local integer max= 0
    local integer count= IMaxBJ(GetItemCharges(soldItem), 1)
    local integer charges= 0
    local item requirement= null
    local integer minRequirements= 0
    local integer result= 0
    
    if ( recipe != - 1 ) then
        call Crafting___ExecuteDisassembleCallbacks(recipe , sellingUnit , soldItem , null)
        call RemoveItem(soldItem)
        set soldItem=null
        set i=0
        set max=(Crafting___recipesRequirementCounters[(recipe)]) // INLINED!!
        set minRequirements=(Crafting___recipesMinRequirements[(recipe)]) // INLINED!!
        loop
            exitwhen ( i == max or ( minRequirements > 0 and i > minRequirements ) )
            set requirement=CreateItem(GetRecipeRequirementItemTypeId(recipe , i), GetUnitX(sellingUnit), GetUnitY(sellingUnit))
            set charges=GetRecipeRequirementCharges(recipe , i) * count
            if ( GetItemCharges(requirement) > 0 or charges > 1 ) then
                call SetItemCharges(requirement, charges)
            endif
            call UnitAddItem(sellingUnit, requirement)
            set result=result + charges
            set i=i + 1
        endloop
    endif
    
    return result
endfunction

function DisassembleUnit takes unit target,unit sellingUnit returns integer
    local integer recipe= GetRecipeByItemTypeId(GetUnitTypeId(target))
    local integer i= 0
    local integer max= 0
    local integer count= 1
    local integer charges= 0
    local item requirement= null
    local integer minRequirements= 0
    local integer result= 0
    
    if ( recipe != - 1 ) then
        call Crafting___ExecuteDisassembleCallbacks(recipe , sellingUnit , null , target)
        call h__RemoveUnit(target)
        set target=null
        set i=0
        set max=(Crafting___recipesRequirementCounters[(recipe)]) // INLINED!!
        set minRequirements=(Crafting___recipesMinRequirements[(recipe)]) // INLINED!!
        loop
            exitwhen ( i == max or ( minRequirements > 0 and i > minRequirements ) )
            set requirement=CreateItem(GetRecipeRequirementItemTypeId(recipe , i), GetUnitX(sellingUnit), GetUnitY(sellingUnit))
            set charges=GetRecipeRequirementCharges(recipe , i) * count
            if ( GetItemCharges(requirement) > 0 or charges > 1 ) then
                call SetItemCharges(requirement, charges)
            endif
            call UnitAddItem(sellingUnit, requirement)
            set result=result + charges
            set i=i + 1
        endloop
    endif
    
    return result
endfunction

function Crafting___TriggerActionDisassembleItem takes nothing returns nothing
    local unit sellingUnit= GetTriggerUnit()
    local unit target= GetSpellTargetUnit()
    local item targetItem= GetSpellTargetItem()
    local item slotItem= null
    local integer counter= 0
    local integer i= 0
    if ( target != null ) then
        if ( (IsUnitInGroup((target), Crafting___itemCraftingUnits)) and GetOwningPlayer(sellingUnit) == GetOwningPlayer(target) ) then // INLINED!!
            loop
                exitwhen ( i == bj_MAX_INVENTORY )
                set slotItem=UnitItemInSlot(sellingUnit, i)
                if ( slotItem != null ) then
                    set counter=counter + DisassembleItem(slotItem , sellingUnit)
                endif
                set slotItem=null
                set i=i + 1
            endloop
            if ( counter == 0 ) then
                call SimError(GetOwningPlayer(sellingUnit) , GetLocalizedString("NO_ITEMS_TO_DISASSEMBLE"))
            endif
        else
            set counter=DisassembleUnit(target , sellingUnit)
            if ( counter == 0 ) then
                call SimError(GetOwningPlayer(sellingUnit) , GetLocalizedString("CANNOT_BE_DISASSEMBLED"))
            endif
        endif
    elseif ( targetItem != null ) then
        set counter=DisassembleItem(targetItem , sellingUnit)
        if ( counter == 0 ) then
            call SimError(GetOwningPlayer(sellingUnit) , GetLocalizedString("CANNOT_BE_DISASSEMBLED"))
        endif
    endif
    set sellingUnit=null
    set target=null
    set targetItem=null
endfunction

function Crafting___TriggerConditionChangePage takes nothing returns boolean
    return (IsUnitInGroup(((PagedButtons__triggerShop)), Crafting___itemCraftingUnits)) // INLINED!!
endfunction

function Crafting___TriggerActionChangePage takes nothing returns nothing
    call Crafting___UpdateStocks((PagedButtons__triggerShop)) // INLINED!!
endfunction

function Crafting___TriggerConditionTrainStart takes nothing returns boolean
    call ForGroup(Crafting___itemCraftingUnits, function Crafting___ForGroupUpdateStocks) // INLINED!!
    return false
endfunction
    
function Crafting___TriggerConditionTrainCancel takes nothing returns boolean
    call ForGroup(Crafting___itemCraftingUnits, function Crafting___ForGroupUpdateStocks) // INLINED!!
    return false
endfunction
    
function Crafting___TriggerConditionReviveStart takes nothing returns boolean
    call ForGroup(Crafting___itemCraftingUnits, function Crafting___ForGroupUpdateStocks) // INLINED!!
    return false
endfunction
    
function Crafting___TriggerConditionReviveCancel takes nothing returns boolean
    call ForGroup(Crafting___itemCraftingUnits, function Crafting___ForGroupUpdateStocks) // INLINED!!
    return false
endfunction
    
function Crafting___TriggerConditionSell takes nothing returns boolean
    call ForGroup(Crafting___itemCraftingUnits, function Crafting___ForGroupUpdateStocks) // INLINED!!
    return false
endfunction
    
function Crafting___TriggerConditionDeath takes nothing returns boolean
    call ForGroup(Crafting___itemCraftingUnits, function Crafting___ForGroupUpdateStocks) // INLINED!!
    return false
endfunction

function Crafting___Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(Crafting___pickupTrigger, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(Crafting___pickupTrigger, Condition(function Crafting___TriggerConditionIsItemCraftingUnitEnabled))
    call TriggerAddAction(Crafting___pickupTrigger, function Crafting___TriggerActionCheckAllRecipesRequirements)
    
    call TriggerRegisterAnyUnitEventBJ(Crafting___dropTrigger, EVENT_PLAYER_UNIT_DROP_ITEM)
    call TriggerAddCondition(Crafting___dropTrigger, Condition(function Crafting___TriggerConditionIsItemCraftingUnitEnabled))
    call TriggerAddAction(Crafting___dropTrigger, function Crafting___TriggerActionCheckAllRecipesRequirementsDelayed)

    call TriggerRegisterAnyUnitEventBJ(Crafting___itemCraftTrigger, EVENT_PLAYER_UNIT_SELL_ITEM)
    call TriggerAddCondition(Crafting___itemCraftTrigger, Condition(function Crafting___TriggerConditionIsItemCraftingUnitEnabled))
    call TriggerAddAction(Crafting___itemCraftTrigger, function Crafting___TriggerActionCraftItem)
    
    call TriggerRegisterAnyUnitEventBJ(Crafting___itemDisassembleTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(Crafting___itemDisassembleTrigger, Condition(function Crafting___TriggerConditionDisassemble))
    call TriggerAddAction(Crafting___itemDisassembleTrigger, function Crafting___TriggerActionDisassembleItem)

    call TriggerRegisterChangePagedButtons(Crafting___itemCraftingChangePageTrigger)
    call TriggerAddCondition(Crafting___itemCraftingChangePageTrigger, Condition(function Crafting___TriggerConditionChangePage))
    call TriggerAddAction(Crafting___itemCraftingChangePageTrigger, function Crafting___TriggerActionChangePage)
    
    // update food available
    call TriggerRegisterAnyUnitEventBJ(Crafting___trainStartTrigger, EVENT_PLAYER_UNIT_TRAIN_START)
    call TriggerAddCondition(Crafting___trainStartTrigger, Condition(function Crafting___TriggerConditionTrainStart))
    
    call TriggerRegisterAnyUnitEventBJ(Crafting___trainCancelTrigger, EVENT_PLAYER_UNIT_TRAIN_CANCEL)
    call TriggerAddCondition(Crafting___trainCancelTrigger, Condition(function Crafting___TriggerConditionTrainCancel))
    
    call TriggerRegisterAnyUnitEventBJ(Crafting___reviveStartTrigger, EVENT_PLAYER_HERO_REVIVE_START)
    call TriggerAddCondition(Crafting___reviveStartTrigger, Condition(function Crafting___TriggerConditionReviveStart))
    
    call TriggerRegisterAnyUnitEventBJ(Crafting___reviveCancelTrigger, EVENT_PLAYER_HERO_REVIVE_CANCEL)
    call TriggerAddCondition(Crafting___reviveCancelTrigger, Condition(function Crafting___TriggerConditionReviveCancel))
    
    call TriggerRegisterAnyUnitEventBJ(Crafting___sellTrigger, EVENT_PLAYER_UNIT_SELL)
    call TriggerAddCondition(Crafting___sellTrigger, Condition(function Crafting___TriggerConditionSell))
    
    call TriggerRegisterAnyUnitEventBJ(Crafting___deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(Crafting___deathTrigger, Condition(function Crafting___TriggerConditionDeath))
endfunction

//processed hook: hook RemoveUnit DisableItemCraftingUnit


//library Crafting ends
//library MapCrafting:

function AddRecipeItem takes nothing returns integer
    set udg_TmpInteger=AddRecipe(udg_TmpItemType , udg_TmpItemType2)
    set udg_TmpInteger2=1
    return udg_TmpInteger
endfunction

function AddRecipeUnit takes nothing returns integer
    set udg_TmpInteger=AddRecipe(udg_TmpUnitType , udg_TmpItemType2)
    set Crafting___recipesIsUnit[(udg_TmpInteger )]=( true) // INLINED!!
    set udg_TmpInteger2=1
    return udg_TmpInteger
endfunction

function AddRecipeRequirement takes nothing returns integer
    local integer requirement= AddRecipeRequirementItem(udg_TmpInteger , udg_TmpItemType , udg_TmpInteger2 , true)
    set udg_TmpInteger2=1
    return requirement
endfunction

function AddRecipeRequirementNonConsuming takes nothing returns integer
    local integer requirement= AddRecipeRequirementItem(udg_TmpInteger , udg_TmpItemType , udg_TmpInteger2 , false)
    set udg_TmpInteger2=1
    return requirement
endfunction

function SetRecipeMinRequirementsCount takes nothing returns nothing
    set Crafting___recipesMinRequirements[(udg_TmpInteger )]=( udg_TmpInteger2) // INLINED!!
    set udg_TmpInteger2=1
endfunction

function AddRecipePage takes nothing returns nothing
    call AddRecipeSpacer(udg_TmpString)
endfunction

function GetAlliesWithSharedControl takes player whichPlayer returns force
    local force allies= CreateForce()
    local player slotPlayer= null
    local integer i= 0
    loop
        exitwhen ( i == bj_MAX_PLAYERS )
        set slotPlayer=Player(i)
        if ( GetPlayerAlliance(whichPlayer, slotPlayer, ALLIANCE_SHARED_CONTROL) ) then
            call ForceAddPlayer(allies, slotPlayer)
        endif
        set slotPlayer=null
        set i=i + 1
    endloop
    return allies
endfunction
           
function CraftHint takes unit whichUnit returns nothing
    local force allies= GetAlliesWithSharedControl(GetOwningPlayer(whichUnit))
    if ( IsPlayerInForce(GetLocalPlayer(), allies) ) then
        call StartSound(bj_questHintSound)
        call PingMinimap(GetUnitX(whichUnit), GetUnitY(whichUnit), 3.0)
    endif
    call ForceClear(allies)
    call DestroyForce(allies)
    set allies=null
endfunction

function MapRecipeRequirementCallback takes integer recipe,unit craftingUnit returns integer
    if ( recipe == udg_RecipeVictoryPotion and GetOwningPlayer(craftingUnit) == Player(0) ) then
        return 1
    elseif ( recipe == udg_RecipeDefeatPotion and GetOwningPlayer(craftingUnit) == Player(1) ) then
        return 1
    endif
    return 0
endfunction


//library MapCrafting ends
//===========================================================================
// 
// Baradé's Crafting 1.0
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
    set udg_TmpInteger=0
    set udg_TmpInteger2=0
    set udg_TmpString=""
    set udg_RecipeVictoryPotion=0
    set udg_RecipeDefeatPotion=0
endfunction

//***************************************************************************
//*
//*  Custom Script Code
//*
//***************************************************************************
//***************************************************************************
//*  SimError
//***************************************************************************
//*  FrameLoader vjass

//***************************************************************************
//*  FrameSaver

//***************************************************************************
//*  Barades Op Limit
//***************************************************************************
//*  Barades Item Type Utils
//***************************************************************************
//*  Barades String Utils
//***************************************************************************
//*  Barades String Format
//***************************************************************************
//*  Barades Paged Buttons
//***************************************************************************
//*  Barades Paged Buttons UI



//***************************************************************************
//*  Barades Crafting
//***************************************************************************
//*  Map Crafting

//***************************************************************************
//*
//*  Items
//*
//***************************************************************************

function CreateAllItems takes nothing returns nothing
    local integer itemID

    call BlzCreateItemWithSkin('I001', - 2603.0, 551.8, 'I001')
    call BlzCreateItemWithSkin('I001', - 2353.4, 678.4, 'I001')
    call BlzCreateItemWithSkin('I001', - 2480.3, 691.5, 'I001')
    call BlzCreateItemWithSkin('I001', - 2488.9, 550.8, 'I001')
    call BlzCreateItemWithSkin('I001', - 2360.2, 560.1, 'I001')
    call BlzCreateItemWithSkin('I001', - 2213.9, 559.5, 'I001')
    call BlzCreateItemWithSkin('I001', - 2238.0, 807.2, 'I001')
    call BlzCreateItemWithSkin('I001', - 2367.4, 817.7, 'I001')
    call BlzCreateItemWithSkin('I001', - 2493.8, 805.1, 'I001')
    call BlzCreateItemWithSkin('I001', - 2509.0, 929.3, 'I001')
    call BlzCreateItemWithSkin('I001', - 2377.1, 934.3, 'I001')
    call BlzCreateItemWithSkin('I001', - 2236.4, 937.7, 'I001')
    call BlzCreateItemWithSkin('I001', - 2594.4, 692.4, 'I001')
    call BlzCreateItemWithSkin('I001', - 2077.7, 699.2, 'I001')
    call BlzCreateItemWithSkin('I001', - 2607.9, 806.0, 'I001')
    call BlzCreateItemWithSkin('I001', - 2623.1, 930.3, 'I001')
    call BlzCreateItemWithSkin('I001', - 709.7, 966.3, 'I001')
    call BlzCreateItemWithSkin('I001', - 850.4, 963.0, 'I001')
    call BlzCreateItemWithSkin('I001', - 982.3, 958.0, 'I001')
    call BlzCreateItemWithSkin('I001', - 967.1, 833.7, 'I001')
    call BlzCreateItemWithSkin('I001', - 840.6, 846.3, 'I001')
    call BlzCreateItemWithSkin('I001', - 711.3, 835.8, 'I001')
    call BlzCreateItemWithSkin('I001', - 687.1, 588.2, 'I001')
    call BlzCreateItemWithSkin('I001', - 833.5, 588.7, 'I001')
    call BlzCreateItemWithSkin('I001', - 962.1, 579.5, 'I001')
    call BlzCreateItemWithSkin('I001', - 953.5, 720.2, 'I001')
    call BlzCreateItemWithSkin('I001', - 826.7, 707.1, 'I001')
    call BlzCreateItemWithSkin('I001', - 703.8, 703.5, 'I001')
    call BlzCreateItemWithSkin('I001', - 1096.4, 958.9, 'I001')
    call BlzCreateItemWithSkin('I001', - 1081.2, 834.7, 'I001')
    call BlzCreateItemWithSkin('I001', - 1076.3, 580.4, 'I001')
    call BlzCreateItemWithSkin('I001', - 1067.6, 721.1, 'I001')
    call BlzCreateItemWithSkin('I001', - 1218.2, 952.7, 'I001')
    call BlzCreateItemWithSkin('I001', - 1358.9, 949.4, 'I001')
    call BlzCreateItemWithSkin('I001', - 1490.8, 944.4, 'I001')
    call BlzCreateItemWithSkin('I001', - 1475.6, 820.2, 'I001')
    call BlzCreateItemWithSkin('I001', - 1349.1, 832.8, 'I001')
    call BlzCreateItemWithSkin('I001', - 1219.8, 822.3, 'I001')
    call BlzCreateItemWithSkin('I001', - 1195.6, 574.6, 'I001')
    call BlzCreateItemWithSkin('I001', - 1342.0, 575.2, 'I001')
    call BlzCreateItemWithSkin('I001', - 1470.6, 565.9, 'I001')
    call BlzCreateItemWithSkin('I001', - 1462.0, 706.6, 'I001')
    call BlzCreateItemWithSkin('I001', - 1335.2, 693.5, 'I001')
    call BlzCreateItemWithSkin('I001', - 1212.3, 690.0, 'I001')
    call BlzCreateItemWithSkin('I001', - 1604.9, 945.4, 'I001')
    call BlzCreateItemWithSkin('I001', - 1589.7, 821.1, 'I001')
    call BlzCreateItemWithSkin('I001', - 1584.8, 566.9, 'I001')
    call BlzCreateItemWithSkin('I001', - 1576.1, 707.5, 'I001')
    call BlzCreateItemWithSkin('I001', - 1719.8, 944.4, 'I001')
    call BlzCreateItemWithSkin('I001', - 1860.5, 941.1, 'I001')
    call BlzCreateItemWithSkin('I001', - 1992.4, 936.1, 'I001')
    call BlzCreateItemWithSkin('I001', - 1977.2, 811.8, 'I001')
    call BlzCreateItemWithSkin('I001', - 1850.7, 824.4, 'I001')
    call BlzCreateItemWithSkin('I001', - 1721.4, 813.9, 'I001')
    call BlzCreateItemWithSkin('I001', - 1697.2, 566.3, 'I001')
    call BlzCreateItemWithSkin('I001', - 1843.6, 566.8, 'I001')
    call BlzCreateItemWithSkin('I001', - 1972.2, 557.6, 'I001')
    call BlzCreateItemWithSkin('I001', - 1963.6, 698.3, 'I001')
    call BlzCreateItemWithSkin('I001', - 1836.8, 685.2, 'I001')
    call BlzCreateItemWithSkin('I001', - 1713.9, 681.6, 'I001')
    call BlzCreateItemWithSkin('I001', - 2106.5, 937.0, 'I001')
    call BlzCreateItemWithSkin('I001', - 2091.3, 812.8, 'I001')
    call BlzCreateItemWithSkin('I001', - 2086.3, 558.5, 'I001')
    call BlzCreateItemWithSkin('I001', - 2230.5, 674.9, 'I001')
    call BlzCreateItemWithSkin('dtsb', - 571.2, - 580.3, 'dtsb')
    call BlzCreateItemWithSkin('dtsb', - 703.9, - 581.3, 'dtsb')
    call BlzCreateItemWithSkin('dtsb', - 823.0, - 577.3, 'dtsb')
    call BlzCreateItemWithSkin('dtsb', - 949.6, - 569.3, 'dtsb')
    call BlzCreateItemWithSkin('dtsb', - 949.4, - 725.1, 'dtsb')
    call BlzCreateItemWithSkin('dtsb', - 812.6, - 723.2, 'dtsb')
    call BlzCreateItemWithSkin('dtsb', - 690.3, - 721.3, 'dtsb')
    call BlzCreateItemWithSkin('dtsb', - 566.2, - 721.3, 'dtsb')
    call BlzCreateItemWithSkin('dtsb', - 565.5, - 857.0, 'dtsb')
    call BlzCreateItemWithSkin('dtsb', - 694.2, - 847.9, 'dtsb')
    call BlzCreateItemWithSkin('dtsb', - 811.8, - 853.3, 'dtsb')
    call BlzCreateItemWithSkin('dtsb', - 950.5, - 844.2, 'dtsb')
    call BlzCreateItemWithSkin('rde0', 1335.7, 924.4, 'rde0')
    call BlzCreateItemWithSkin('rde0', - 312.3, 702.1, 'rde0')
    call BlzCreateItemWithSkin('rde0', - 318.3, 822.9, 'rde0')
    call BlzCreateItemWithSkin('rde0', - 311.2, 940.6, 'rde0')
    call BlzCreateItemWithSkin('rde0', 198.0, 574.5, 'rde0')
    call BlzCreateItemWithSkin('rde0', 193.9, 696.8, 'rde0')
    call BlzCreateItemWithSkin('rde0', 187.9, 817.6, 'rde0')
    call BlzCreateItemWithSkin('rde0', 195.0, 935.3, 'rde0')
    call BlzCreateItemWithSkin('rde0', 318.6, 924.9, 'rde0')
    call BlzCreateItemWithSkin('rde0', 310.0, 811.8, 'rde0')
    call BlzCreateItemWithSkin('rde0', 319.7, 688.8, 'rde0')
    call BlzCreateItemWithSkin('rde0', 316.3, 566.0, 'rde0')
    call BlzCreateItemWithSkin('rde0', - 187.7, 930.2, 'rde0')
    call BlzCreateItemWithSkin('rde0', - 196.2, 817.1, 'rde0')
    call BlzCreateItemWithSkin('rde0', - 186.6, 694.1, 'rde0')
    call BlzCreateItemWithSkin('rde0', - 189.9, 571.3, 'rde0')
    call BlzCreateItemWithSkin('rde0', 1846.3, 562.0, 'rde0')
    call BlzCreateItemWithSkin('rde0', 1849.6, 684.9, 'rde0')
    call BlzCreateItemWithSkin('rde0', 1840.0, 807.9, 'rde0')
    call BlzCreateItemWithSkin('rde0', 1848.5, 920.9, 'rde0')
    call BlzCreateItemWithSkin('rde0', 702.7, 574.7, 'rde0')
    call BlzCreateItemWithSkin('rde0', 698.6, 697.0, 'rde0')
    call BlzCreateItemWithSkin('rde0', 692.6, 817.8, 'rde0')
    call BlzCreateItemWithSkin('rde0', 699.6, 935.5, 'rde0')
    call BlzCreateItemWithSkin('rde0', 823.2, 925.1, 'rde0')
    call BlzCreateItemWithSkin('rde0', 814.7, 812.0, 'rde0')
    call BlzCreateItemWithSkin('rde0', 824.3, 689.0, 'rde0')
    call BlzCreateItemWithSkin('rde0', 821.0, 566.2, 'rde0')
    call BlzCreateItemWithSkin('rde0', 1725.0, 931.4, 'rde0')
    call BlzCreateItemWithSkin('rde0', 1717.9, 813.6, 'rde0')
    call BlzCreateItemWithSkin('rde0', 1723.9, 692.8, 'rde0')
    call BlzCreateItemWithSkin('rde0', 1728.0, 570.5, 'rde0')
    call BlzCreateItemWithSkin('rde0', 1333.4, 565.5, 'rde0')
    call BlzCreateItemWithSkin('rde0', 1336.8, 688.3, 'rde0')
    call BlzCreateItemWithSkin('rde0', 1327.1, 811.3, 'rde0')
    call BlzCreateItemWithSkin('rde0', - 308.2, 579.8, 'rde0')
    call BlzCreateItemWithSkin('rde0', 1215.2, 574.0, 'rde0')
    call BlzCreateItemWithSkin('rde0', 1211.1, 696.3, 'rde0')
    call BlzCreateItemWithSkin('rde0', 1205.1, 817.1, 'rde0')
    call BlzCreateItemWithSkin('rde0', 1212.1, 934.8, 'rde0')
    call BlzCreateItemWithSkin('rde3', 567.6, 559.0, 'rde3')
    call BlzCreateItemWithSkin('rde3', 438.7, 564.3, 'rde3')
    call BlzCreateItemWithSkin('rde3', 437.8, 692.0, 'rde3')
    call BlzCreateItemWithSkin('rde3', 573.5, 689.0, 'rde3')
    call BlzCreateItemWithSkin('rde3', 1083.3, 940.8, 'rde3')
    call BlzCreateItemWithSkin('rde3', 965.1, 928.1, 'rde3')
    call BlzCreateItemWithSkin('rde3', 954.3, 812.7, 'rde3')
    call BlzCreateItemWithSkin('rde3', 1071.8, 811.4, 'rde3')
    call BlzCreateItemWithSkin('rde3', 1085.9, 688.3, 'rde3')
    call BlzCreateItemWithSkin('rde3', 950.3, 691.3, 'rde3')
    call BlzCreateItemWithSkin('rde3', 951.2, 563.7, 'rde3')
    call BlzCreateItemWithSkin('rde3', 1080.0, 558.4, 'rde3')
    call BlzCreateItemWithSkin('rde3', 559.4, 812.1, 'rde3')
    call BlzCreateItemWithSkin('rde3', 441.8, 813.4, 'rde3')
    call BlzCreateItemWithSkin('rde3', 452.6, 928.8, 'rde3')
    call BlzCreateItemWithSkin('rde3', 570.9, 941.5, 'rde3')
    call BlzCreateItemWithSkin('rde3', 62.9, 558.9, 'rde3')
    call BlzCreateItemWithSkin('rde3', - 65.9, 564.2, 'rde3')
    call BlzCreateItemWithSkin('rde3', - 66.8, 691.8, 'rde3')
    call BlzCreateItemWithSkin('rde3', 68.8, 688.8, 'rde3')
    call BlzCreateItemWithSkin('rde3', 1596.2, 937.3, 'rde3')
    call BlzCreateItemWithSkin('rde3', 1477.9, 924.7, 'rde3')
    call BlzCreateItemWithSkin('rde3', 1467.1, 809.2, 'rde3')
    call BlzCreateItemWithSkin('rde3', 1584.7, 807.9, 'rde3')
    call BlzCreateItemWithSkin('rde3', 1598.8, 684.8, 'rde3')
    call BlzCreateItemWithSkin('rde3', 1463.2, 687.9, 'rde3')
    call BlzCreateItemWithSkin('rde3', 1464.1, 560.2, 'rde3')
    call BlzCreateItemWithSkin('rde3', 1592.9, 554.9, 'rde3')
    call BlzCreateItemWithSkin('rde3', - 451.5, 817.2, 'rde3')
    call BlzCreateItemWithSkin('rde3', - 569.1, 818.5, 'rde3')
    call BlzCreateItemWithSkin('rde3', - 558.3, 933.9, 'rde3')
    call BlzCreateItemWithSkin('rde3', - 440.0, 946.6, 'rde3')
    call BlzCreateItemWithSkin('rde3', 54.7, 811.9, 'rde3')
    call BlzCreateItemWithSkin('rde3', - 62.9, 813.2, 'rde3')
    call BlzCreateItemWithSkin('rde3', - 52.1, 928.6, 'rde3')
    call BlzCreateItemWithSkin('rde3', 66.2, 941.3, 'rde3')
    call BlzCreateItemWithSkin('rde3', - 437.4, 694.1, 'rde3')
    call BlzCreateItemWithSkin('rde3', - 573.0, 697.1, 'rde3')
    call BlzCreateItemWithSkin('rde3', - 572.1, 569.5, 'rde3')
    call BlzCreateItemWithSkin('rde3', - 443.3, 564.2, 'rde3')
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

    set u=BlzCreateUnitWithSkin(p, 'n000', - 320.0, - 64.0, 270.000, 'n000')
    set u=BlzCreateUnitWithSkin(p, 'hhou', - 576.0, 64.0, 270.000, 'hhou')
    set u=BlzCreateUnitWithSkin(p, 'hhou', - 576.0, - 128.0, 270.000, 'hhou')
    set u=BlzCreateUnitWithSkin(p, 'hhou', - 768.0, - 128.0, 270.000, 'hhou')
    set u=BlzCreateUnitWithSkin(p, 'hhou', - 768.0, 64.0, 270.000, 'hhou')
    set u=BlzCreateUnitWithSkin(p, 'hhou', - 960.0, 64.0, 270.000, 'hhou')
    set u=BlzCreateUnitWithSkin(p, 'hhou', - 960.0, - 128.0, 270.000, 'hhou')
endfunction

//===========================================================================
function CreateUnitsForPlayer0 takes nothing returns nothing
    local player p= Player(0)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'Hpal', - 73.3, - 19.7, 270.000, 'Hpal')
    call SetHeroLevel(u, 10, false)
    call SetUnitState(u, UNIT_STATE_MANA, 495)
    call SelectHeroSkill(u, 'AHhb')
    call SelectHeroSkill(u, 'AHhb')
    call SelectHeroSkill(u, 'AHhb')
    call SelectHeroSkill(u, 'AHds')
    call SelectHeroSkill(u, 'AHds')
    call SelectHeroSkill(u, 'AHds')
    call SelectHeroSkill(u, 'AHad')
    call SelectHeroSkill(u, 'AHad')
    call SelectHeroSkill(u, 'AHad')
    call SelectHeroSkill(u, 'AHre')
endfunction

//===========================================================================
function CreateBuildingsForPlayer1 takes nothing returns nothing
    local player p= Player(1)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'n000', 320.0, - 64.0, 270.000, 'n000')
    set u=BlzCreateUnitWithSkin(p, 'hhou', 512.0, 64.0, 270.000, 'hhou')
    set u=BlzCreateUnitWithSkin(p, 'hhou', 512.0, - 128.0, 270.000, 'hhou')
    set u=BlzCreateUnitWithSkin(p, 'hhou', 704.0, 64.0, 270.000, 'hhou')
    set u=BlzCreateUnitWithSkin(p, 'hhou', 704.0, - 128.0, 270.000, 'hhou')
    set u=BlzCreateUnitWithSkin(p, 'hhou', 896.0, 64.0, 270.000, 'hhou')
    set u=BlzCreateUnitWithSkin(p, 'hhou', 896.0, - 128.0, 270.000, 'hhou')
endfunction

//===========================================================================
function CreateUnitsForPlayer1 takes nothing returns nothing
    local player p= Player(1)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'Hpal', 66.1, - 25.3, 270.000, 'Hpal')
    call SetHeroLevel(u, 10, false)
    call SetUnitState(u, UNIT_STATE_MANA, 495)
    call SelectHeroSkill(u, 'AHhb')
    call SelectHeroSkill(u, 'AHhb')
    call SelectHeroSkill(u, 'AHhb')
    call SelectHeroSkill(u, 'AHds')
    call SelectHeroSkill(u, 'AHds')
    call SelectHeroSkill(u, 'AHds')
    call SelectHeroSkill(u, 'AHad')
    call SelectHeroSkill(u, 'AHad')
    call SelectHeroSkill(u, 'AHad')
    call SelectHeroSkill(u, 'AHre')
endfunction

//===========================================================================
function CreateNeutralPassiveBuildings takes nothing returns nothing
    local player p= Player(PLAYER_NEUTRAL_PASSIVE)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'ntav', 0.0, 320.0, 270.000, 'ntav')
    call SetUnitColor(u, ConvertPlayerColor(0))
    set u=BlzCreateUnitWithSkin(p, 'n000', 0.0, - 640.0, 270.000, 'n000')
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
//*  Regions
//*
//***************************************************************************

function CreateRegions takes nothing returns nothing
    local weathereffect we

    set gg_rct_Shop_Dummy=Rect(- 3136.0, 2880.0, - 3104.0, 2912.0)
endfunction

//***************************************************************************
//*
//*  Triggers
//*
//***************************************************************************

//===========================================================================
// Trigger: Crafting Init Recipes
//
// Add all recipes of the map into this trigger.
//===========================================================================
function Trig_Crafting_Init_Recipes_Actions takes nothing returns nothing
    // ###########################
    set udg_TmpItemType='rde4'
    set udg_TmpItemType2='I000'
    call AddRecipeItem()
    set udg_TmpItemType='rde0'
    call AddRecipeRequirement()
    set udg_TmpItemType='rde3'
    call AddRecipeRequirement()
    // ###########################
    set udg_TmpString="Rings"
    call AddRecipeSpacer(udg_TmpString) // INLINED!!
    // ###########################
    set udg_TmpUnitType='nrdr'
    set udg_TmpItemType2='I002'
    call AddRecipeUnit()
    set udg_TmpItemType='I001'
    set udg_TmpInteger2=3
    call AddRecipeRequirement()
    // ###########################
    set udg_TmpString="Dragons"
    call AddRecipeSpacer(udg_TmpString) // INLINED!!
    // ###########################
    set udg_TmpItemType='I004'
    set udg_TmpItemType2='I003'
    call AddRecipeItem()
    set udg_RecipeVictoryPotion=udg_TmpInteger
    call SetRecipeNotAvailableForPlayer(udg_RecipeDefeatPotion , 1 , true)
    call SetRecipeNotAvailableForPlayer(udg_RecipeDefeatPotion , PLAYER_NEUTRAL_PASSIVE , true)
    // ###########################
    set udg_TmpItemType='I006'
    set udg_TmpItemType2='I007'
    call AddRecipeItem()
    set udg_RecipeDefeatPotion=udg_TmpInteger
    call SetRecipeNotAvailableForPlayer(udg_RecipeDefeatPotion , 0 , true)
    call SetRecipeNotAvailableForPlayer(udg_RecipeDefeatPotion , PLAYER_NEUTRAL_PASSIVE , true)
    // ###########################
    set udg_TmpString="Potions"
    call AddRecipeSpacer(udg_TmpString) // INLINED!!
    // ###########################
    set udg_TmpItemType='sbok'
    set udg_TmpItemType2='I005'
    call AddRecipeItem()
    set udg_TmpItemType='dtsb'
    call AddRecipeRequirementNonConsuming()
    // ###########################
    set udg_TmpString="Unique"
    call AddRecipeSpacer(udg_TmpString) // INLINED!!
    // ###########################
endfunction

//===========================================================================
function InitTrig_Crafting_Init_Recipes takes nothing returns nothing
    set gg_trg_Crafting_Init_Recipes=CreateTrigger()
    call TriggerAddAction(gg_trg_Crafting_Init_Recipes, function Trig_Crafting_Init_Recipes_Actions)
endfunction

//===========================================================================
// Trigger: Crafting Start
//
// TODO Use without leak.
//===========================================================================
function Trig_Crafting_Start_Func007A takes nothing returns nothing
    call EnableItemCraftingUnit(GetEnumUnit())
endfunction

function Trig_Crafting_Start_Actions takes nothing returns nothing
    call TriggerRegisterItemCraftingEvent(gg_trg_Crafting_On_Crafting_Item)
    call TriggerRegisterUnitCraftingEvent(gg_trg_Crafting_On_Crafting_Unit)
    call TriggerRegisterItemDisassembleEvent(gg_trg_Crafting_On_Disassemble_Item)
    set Crafting___recipeRequirementCallbackTrigger=(gg_trg_Crafting_On_Requirement) // INLINED!!
    set Crafting___recipeShowCallbackTrigger=(gg_trg_Crafting_On_Show) // INLINED!!
    set Crafting___recipeRequirementCallback=((1)) // INLINED!!
    call ForGroupBJ(GetUnitsOfTypeIdAll('n000'), function Trig_Crafting_Start_Func007A)
endfunction

//===========================================================================
function InitTrig_Crafting_Start takes nothing returns nothing
    set gg_trg_Crafting_Start=CreateTrigger()
    call TriggerRegisterTimerEventSingle(gg_trg_Crafting_Start, 0.00)
    call TriggerAddAction(gg_trg_Crafting_Start, function Trig_Crafting_Start_Actions)
endfunction

//===========================================================================
// Trigger: Crafting On Crafting Item
//
// Gives some feedback to the player when crafting items.
//===========================================================================
function Trig_Crafting_On_Crafting_Item_Actions takes nothing returns nothing
    set udg_TmpUnit=(Crafting___triggerCraftingUnit) // INLINED!!
    set udg_TmpItem=(Crafting___triggerCraftedItem) // INLINED!!
    call CraftHint(udg_TmpUnit)
endfunction

//===========================================================================
function InitTrig_Crafting_On_Crafting_Item takes nothing returns nothing
    set gg_trg_Crafting_On_Crafting_Item=CreateTrigger()
    call TriggerAddAction(gg_trg_Crafting_On_Crafting_Item, function Trig_Crafting_On_Crafting_Item_Actions)
endfunction

//===========================================================================
// Trigger: Crafting On Crafting Unit
//
// Gives some feedback to the player when crafting units.
//===========================================================================
function Trig_Crafting_On_Crafting_Unit_Actions takes nothing returns nothing
    set udg_TmpUnit=(Crafting___triggerCraftingUnit) // INLINED!!
    set udg_TmpUnit2=(Crafting___triggerCraftedUnit) // INLINED!!
    call CraftHint(udg_TmpUnit)
endfunction

//===========================================================================
function InitTrig_Crafting_On_Crafting_Unit takes nothing returns nothing
    set gg_trg_Crafting_On_Crafting_Unit=CreateTrigger()
    call TriggerAddAction(gg_trg_Crafting_On_Crafting_Unit, function Trig_Crafting_On_Crafting_Unit_Actions)
endfunction

//===========================================================================
// Trigger: Crafting On Disassemble Item
//
// Gives some feedback to the player when disassembling items.
//===========================================================================
function Trig_Crafting_On_Disassemble_Item_Actions takes nothing returns nothing
    set udg_TmpUnit=(Crafting___triggerCraftingUnit) // INLINED!!
    set udg_TmpItem=(Crafting___triggerCraftedItem) // INLINED!!
    call CraftHint(udg_TmpUnit)
endfunction

//===========================================================================
function InitTrig_Crafting_On_Disassemble_Item takes nothing returns nothing
    set gg_trg_Crafting_On_Disassemble_Item=CreateTrigger()
    call TriggerAddAction(gg_trg_Crafting_On_Disassemble_Item, function Trig_Crafting_On_Disassemble_Item_Actions)
endfunction

//===========================================================================
// Trigger: Crafting On Requirement
//===========================================================================
function Trig_Crafting_On_Requirement_Conditions takes nothing returns boolean
    return true
endfunction

//===========================================================================
function InitTrig_Crafting_On_Requirement takes nothing returns nothing
    set gg_trg_Crafting_On_Requirement=CreateTrigger()
    call TriggerAddCondition(gg_trg_Crafting_On_Requirement, Condition(function Trig_Crafting_On_Requirement_Conditions))
endfunction


//===========================================================================
// Trigger: Crafting On Show
//===========================================================================
function Trig_Crafting_On_Show_Conditions takes nothing returns boolean
    local unit craftingUnit= (Crafting___triggerCraftingUnit) // INLINED!!
    local integer recipe= (Crafting___triggerRecipe) // INLINED!!
    local integer unitTypeId= GetUnitTypeId(craftingUnit)
    return true
endfunction

function Trig_Crafting_On_Show_Actions takes nothing returns nothing
    
endfunction

//===========================================================================
function InitTrig_Crafting_On_Show takes nothing returns nothing
    set gg_trg_Crafting_On_Show=CreateTrigger()
    call TriggerAddCondition(gg_trg_Crafting_On_Show, Condition(function Trig_Crafting_On_Show_Conditions))
endfunction


//===========================================================================
// Trigger: Initialization
//===========================================================================
function Trig_Initialization_Actions takes nothing returns nothing
    call MeleeStartingVisibility()
    call MeleeStartingHeroLimit()
    call BlzLoadTOCFile("war3mapImported\\Crafting.toc")
endfunction

//===========================================================================
function InitTrig_Initialization takes nothing returns nothing
    set gg_trg_Initialization=CreateTrigger()
    call TriggerAddAction(gg_trg_Initialization, function Trig_Initialization_Actions)
endfunction

//===========================================================================
// Trigger: Game Start
//===========================================================================
function Trig_Game_Start_Func006A takes nothing returns nothing
    call SetPlayerAllianceBJ(GetEnumPlayer(), ALLIANCE_SHARED_SPELLS, true, Player(PLAYER_NEUTRAL_PASSIVE))
    call AdjustPlayerStateBJ(500000, GetEnumPlayer(), PLAYER_STATE_RESOURCE_GOLD)
    call AdjustPlayerStateBJ(500000, GetEnumPlayer(), PLAYER_STATE_RESOURCE_LUMBER)
endfunction

function Trig_Game_Start_Actions takes nothing returns nothing
    call SetMapFlag(MAP_FOG_MAP_EXPLORED, true)
    call SetMapFlag(MAP_FOG_ALWAYS_VISIBLE, true)
    call FogMaskEnableOff()
    call FogEnableOff()
    call ForForce(GetPlayersAll(), function Trig_Game_Start_Func006A)
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_030")
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_031")
endfunction

//===========================================================================
function InitTrig_Game_Start takes nothing returns nothing
    set gg_trg_Game_Start=CreateTrigger()
    call TriggerRegisterTimerEventSingle(gg_trg_Game_Start, 0.00)
    call TriggerAddAction(gg_trg_Game_Start, function Trig_Game_Start_Actions)
endfunction

//===========================================================================
// Trigger: Potion of Victory
//===========================================================================
function Trig_Potion_of_Victory_Conditions takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I004' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Potion_of_Victory_Actions takes nothing returns nothing
    call CustomVictoryBJ(GetOwningPlayer(GetTriggerUnit()), true, true)
endfunction

//===========================================================================
function InitTrig_Potion_of_Victory takes nothing returns nothing
    set gg_trg_Potion_of_Victory=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Potion_of_Victory, EVENT_PLAYER_UNIT_USE_ITEM)
    call TriggerAddCondition(gg_trg_Potion_of_Victory, Condition(function Trig_Potion_of_Victory_Conditions))
    call TriggerAddAction(gg_trg_Potion_of_Victory, function Trig_Potion_of_Victory_Actions)
endfunction

//===========================================================================
// Trigger: Potion of Defeat
//===========================================================================
function Trig_Potion_of_Defeat_Conditions takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I006' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Potion_of_Defeat_Actions takes nothing returns nothing
    call CustomDefeatBJ(GetOwningPlayer(GetTriggerUnit()), "TRIGSTR_106")
endfunction

//===========================================================================
function InitTrig_Potion_of_Defeat takes nothing returns nothing
    set gg_trg_Potion_of_Defeat=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Potion_of_Defeat, EVENT_PLAYER_UNIT_USE_ITEM)
    call TriggerAddCondition(gg_trg_Potion_of_Defeat, Condition(function Trig_Potion_of_Defeat_Conditions))
    call TriggerAddAction(gg_trg_Potion_of_Defeat, function Trig_Potion_of_Defeat_Actions)
endfunction

//===========================================================================
function InitCustomTriggers takes nothing returns nothing
    call InitTrig_Crafting_Init_Recipes()
    call InitTrig_Crafting_Start()
    call InitTrig_Crafting_On_Crafting_Item()
    call InitTrig_Crafting_On_Crafting_Unit()
    call InitTrig_Crafting_On_Disassemble_Item()
    call InitTrig_Crafting_On_Requirement()
    call InitTrig_Crafting_On_Show()
    call InitTrig_Initialization()
    call InitTrig_Game_Start()
    call InitTrig_Potion_of_Victory()
    call InitTrig_Potion_of_Defeat()
endfunction

//===========================================================================
function RunInitializationTriggers takes nothing returns nothing
    call ConditionalTriggerExecute(gg_trg_Crafting_Init_Recipes)
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
    call SetPlayerRacePreference(Player(0), RACE_PREF_RANDOM)
    call SetPlayerRaceSelectable(Player(0), true)
    call SetPlayerController(Player(0), MAP_CONTROL_USER)

    // Player 1
    call SetPlayerStartLocation(Player(1), 1)
    call ForcePlayerStartLocation(Player(1), 1)
    call SetPlayerColor(Player(1), ConvertPlayerColor(1))
    call SetPlayerRacePreference(Player(1), RACE_PREF_RANDOM)
    call SetPlayerRaceSelectable(Player(1), true)
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
    call CreateRegions()
    call CreateAllItems()
    call CreateAllUnits()
    call InitBlizzard()

call ExecuteFunc("jasshelper__initstructs450553125")
call ExecuteFunc("FrameLoader__init_function")
call ExecuteFunc("FrameSaver__Init")
call ExecuteFunc("PagedButtons__Init")
call ExecuteFunc("SimError__Init")
call ExecuteFunc("PagedButtonsUI__Init")
call ExecuteFunc("Crafting___Init")

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
    call SetMapName("TRIGSTR_003")
    call SetMapDescription("TRIGSTR_029")
    call SetPlayers(2)
    call SetTeams(2)
    call SetGamePlacement(MAP_PLACEMENT_TEAMS_TOGETHER)

    call DefineStartLocation(0, 0.0, - 64.0)
    call DefineStartLocation(1, 0.0, - 64.0)

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
function sa___prototype22_DisablePagedButtons takes nothing returns boolean
    set f__result_boolean=DisablePagedButtons(f__arg_unit1)
    return true
endfunction
function sa___prototype22_DisableItemCraftingUnit takes nothing returns boolean
    set f__result_boolean=DisableItemCraftingUnit(f__arg_unit1)
    return true
endfunction
function sa___prototype51_MapRecipeRequirementCallback takes nothing returns boolean
    set f__result_integer=MapRecipeRequirementCallback(f__arg_integer1,f__arg_unit1)
    return true
endfunction

function jasshelper__initstructs450553125 takes nothing returns nothing
    set st__PagedButtons_Type_onDestroy[1]=null
    set st__PagedButtons_Type_onDestroy[3]=CreateTrigger()
    call TriggerAddCondition(st__PagedButtons_Type_onDestroy[3],Condition( function sa__PagedButtons_SlotType_onDestroy))
    set st__PagedButtons_Type_onDestroy[2]=CreateTrigger()
    call TriggerAddCondition(st__PagedButtons_Type_onDestroy[2],Condition( function sa__PagedButtons_SpacerType_onDestroy))
    set st___prototype22[1]=CreateTrigger()
    call TriggerAddAction(st___prototype22[1],function sa___prototype22_DisablePagedButtons)
    call TriggerAddCondition(st___prototype22[1],Condition(function sa___prototype22_DisablePagedButtons))
    set st___prototype22[2]=CreateTrigger()
    call TriggerAddAction(st___prototype22[2],function sa___prototype22_DisableItemCraftingUnit)
    call TriggerAddCondition(st___prototype22[2],Condition(function sa___prototype22_DisableItemCraftingUnit))
    set st___prototype51[1]=CreateTrigger()
    call TriggerAddAction(st___prototype51[1],function sa___prototype51_MapRecipeRequirementCallback)
    call TriggerAddCondition(st___prototype51[1],Condition(function sa___prototype51_MapRecipeRequirementCallback))










endfunction

