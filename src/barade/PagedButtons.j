library PagedButtons initializer Init requires optional PagedButtonsConfig
/*
Baradé's Paged Buttons System 1.6

Allows using multiple pages of command buttons in shops for unit and items which can be purchased.
Changing the pages is also done by purchasing units to change to the next or previous page.
This helps to reduce the number of shop buildings while providing a huge number of units and items to be purchased.
The page is shown for all players together in multiplayer.

Usage:

call EnablePagedButtons(shop)

call NextPagedButtonsPage(shop, "Page 1")
call AddPagedButtonsUnitType(shop, 'nrdr')
call AddPagedButtonsItemType(shop, 'stwp')

call NextPagedButtonsPage(shop, "Page 2")
call AddPagedButtonsUnitType(shop, 'nrwm')
call AddPagedButtonsItemType(shop, 'dust')

###################################################################################################

API:

###################################################################################################

function GetPagedButtonsShop takes unit shop returns Shop

###################################################################################################

function SetPagedButtonsShop takes unit shop, Shop s returns nothing

###################################################################################################

function GetPagedButtonsCount takes unit shop returns integer

Returns the number of paged buttons for the given shop.

###################################################################################################

function GetPagedButtonsNonSpaceButtonsCount takes unit shop returns integer

Returns the number of paged buttons which are not spaces for the given shop.

###################################################################################################

function GetPagedButton takes unit shop, integer index returns Type

Returns the page button data for the given shop at the given index.

###################################################################################################

function GetPagedButtonIndex takes unit shop, integer id returns integer

Returns the page button index for the given shop at the given ID.
Returns -1 if it does not exist.

###################################################################################################

function GetPagedButtonIndexEx takes unit shop, integer id, integer index returns integer

Returns the page button index for the given shop at the given ID with the given index.
This can be useful if the ID exists multiple times.
Returns -1 if it does not exist.

###################################################################################################

function GetPagedButtonsCountEx takes unit shop, integer id returns integer

Returns the number of paged buttons with the given ID for the given shop.
Returns 0 if the given ID is not part of the given shop.

###################################################################################################

function IsPagedButtonShown takes unit shop, integer index returns boolean

###################################################################################################

function IsPagedButtonEnabled takes unit shop, integer index returns boolean

Returns true if the button is enabled which means it is shown when its page is shown.
Otherwise, it returns false which means that the button won't be shown when its page is shown.

###################################################################################################

function SetPagedButtonEnabled takes unit shop, integer index, boolean enabled returns nothing

###################################################################################################

function GetPagedButtonId takes unit shop, integer index returns integer

###################################################################################################

function IsPagedButtonUnit takes unit shop, integer index returns boolean

Returns true if the paged button is a unit type. Otherwise, it returns false.

###################################################################################################

function IsPagedButtonItem takes unit shop, integer index returns boolean

Returns true if the paged button is an item type. Otherwise, it returns false.

###################################################################################################

function IsPagedButtonAbility takes unit shop, integer index returns boolean

Returns true if the paged button is an ability. Otherwise, it returns false.

###################################################################################################

function IsPagedButtonSpacer takes unit shop, integer index returns boolean

Returns true if the paged button is a spacer. Otherwise, it returns false.

###################################################################################################

function GetPagedButtonType takes unit shop, integer id returns Type

###################################################################################################

function RemovePagedButtonsIndex takes unit shop, integer index returns boolean

Removes the button for the given index from the given shop.
Returns true, if it has been removed successfully.
Otherwise, for example if the index was not part of the given shop, it returns false.

###################################################################################################

function RemovePagedButtonsId takes unit shop, integer id returns boolean

Removes the button for the given ID from the given shop.
Returns true, if it has been removed successfully.
Otherwise, for example if the ID was not part of the given shop, it returns false.

###################################################################################################

function HasPagedButtonsId takes unit shop, integer id returns boolean

###################################################################################################

function IsPagedButtonsIdUnit takes unit shop, integer id returns boolean

###################################################################################################

function GetPagedButtonsPageByIndex takes unit shop, integer index returns integer

Returns the matching page for the given button index of the given shop.
It depends on the slots per page for the given shop.

###################################################################################################

function GetPagedButtonsSlotsPerPage takes unit shop returns integer

###################################################################################################

function GetPagedButtonsPage takes unit shop returns integer

Returns the current page of the given shop. It starts with page 0 by default.

###################################################################################################

function GetPagedButtonsMaxPages takes unit shop returns integer

Returns the maximum number pages for the given shop. Adding more buttons might increase this number.

###################################################################################################

function GetPagedButtonsShopPage takes unit shop, integer page returns Page

Returns the page data object for the given shop and given page index.
Returns 0 if it does not exist.

###################################################################################################

function GetPagedButtonsPageName takes unit shop, integer page returns string

Returns the name of the given page of the given shop. The name has to be specified by the user.

###################################################################################################

function SetPagedButtonsPageName takes unit shop, integer page, string name returns nothing

Sets the name for the given page of the given shop.
The name will be shown in the shop's unit's name by default to identify the currently shown page.

###################################################################################################

function SetPagedButtonsCurrentPageName takes unit shop, string name returns nothing

Sets the name for the current page of the given shop.
The name will be shown in the shop's unit's name by default to identify the currently shown page.

###################################################################################################

function SetPagedButtonsPage takes unit shop, integer page returns nothing

Changes the given shop's current page to the given page if possible.

###################################################################################################

function SetPagedButtonsSlotsPerPage takes unit shop, integer slots returns nothing

###################################################################################################

function AddPagedButtonsId takes unit shop, integer id, integer whichType returns integer

Adds a paged button to the given shop with the given ID of the given type and returns its index.
The parameter whichType can have the following values:
PagedButtons_BUTTON_TYPE_UNIT
PagedButtons_BUTTON_TYPE_ITEM
PagedButtons_BUTTON_TYPE_ABILITY
PagedButtons_BUTTON_TYPE_SPACER

For the spacer tyoe the given ID has no effect.

###################################################################################################

function AddPagedButtonsUnitType takes unit shop, integer id returns integer

Adds a unit of the type with the given id to the given shop which can be purchased from the shop.
Returns the index of the added button for the given shop.

###################################################################################################

function AddPagedButtonsItemType takes unit shop, integer id returns integer

Adds an item of the type with the given id to the given shop which can be purchased from the shop.
Returns the index of the added button for the given shop.

###################################################################################################

function AddPagedButtonsAbility takes unit shop, integer id returns integer

Adds an ability of the type with the given id to the given shop which can be used from the shop.
Returns the index of the added button for the given shop.

###################################################################################################

function AddPagedButtonsSpacer takes unit shop returns integer

Adds a spacer button to the given shop.
Spacer buttons are just empty and have only the functionality to indicate different pages.

###################################################################################################

function AddPagedButtonsSpacers takes unit shop, integer counter returns nothing

Adds n spacer buttons to the given shop where n is equal to the given counter.

###################################################################################################

function AddPagedButtonsSpacersRemaining takes unit shop returns nothing

Adds spacers for all remaining empty slots on the current page.

###################################################################################################

function NextPagedButtonsPage takes takes unit shop, string name returns integer

Starts the next page if there is already a name for the current page or set the name for the current
page. Returns the started page number starting with 0.

###################################################################################################

function HasPagedButtons takes unit shop returns boolean

###################################################################################################

function EnablePagedButtons takes unit shop returns boolean

###################################################################################################

function DisablePagedButtons takes unit shop returns boolean

###################################################################################################

function ChangePagedButtonsToNextPage takes unit shop returns nothing

###################################################################################################

function ChangePagedButtonsToPreviousPage takes unit shop returns nothing

###################################################################################################

function GetTriggerShop takes nothing returns unit

Returns the shop which the page was changed for.

###################################################################################################

function GetTriggerPreviousPage takes nothing returns integer

Returns the previous page of the shop before changing its page.

###################################################################################################

function TriggerRegisterChangePagedButtons takes trigger whichTrigger returns nothing

Registers the event of changing the page of a paged button shop.
The trigger wil be conditionally evaluated and executed whenever any shop changes its page.
Use the GetTriggerXXX functions to retrieve event data.
The trigger is only evaluated and executed if it is enabled.

###################################################################################################

function GetTriggerAvailableObject takes nothing returns integer

Returns the unit type or item type ID of the available object in the shop.

###################################################################################################

function TriggerRegisterObjectAvailable takes trigger whichTrigger returns nothing

Registers the event of an object becoming available in a shop after its stock delay.
The trigger will be conditionally evaluated and executed whenever any stock in any paged buttons
shop is refilled.
Use the GetTriggerXXX functions to retrieve event data.
The trigger is only evaluated and executed if it is enabled.

###################################################################################################
*/

globals
    public constant integer NEXT_PAGE_ID = 'h0G2'
    public constant integer PREVIOUS_PAGE_ID = 'h0G1'
    public constant integer SLOTS_PER_PAGE = 9
    public constant integer ABILITY_ID_SELL_UNITS = 'Asud'
    public constant integer ABILITY_ID_SELL_ITEMS = 'Asid'
    // The shops will be disabled automatically when a shop unit dies.
    public constant boolean DISABLE_SHOPS_ON_DEATH = true
    public constant boolean CHANGE_PAGE_UNIT_NAME = true
    public constant boolean SHOW_PAGE_MESSAGE = false
    public constant boolean HIDE_PAGE_BUTTONS_FOR_ONE_PAGE = true
    public constant boolean SHOW_PAGE_NUMBER_IN_PAGE_BUTTONS = true
    // Shows the number of the next and previous pages in the page buttons. Otherwise, it will show the current page number.
    public constant boolean SHOW_NEXT_AND_PREVIOUS_PAGE_NUMBER = false
    /*
    Set this to true to fake the stock intervals which have been configured in PagedButtonsConfig.
    Note that this cannot be exact and therefore double refills shortly after each other are possible
    when this system refills a stock shortly after the game does.
    */
    public constant boolean AUTO_UPDATE_STOCKS = false
    // Define this as true to prevent items from being removed completely from non-marketplace shops.
    public constant boolean ENABLE_FAKE_MARKETPLACE_ITEM_REMOVAL = true
    public constant boolean HOOK_REMOVE_UNIT = true
    // This delay hreshold is required to avoid wrong item or unit types being removed due to still refilling stocks.
    public constant integer STOCK_DELAY_THRESHOLD = 1
    
    public constant integer BUTTON_TYPE_UNIT = 0
    public constant integer BUTTON_TYPE_ITEM = 1
    public constant integer BUTTON_TYPE_ABILITY = 2
    public constant integer BUTTON_TYPE_SPACER = 3
    
    private hashtable h = InitHashtable()
    private group shops = CreateGroup()
    private trigger deathTrigger = null
    private trigger sellUnitTrigger = CreateTrigger()
    private trigger sellItemTrigger = CreateTrigger()
    private timer autoUpdateStockTimer = CreateTimer()
    
    // callbacks
    private trigger array callbackTriggersChangePageButtons
    private integer callbackTriggersChangePageButtonsCounter = 0
    private trigger array callbackTriggersObjectAvailable
    private integer callbackTriggersObjectAvailableCounter = 0
    private unit triggerShop = null
    private integer triggerPreviousPage = 0
    private integer triggerAvailableObject = 0
endglobals

function GetAutoUpdateStockTimerHandleId takes nothing returns integer
    return GetHandleId(autoUpdateStockTimer)
endfunction

function GetTriggerShop takes nothing returns unit
    return triggerShop
endfunction

function GetTriggerPreviousPage takes nothing returns integer
    return triggerPreviousPage
endfunction

function GetTriggerAvailableObject takes nothing returns integer
    return triggerAvailableObject
endfunction

function TriggerRegisterChangePagedButtons takes trigger whichTrigger returns nothing
    set callbackTriggersChangePageButtons[callbackTriggersChangePageButtonsCounter] = whichTrigger
    set callbackTriggersChangePageButtonsCounter = callbackTriggersChangePageButtonsCounter + 1
endfunction

function TriggerRegisterObjectAvailable takes trigger whichTrigger returns nothing
    set callbackTriggersObjectAvailable[callbackTriggersObjectAvailableCounter] = whichTrigger
    set callbackTriggersObjectAvailableCounter = callbackTriggersObjectAvailableCounter + 1
endfunction

private function ExecuteChangedPageButtonsCallbacks takes unit shop, integer previousPage returns nothing
    local integer i = 0
    set triggerShop = shop
    set triggerPreviousPage = previousPage
    set i = 0
    loop
        exitwhen (i == callbackTriggersChangePageButtonsCounter)
        if (IsTriggerEnabled(callbackTriggersChangePageButtons[i])) then
            call ConditionalTriggerExecute(callbackTriggersChangePageButtons[i])
        endif
        set i = i + 1
    endloop
endfunction

private function ExecuteObjectAvailableCallbacks takes unit shop, integer objectId returns nothing
    local integer i = 0
    set triggerShop = shop
    set triggerAvailableObject = objectId
    set i = 0
    loop
        exitwhen (i == callbackTriggersObjectAvailableCounter)
        if (IsTriggerEnabled(callbackTriggersObjectAvailable[i])) then
            call ConditionalTriggerExecute(callbackTriggersObjectAvailable[i])
        endif
        set i = i + 1
    endloop
endfunction

public struct Type[100000]
    boolean shown = false
    boolean enabled = true
    integer whichType
    
    public method isSpacer takes nothing returns boolean
        return whichType == BUTTON_TYPE_SPACER
    endmethod
    
endstruct

// Use a separate type for spacers to save memory.
public struct SpacerType extends Type

    public static method create takes nothing returns thistype
        local thistype this = thistype.allocate()
        set this.whichType = BUTTON_TYPE_SPACER
        return this
    endmethod
    
    public stub method onDestroy takes nothing returns nothing
    endmethod
endstruct

public struct SlotType extends Type
    unit shop
    integer id
    integer startStock
    integer maxStock
    integer currentStock
    integer startDelay
    integer replenishInterval
    boolean replenish = true // if false it will not automatically update the stocks
    integer elapsedTimeStartDelay
    integer elapsedTimeReplenishInterval
    boolean startDelayDone = false
    
    private static thistype array list
    private static integer listCounter = 0

    public static method create takes unit shop, integer id, integer whichType, integer currentStock, integer startStock, integer maxStock, integer startDelay, integer replenishInterval returns thistype
        local thistype this = thistype.allocate()
        set this.shop = shop
        set this.id = id
        set this.whichType = whichType
        set this.currentStock = currentStock
        set this.startStock = startStock
        set this.maxStock = maxStock
        set this.startDelay = startDelay
        set this.replenishInterval = replenishInterval
        set this.elapsedTimeStartDelay = 0
        set this.elapsedTimeReplenishInterval = 0
        
        set list[listCounter] = this
        set listCounter = listCounter + 1
        
        return this
    endmethod
    
    public method onDestroy takes nothing returns nothing
        local boolean found = false
        local integer i = 0
        loop
            exitwhen (i >= thistype.listCounter)
            if (thistype.list[i] == this) then
                set found = true
            endif
            if (found) then
                set thistype.list[i] = thistype.list[i + 1]
                set thistype.list[i + 1] = 0
            endif
            set i = i + 1
        endloop
        if (found) then
            set thistype.listCounter = thistype.listCounter - 1
        endif
    endmethod
    
    public static method timerFunctionUpdateTime takes nothing returns nothing
        local boolean updated = false
        local integer elapsedSeconds = 1
        local integer i = 0
        local thistype this = 0
        loop
            exitwhen (i >= thistype.listCounter)
            set this = thistype.list[i]
            if (this.replenish) then
                set updated = false
                
                if (not startDelayDone) then
                    set this.elapsedTimeStartDelay = this.elapsedTimeStartDelay + elapsedSeconds
                    if (this.elapsedTimeStartDelay >= this.startDelay) then
                        if (this.currentStock < this.maxStock) then
                            set this.currentStock = this.currentStock + 1
                            set updated = true
                        endif
                        set this.elapsedTimeStartDelay = 0
                        set this.startDelayDone = true
                    endif
                endif
                
                if (this.currentStock < this.maxStock) then
                    set this.elapsedTimeReplenishInterval = this.elapsedTimeReplenishInterval + elapsedSeconds
                    //if (this.id == BOOTS_OF_SPEED) then
                    //    call BJDebugMsg("Elapsed seconds for " + GetObjectName(this.id) + " - " + I2S(elapsedSeconds) + " resulting in total elapsed: " + I2S(this.elapsedTimeReplenishInterval))
                    //endif
                    if (this.elapsedTimeReplenishInterval >= this.replenishInterval) then
                        if (this.currentStock < this.maxStock) then
                            set this.currentStock = this.currentStock + 1
                            set updated = true
                        endif
                        set this.elapsedTimeReplenishInterval = 0
                    endif
                endif
                if (updated) then
                    if (this.shown and this.enabled) then
                        if (this.whichType == BUTTON_TYPE_UNIT) then
                            // TODO Removes different unit when the stock is still in delay.
                            call AddUnitToStock(this.shop, this.id, this.currentStock, this.maxStock)
                        elseif (this.whichType == BUTTON_TYPE_ITEM) then
                            // TODO Removes different item when the stock is still in delay.
                            //call BJDebugMsg("Making item available again: " + GetObjectName(this.id))
                            call AddItemToStock(this.shop, this.id, this.currentStock, this.maxStock)
                        else
                            // Do nothing for abilities.
                        endif
                    endif
                    
                    call ExecuteObjectAvailableCallbacks(this.shop, this.id)
                endif
            endif
            set i = i + 1
        endloop
    endmethod

endstruct

public struct Page[100000]
    string name
endstruct

public struct Shop[100000]
    integer slotsPerPage = SLOTS_PER_PAGE
    integer currentPage = 0
    string name
    integer whichType
    Type array buttons[1000]
    integer buttonsCount = 0
    Page array pages[500]
    integer maxPages = 0
    
    public method removeButton takes integer index returns nothing
        loop
            exitwhen (index >= this.buttonsCount)
            set this.buttons[index] = this.buttons[index + 1]
            set this.buttons[index + 1] = 0
            set index = index + 1
        endloop
        set this.buttonsCount = this.buttonsCount - 1
    endmethod
    
    public static method create takes string name returns thistype
        local thistype this = thistype.allocate()
        set this.name = name
        return this
    endmethod
    
endstruct

function GetPagedButtonsShop takes unit shop returns Shop
    return LoadInteger(h, GetHandleId(shop), 0)
endfunction

function SetPagedButtonsShop takes unit shop, Shop s returns nothing
    call SaveInteger(h, GetHandleId(shop), 0, s)
endfunction

function GetPagedButtonsCount takes unit shop returns integer
    local Shop s = GetPagedButtonsShop(shop)
    if (s != 0) then
        return s.buttonsCount
    endif
    return 0
endfunction

function GetPagedButtonsNonSpacerButtonsCount takes unit shop returns integer
    local Shop x = GetPagedButtonsShop(shop)
    local integer result = 0
    local Type t = 0
    local integer i = 0
    loop
        exitwhen (i >= x.buttonsCount)
        set t = x.buttons[i]
        if (not t.isSpacer()) then
            set result = result + 1
        endif
        set i = i + 1
    endloop
    return result
endfunction

function GetPagedButton takes unit shop, integer index returns Type
    local Shop x = GetPagedButtonsShop(shop)
    
    return x.buttons[index]
endfunction

function GetPagedButtonIndex takes unit shop, integer id returns integer
    local Shop x = GetPagedButtonsShop(shop)
    local Type t = 0
    local SlotType s = 0
    local integer i = 0
    loop
        exitwhen (i >= x.buttonsCount)
        set t = x.buttons[i]
        if (not t.isSpacer()) then
            set s = SlotType(t)
            if (s.id == id) then
                return i
            endif
        endif
        set i = i + 1
    endloop
    return -1
endfunction

function GetPagedButtonIndexEx takes unit shop, integer id, integer index returns integer
    local Shop x = GetPagedButtonsShop(shop)
    local Type t = 0
    local SlotType s = 0
    local integer i = 0
    local integer currentIndex = 0
    loop
        exitwhen (i >= x.buttonsCount)
        set t = x.buttons[i]
        if (not t.isSpacer()) then
            set s = SlotType(t)
            if (s.id == id) then
                if (currentIndex == index) then
                    return i
                endif
                set currentIndex = currentIndex + 1
            endif
        endif
        set i = i + 1
    endloop
    return -1
endfunction

function GetPagedButtonsCountEx takes unit shop, integer id returns integer
    local Shop x = GetPagedButtonsShop(shop)
    local Type t = 0
    local SlotType s = 0
    local integer i = 0
    local integer count = 0
    loop
        exitwhen (i >= x.buttonsCount)
        set t = x.buttons[i]
        if (not t.isSpacer()) then
            set s = SlotType(t)
            if (s.id == id) then
                set count = count + 1
            endif
        endif
        set i = i + 1
    endloop
    return count
endfunction

function IsPagedButtonShown takes unit shop, integer index returns boolean
    return GetPagedButton(shop, index).shown
endfunction

function IsPagedButtonEnabled takes unit shop, integer index returns boolean
    return GetPagedButton(shop, index).enabled
endfunction

function GetPagedButtonId takes unit shop, integer index returns integer
    if (GetPagedButton(shop, index) == 0) then
        return 0
    endif
    return SlotType(GetPagedButton(shop, index)).id
endfunction

function IsPagedButtonUnit takes unit shop, integer index returns boolean
    return GetPagedButton(shop, index).whichType == BUTTON_TYPE_UNIT
endfunction

function IsPagedButtonItem takes unit shop, integer index returns boolean
    return GetPagedButton(shop, index).whichType == BUTTON_TYPE_ITEM
endfunction

function IsPagedButtonAbility takes unit shop, integer index returns boolean
    return GetPagedButton(shop, index).whichType == BUTTON_TYPE_ABILITY
endfunction

function IsPagedButtonSpacer takes unit shop, integer index returns boolean
    return GetPagedButton(shop, index).whichType == BUTTON_TYPE_SPACER
endfunction

function GetPagedButtonType takes unit shop, integer id returns SlotType
    local Shop x = GetPagedButtonsShop(shop)
    local Type result = 0
    local Type t = 0
    local SlotType s = 0
    local integer i = 0
    loop
        exitwhen (i >= x.buttonsCount or result != 0)
        set t = x.buttons[i]
        if (not t.isSpacer()) then
            set s = SlotType(t)
            if (s.id == id) then
                set result = t
            endif
        endif
        set i = i + 1
    endloop
    return result
endfunction

function HasPagedButtonsId takes unit shop, integer id returns boolean
    return GetPagedButtonType(shop, id) != 0
endfunction

function IsPagedButtonsIdUnit takes unit shop, integer id returns boolean
    local SlotType s = GetPagedButtonType(shop, id)
    if (s != 0) then
        return s.whichType == BUTTON_TYPE_UNIT
    endif
    return false
endfunction

function GetPagedButtonsSlotsPerPage takes unit shop returns integer
    local Shop s = GetPagedButtonsShop(shop)
    if (s != 0) then
        return s.slotsPerPage
    endif
    return 0
endfunction

function GetPagedButtonsPage takes unit shop returns integer
    local Shop s = GetPagedButtonsShop(shop)
    if (s != 0) then
        return s.currentPage
    endif
    return 0
endfunction

function GetPagedButtonsMaxPages takes unit shop returns integer
    local Shop s = GetPagedButtonsShop(shop)
    if (s != 0) then
        return s.maxPages
    endif
    return 0
endfunction

function GetPagedButtonsShopPage takes unit shop, integer page returns Page
    local Shop s = GetPagedButtonsShop(shop)
    if (s != 0 and page >= 0 and page < s.maxPages) then
        return s.pages[page]
    endif
    return 0
endfunction

private function PrintPages takes unit shop returns nothing
    local Shop s = GetPagedButtonsShop(shop)
    local Page p = 0
    local integer i = 0
    if (s != 0) then
        //call BJDebugMsg("Pages count: " + I2S(s.maxPages))
        loop
            exitwhen (i >= s.maxPages)
            set p = s.pages[i]
            //call BJDebugMsg("Page name: " + p.name)
            set i = i + 1
        endloop
    endif
endfunction

function GetPagedButtonsPageName takes unit shop, integer page returns string
    local Page p = GetPagedButtonsShopPage(shop, page)
    if (p != 0) then
        //call BJDebugMsg("Shop " + GetUnitName(shop) + " page name of page " + I2S(page) + ": " + p.name)
        return p.name
    endif
    //call BJDebugMsg("Shop "  + GetUnitName(shop) + " page name of page " + I2S(page) + " is not set.")
    return null
endfunction

function SetPagedButtonsPageName takes unit shop, integer page, string name returns nothing
    local Page p = GetPagedButtonsShopPage(shop, page)
    if (p != 0) then
        set p.name = name
    endif
    //call PrintPages(shop)
endfunction

function SetPagedButtonsCurrentPageName takes unit shop, string name returns nothing
    call SetPagedButtonsPageName(shop, GetPagedButtonsPage(shop), name)
endfunction

private function ChangeShopUnitName takes unit shop returns nothing
    local Shop s = GetPagedButtonsShop(shop)
    local integer currentPage = GetPagedButtonsPage(shop)
    local string pageName = GetPagedButtonsPageName(shop, s.currentPage)
    local string unitName = s.name
    //call BJDebugMsg("Change shop unit name to page " + I2S(s.currentPage) + ": " + pageName)
    if (unitName == null) then
        set unitName = ""
    endif
    if (pageName != null) then
        if (StringLength(unitName) > 0 and unitName != " ") then
            call BlzSetUnitName(shop, unitName + " " + pageName)
        else
            call BlzSetUnitName(shop, pageName)
        endif
    else
        call BlzSetUnitName(shop, unitName)
    endif
endfunction

private function ResetShopUnitName takes unit shop returns nothing
     local Shop s = GetPagedButtonsShop(shop)
    local string unitName = s.name
    if (unitName == null) then
        set unitName = ""
    endif
    call BlzSetUnitName(shop, unitName)
endfunction

private function HidePagedButtonsCurrentPage takes unit shop returns nothing
    local Shop x = GetPagedButtonsShop(shop)
    local integer maxPages = x.maxPages
    local integer totalCounter = x.buttonsCount
    local integer countUnits = 0
    local integer countItems = 0
    local integer slotsPerPage = x.slotsPerPage
    local integer currentPage = x.currentPage
    local integer i = currentPage * slotsPerPage
    local integer count = i + IMinBJ(slotsPerPage, totalCounter - currentPage * slotsPerPage)
    local Type t = GetPagedButton(shop, i)
    local SlotType s = 0
    loop
        exitwhen (i >= count)
        set t = x.buttons[i]
        if (not t.isSpacer() and t.enabled) then
            set s = SlotType(t)
            if (s.whichType == BUTTON_TYPE_UNIT) then
                call RemoveUnitFromStock(shop, s.id)
            elseif (s.whichType == BUTTON_TYPE_ITEM) then
                call RemoveItemFromStock(shop, s.id)
            else
                call UnitRemoveAbility(shop, s.id)
            endif
        endif
        set t.shown = false
        set i = i + 1
    endloop
    call SetUnitTypeSlots(shop, 0)
    call SetItemTypeSlots(shop, 0)
endfunction

private function ShowPagedButtonsCurrentPage takes unit shop returns nothing
    local Shop x = GetPagedButtonsShop(shop)
    local integer maxPages = x.maxPages
    local integer currentPage = x.currentPage
    local integer totalCounter = x.buttonsCount
    local integer countUnits = 0
    local integer countItems = 0
    local integer nextPage = 0
    local integer previousPage = 0
    local integer slotsPerPage = GetPagedButtonsSlotsPerPage(shop)
    local integer i = currentPage * slotsPerPage
    local integer count = i + IMinBJ(slotsPerPage, totalCounter - currentPage * slotsPerPage)
    local Type t = GetPagedButton(shop, i)
    local SlotType s = 0
    if (not HIDE_PAGE_BUTTONS_FOR_ONE_PAGE or maxPages > 1) then
        call SetUnitTypeSlots(shop, 2)

static if (not SHOW_PAGE_NUMBER_IN_PAGE_BUTTONS) then
        call AddUnitToStock(shop, NEXT_PAGE_ID, 1, 1)
        call AddUnitToStock(shop, PREVIOUS_PAGE_ID, 1, 1)
else

static if (SHOW_PAGE_NUMBER_IN_PAGE_BUTTONS and SHOW_NEXT_AND_PREVIOUS_PAGE_NUMBER) then
        if (currentPage == maxPages - 1) then
            set nextPage = 1
        else
            set nextPage = currentPage + 2
        endif
        
        if (currentPage == 0) then
            set previousPage = maxPages
        else
            set previousPage = currentPage
        endif
else
        set nextPage = currentPage + 1
        set previousPage = currentPage + 1
endif
        
        call AddUnitToStock(shop, NEXT_PAGE_ID, nextPage, nextPage)
        call AddUnitToStock(shop, PREVIOUS_PAGE_ID, previousPage, previousPage)
endif
    else
        call RemoveUnitFromStock(shop, NEXT_PAGE_ID)
        call RemoveUnitFromStock(shop, PREVIOUS_PAGE_ID)
        call SetUnitTypeSlots(shop, 0)
    endif
    if (not HIDE_PAGE_BUTTONS_FOR_ONE_PAGE or maxPages > 1) then
        set countUnits = 2
    endif
    //call BJDebugMsg("Showing page "  + I2S(currentPage) + " with buttons " + I2S(count - i) + " starting at index " + I2S(i) + " and ending at index " + I2S(count) + " and starting with button instance " + I2S(t) + " with max pages " + I2S(maxPages))
    loop
        exitwhen (i >= count)
        set t = x.buttons[i]
        //call BJDebugMsg("Checking instance " + I2S(t))
        if (not t.isSpacer() and t.enabled) then
            set s = SlotType(t)
            //call BJDebugMsg("Adding "  + GetObjectName(s.id))
            if (s.whichType == BUTTON_TYPE_UNIT) then
                set countUnits = countUnits + 1
                call SetUnitTypeSlots(shop, countUnits)
                call AddUnitToStock(shop, s.id, s.currentStock, s.maxStock)
            elseif (s.whichType == BUTTON_TYPE_ITEM) then
                set countItems = countItems + 1
                call SetItemTypeSlots(shop, countItems)
                call AddItemToStock(shop, s.id, s.currentStock, s.maxStock)
            else
                call UnitAddAbility(shop, s.id)
            endif
        else
            //call BJDebugMsg("Not enabled or spacer.")
        endif
        set t.shown = true
        set i = i + 1
    endloop
static if (CHANGE_PAGE_UNIT_NAME) then
    call ChangeShopUnitName(shop)
endif

// show the page buttons afterwards to make sure that they have a higher priority than the unit buttons
if (not HIDE_PAGE_BUTTONS_FOR_ONE_PAGE or maxPages > 1) then
static if (not SHOW_PAGE_NUMBER_IN_PAGE_BUTTONS) then
    call AddUnitToStock(shop, NEXT_PAGE_ID, 1, 1)
    call AddUnitToStock(shop, PREVIOUS_PAGE_ID, 1, 1)
else
    call AddUnitToStock(shop, NEXT_PAGE_ID, nextPage, nextPage)
    call AddUnitToStock(shop, PREVIOUS_PAGE_ID, previousPage, previousPage)
endif
endif
endfunction

function SetPagedButtonsPage takes unit shop, integer page returns nothing
    local Shop s = GetPagedButtonsShop(shop)
    local integer currentPage = s.currentPage
    call HidePagedButtonsCurrentPage(shop)
    set s.currentPage = page
    call ShowPagedButtonsCurrentPage(shop)
static if (CHANGE_PAGE_UNIT_NAME) then
    call ChangeShopUnitName(shop)
endif
    call ExecuteChangedPageButtonsCallbacks(shop, currentPage)
endfunction

function SetPagedButtonEnabled takes unit shop, integer index, boolean enabled returns nothing
    set GetPagedButton(shop, index).enabled = enabled
    // refresh
    call SetPagedButtonsPage(shop, GetPagedButtonsPage(shop))
endfunction

private function RefreshMaxPagesEx takes unit shop, integer maxPages returns nothing
    local Shop s = GetPagedButtonsShop(shop)
    local integer oldMaxPages = s.maxPages
    local integer i = 0
    set s.maxPages = maxPages
    // create all missing pages instances
    if (maxPages > oldMaxPages) then
        set i = oldMaxPages
        loop
            exitwhen (i >= maxPages)
            if (s.pages[i] == 0) then
                set s.pages[i] = Page.create()
                if (i > 0) then
                    set s.pages[i].name = s.pages[i - 1].name // copy the previous page name
                endif
            endif
            set i = i + 1
        endloop
    // remove too many pages instances
    elseif (maxPages < oldMaxPages) then
        set i = oldMaxPages
        loop
            exitwhen (i < maxPages)
            if (s.pages[i] == 0) then
                set s.pages[i] = 0
                call s.pages[i].destroy()
            endif
            set i = i - 1
        endloop
    endif
endfunction

private function RefreshMaxPages takes unit shop returns nothing
    local Shop s = GetPagedButtonsShop(shop)
    local integer count = s.buttonsCount
    local integer slots = s.slotsPerPage
    local integer maxPages = count / slots
    if (ModuloInteger(count, slots) > 0) then
        set maxPages = maxPages + 1
    endif
    set maxPages = IMaxBJ(maxPages, 1)
    call RefreshMaxPagesEx(shop, maxPages)
endfunction

function RemovePagedButtonsIndex takes unit shop, integer index returns boolean
    local Shop s = GetPagedButtonsShop(shop)
    local Type t = 0
    if (s != 0 and index >= 0 and index <= s.buttonsCount) then
        set t = s.buttons[index]
        if (t.shown) then
            if (t.whichType == BUTTON_TYPE_UNIT) then
                call RemoveUnitFromStock(shop, SlotType(t).id)
            elseif (t.whichType == BUTTON_TYPE_ITEM) then
                call RemoveItemFromStock(shop, SlotType(t).id)
            elseif (t.whichType == BUTTON_TYPE_ITEM) then
                call UnitRemoveAbility(shop, SlotType(t).id)
            endif
        endif
    
        call s.removeButton(index)
        call t.destroy()
        
        // update buttons
        call RefreshMaxPages(shop)
        call SetPagedButtonsPage(shop, IMaxBJ(0, IMinBJ(GetPagedButtonsPage(shop), s.maxPages - 1)))
        
        return true
    endif
    
    return false
endfunction

function RemovePagedButtonsId takes unit shop, integer id returns boolean
    local integer index = GetPagedButtonIndex(shop, id)
    if (index != -1) then
        return RemovePagedButtonsIndex(shop, index)
    endif
    
    return false
endfunction

function SetPagedButtonsSlotsPerPage takes unit shop, integer slots returns nothing
    local Shop s = GetPagedButtonsShop(shop)
    set s.slotsPerPage = slots
    call RefreshMaxPages(shop)
    call SetPagedButtonsPage(shop, GetPagedButtonsPage(shop))
endfunction

private function AddPageButtonsIdType takes unit shop, integer id, integer whichType returns Type
    local integer startStock = 1
    local integer currentStock = 1
    local integer maxStock = 1
    local integer startDelay = 0
    local integer replenishInterval = 30
static if (LIBRARY_PagedButtonsConfig) then
    local PagedButtonsConfig c =  GetPagedButtonsConfig(id)
    set startStock = c.stockInitialAfterStartDelay
    set maxStock =  c.stockMaximum
    set startDelay = c.stockStartDelay
    if (startDelay > 0) then
         set startDelay = startDelay + STOCK_DELAY_THRESHOLD
    endif
    set replenishInterval = c.stockReplenishInterval
    if (replenishInterval > 0) then
        set replenishInterval = replenishInterval + STOCK_DELAY_THRESHOLD
    endif
    
    if (startDelay > 0) then
        set currentStock = 0
    endif
endif
    return SlotType.create(shop, id, whichType, currentStock, startStock, maxStock, startDelay, replenishInterval)
endfunction

function AddPagedButtonsId takes unit shop, integer id, integer whichType returns integer
    local Shop s = GetPagedButtonsShop(shop)
    local Type t = 0
    local integer index = 0
    
    if (s == 0) then
        return -1
    endif
    set index = s.buttonsCount
    if (whichType == BUTTON_TYPE_SPACER) then
        set t = SpacerType.create()
    else
        set t = AddPageButtonsIdType(shop, id, whichType)
    endif
    set s.buttons[index] = t
    set s.buttonsCount = index + 1
    call RefreshMaxPages(shop)
    call SetPagedButtonsPage(shop, GetPagedButtonsPage(shop))
    
    //call BJDebugMsg("Added ID " + GetObjectName(id) + " to shop " + GetUnitName(shop) + " resulting in " + I2S(s.buttons.getSize()) + " buttons and " + I2S(s.maxPages) + " max pages.")
    
    return index
endfunction

function AddPagedButtonsUnitType takes unit shop, integer id returns integer
    return AddPagedButtonsId(shop, id, BUTTON_TYPE_UNIT)
endfunction

function AddPagedButtonsItemType takes unit shop, integer id returns integer
    return AddPagedButtonsId(shop, id, BUTTON_TYPE_ITEM)
endfunction

function AddPagedButtonsAbility takes unit shop, integer id returns integer
    return AddPagedButtonsId(shop, id, BUTTON_TYPE_ABILITY)
endfunction

function AddPagedButtonsSpacer takes unit shop returns integer
    return AddPagedButtonsId(shop, 0, BUTTON_TYPE_SPACER)
endfunction

function AddPagedButtonsSpacers takes unit shop, integer counter returns nothing
    local integer i = 0
    loop
        exitwhen (i == counter)
        call AddPagedButtonsSpacer(shop)
        set i = i + 1
    endloop
endfunction

function GetPagedButtonsPageByIndex takes unit shop, integer index returns integer
    local Shop s = GetPagedButtonsShop(shop)
    if (s != 0) then
        return index / s.slotsPerPage
    endif
    return 0
endfunction

function AddPagedButtonsSpacersRemaining takes unit shop returns nothing
    local Shop s = GetPagedButtonsShop(shop)
    local integer mod = 0
    if (s != 0) then
        set mod = ModuloInteger(s.buttonsCount, s.slotsPerPage)
        if (mod > 0) then
            call AddPagedButtonsSpacers(shop, s.slotsPerPage - mod)
        endif
    endif
endfunction

function NextPagedButtonsPage takes unit shop, string name returns integer
    local Shop s = GetPagedButtonsShop(shop)
    local integer nextPage = 0
    if (s != 0) then
        // find the next page
        loop
            exitwhen (nextPage > s.maxPages or StringLength(s.pages[nextPage].name) == 0)
            set nextPage = nextPage + 1
        endloop
        if (nextPage > 0) then
            //call BJDebugMsg("Adding remaining spacers for page " + I2S(nextPage))
            call AddPagedButtonsSpacersRemaining(shop)
        endif
        call RefreshMaxPagesEx(shop, nextPage + 1)
        //call BJDebugMsg("Setting name for next page " + I2S(nextPage) + ": " + name)
        call SetPagedButtonsPageName(shop, nextPage, name)
    
static if (CHANGE_PAGE_UNIT_NAME) then
        call ChangeShopUnitName(shop)
endif
    
        //call BJDebugMsg("Set name for next page " + I2S(nextPage) + " to name " + name)
        return nextPage
    endif
    
    return -1
endfunction

function HasPagedButtons takes unit shop returns boolean
    return IsUnitInGroup(shop, shops)
endfunction

function EnablePagedButtons takes unit shop returns boolean
    if (not HasPagedButtons(shop)) then
        call UnitAddAbility(shop, ABILITY_ID_SELL_UNITS)
        call UnitAddAbility(shop, ABILITY_ID_SELL_ITEMS)
        call GroupAddUnit(shops, shop)
        call SetPagedButtonsShop(shop, Shop.create(GetUnitName(shop)))
        call SetPagedButtonsSlotsPerPage(shop, SLOTS_PER_PAGE)
        
        return true
    endif
    
    return false
endfunction

private function DestroyPagedButtonsShopTypes takes unit shop returns nothing
    local Shop s = GetPagedButtonsShop(shop)
    call s.destroy()
endfunction

function DisablePagedButtons takes unit shop returns boolean
    if (HasPagedButtons(shop)) then
static if (CHANGE_PAGE_UNIT_NAME) then
    call ResetShopUnitName(shop)
endif
        call RemoveUnitFromStock(shop, NEXT_PAGE_ID)
        call RemoveUnitFromStock(shop, PREVIOUS_PAGE_ID)
        call GroupRemoveUnit(shops, shop)
        call HidePagedButtonsCurrentPage(shop)
        call DestroyPagedButtonsShopTypes(shop)
        call FlushChildHashtable(h, GetHandleId(shop))
        
        return true
    endif
    
    return false
endfunction

function ChangePagedButtonsToNextPage takes unit shop returns nothing
    local Shop s = GetPagedButtonsShop(shop)
    local integer currentPage = s.currentPage
    local integer maxPages = s.maxPages
    if (currentPage == maxPages - 1) then
        call SetPagedButtonsPage(shop, 0)
    else
        call SetPagedButtonsPage(shop, currentPage + 1)
    endif
endfunction

function ChangePagedButtonsToPreviousPage takes unit shop returns nothing
    local Shop s = GetPagedButtonsShop(shop)
    local integer currentPage = s.currentPage
    local integer maxPages = s.maxPages
    if (currentPage == 0) then
        call SetPagedButtonsPage(shop, maxPages - 1)
    else
        call SetPagedButtonsPage(shop, currentPage - 1)
    endif
endfunction

private function TriggerConditionDeath takes nothing returns boolean
static if (DISABLE_SHOPS_ON_DEATH) then
    call DisablePagedButtons(GetTriggerUnit())
endif
    return false
endfunction

private function TriggerConditionSell takes nothing returns boolean
    return HasPagedButtons(GetSellingUnit())
endfunction

private function DisplayMsg takes unit shop, unit buyingUnit returns nothing
    local player owner = GetOwningPlayer(buyingUnit)
    local integer currentPage = GetPagedButtonsPage(shop)
    local string msg = "Page " + I2S(currentPage + 1)
    local force whichForce = CreateForce()
    local player slotPlayer = null
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set slotPlayer = Player(i)
        if (owner == slotPlayer or GetPlayerAlliance(owner, slotPlayer, ALLIANCE_SHARED_ADVANCED_CONTROL) or GetPlayerAlliance(owner, slotPlayer, ALLIANCE_SHARED_CONTROL)) then
            call ForceAddPlayer(whichForce, slotPlayer)
        endif
        set slotPlayer = null
        set i = i + 1
    endloop
    if (GetPagedButtonsPageName(shop, currentPage) != null) then
        set msg = msg + ": " + GetPagedButtonsPageName(shop, currentPage)
    endif
    call DisplayTextToForce(whichForce, msg)
    call ForceClear(whichForce)
    call DestroyForce(whichForce)
    set whichForce = null
    set owner = null
endfunction

private function UpdateStocksById takes unit shop, integer id returns nothing
    local SlotType s = GetPagedButtonType(shop, id)
    if (s != 0) then
        set s.currentStock = IMaxBJ(s.currentStock - 1, 0)
    endif
endfunction

private function TriggerActionSellUnit takes nothing returns nothing
    local unit shop = GetSellingUnit()
    local integer unitTypeId = GetUnitTypeId(GetSoldUnit())
    if (unitTypeId == NEXT_PAGE_ID or unitTypeId == PREVIOUS_PAGE_ID) then
        call RemoveUnit(GetSoldUnit())
        if (unitTypeId == NEXT_PAGE_ID) then
            call ChangePagedButtonsToNextPage(shop)
        else
            call ChangePagedButtonsToPreviousPage(shop)
        endif
static if (SHOW_PAGE_MESSAGE) then
        call DisplayMsg(shop, GetBuyingUnit())
endif
    else
static if (AUTO_UPDATE_STOCKS) then
    call UpdateStocksById(shop, unitTypeId)
endif
    endif
    set shop = null
endfunction

private function TriggerActionSellItem takes nothing returns nothing
static if (AUTO_UPDATE_STOCKS) then
    call UpdateStocksById(GetSellingUnit(), GetItemTypeId(GetSoldItem()))
endif
endfunction

private function TriggerConditionIsMarketplace takes nothing returns boolean
    return GetUnitTypeId(GetSellingUnit()) == 'nmrk'
endfunction

private function Init takes nothing returns nothing
static if (DISABLE_SHOPS_ON_DEATH) then
    set deathTrigger = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(deathTrigger, Condition(function TriggerConditionDeath))
endif

    call TriggerRegisterAnyUnitEventBJ(sellUnitTrigger, EVENT_PLAYER_UNIT_SELL)
    call TriggerAddCondition(sellUnitTrigger, Condition(function TriggerConditionSell))
    call TriggerAddAction(sellUnitTrigger, function TriggerActionSellUnit)
    call TriggerRegisterAnyUnitEventBJ(sellItemTrigger, EVENT_PLAYER_UNIT_SELL_ITEM)
    call TriggerAddCondition(sellItemTrigger, Condition(function TriggerConditionSell))
    call TriggerAddAction(sellItemTrigger, function TriggerActionSellItem)
static if (AUTO_UPDATE_STOCKS) then
    call TimerStart(autoUpdateStockTimer, 1.0, true, function SlotType.timerFunctionUpdateTime)
endif
static if (ENABLE_FAKE_MARKETPLACE_ITEM_REMOVAL) then
    call TriggerAddCondition(bj_stockItemPurchased, Condition(function TriggerConditionIsMarketplace))
endif
endfunction

static if (HOOK_REMOVE_UNIT) then
hook RemoveUnit DisablePagedButtons
endif

/*
ChangeLog:

1.6

- Fix showing TooltipIcon in UI for the local player only.
- Do not use arrays for UI frames.
- Add FrameSaver dependency to UI and hide UI before saving a game to avoid invalid frames after loading the game.
- Make UI frame names unique.
- Improve UI layout.
- Change adding page names in UI.
- Add checkbox to show/hide slot charges in UI.
- Add more constants to UI.
- Do not show tooltip in UI when clicking on any shop.
- Refactor PagedButtonsConfig.
- Add option SHOW_PREVIEW_MODELS to preview registered models.
- Use scrollable text area for tooltips.
- Increase the size of the tooltip frame and reduce the number of shown icons.
- Add flag replenish to button types.

1.5

- Remove unused constants.
- Use child key 0 to store Shop instances in hashtable.
- Add constants for UI values.
- Decrease slots per page to 9 for all shops in the demo map.
- Remove unused code.
- Add PagedButtonsUI_SHOW_PAGE_NUMBERS to allow disabling pages numbers and set it to false by default.
- Improve layout of PagedButtonsUI especially for non-Human race UIs.

1.4

- GetPagedButtonId returns 0 for empty page buttons now.
- Add function GetPagedButtonsPageByIndex.
- Add optional UI to show more buttons at once which requires the FrameLoader and ItemTypeUtils dependencies.
- Function NextPagedButtonsPage changes the shop's name now even without adding any buttons.
- Add option DISABLE_SHOPS_ON_DEATH which is true by default.
- Change buttons page event is triggered from SetPagedButtonsPage now.
- Add function GetPagedButtonsNonSpacerButtonsCount.
- Switch "Next Page" and "Previous Page" unit types in demo map.
- Make sure that the "Next Page" and "Previous Page" buttons have a higher priority for shops than all other buttons.
- Mention the slow linked list traversal in the documentation.
- Remove LinkedList dependency and use custom arrays to improve the performance.
- Add function RemovePagedButtonsIndex.
- Fix function AddPagedButtonsSpacersRemaining.
- Add API documentation.

1.3

- Only execute callback triggers if they are enabled.
- Add struct Shop and Page to manage data internally with less hashtable keys.
- Add function GetPagedButtonsShop.
- Add function SetPagedButtonsShop.
- Add function GetPagedButtonsShopPage.
- Add function GetPagedButtonIndexEx.
- Add function GetPagedButtonsCountEx.
- Add function IsPagedButtonSpacer.
- Add constant BUTTON_TYPE_SPACER.
- Store the paged buttons type in T and remove method isSpacer to improve the performance and simplify
the code.
- Function NextPagedButtonsPage checks if the page exists now instead of checking the page name for
being null.
- Rename function GetPagedButtonsIndex into GetPagedButtonIndex.
- Rename function GetPagedButtonsType into GetPagedButtonType.
- Simplify implementation of function RemovePagedButtonsId.
- Function RemovePagedButtonsId removes the ID from the shop if it is shown.
- Remove the word System from libraries.
- Add paged buttons to race shops in example map.
- Add building Advanced Marketplace to example map.
- Only evaluate and execute callback triggers used with TriggerRegisterChangePagedButtons when the
player changes the page.

1.2

- Improve API documentation.
- Implement function RemovePagedButtonsId.
- Add function IsPagedButtonItem.
- Add function IsPagedButtonAbility.
- Add function AddPagedButtonsAbility.
- Add Advanced Goblin Laboratory to example map to demonstrate abilities.
- Add function NextPagedButtonsPage.
- Add function IsPagedButtonEnabled.
- Add function SetPagedButtonEnabled.
- Show next and previous page numbers as stock charges for the next and previous page buttons.
- Add option SHOW_NEXT_AND_PREVIOUS_PAGE_NUMBER.
- Add option STOCK_DELAY_THRESHOLD to fix removing wrong unit or item types on refreshing their stocks.
- Fix used page number in function SetPagedButtonsCurrentPageName.
- TriggerRegisterObjectAvailable works now even if the ID is not visible in the shop.

1.1 (thanks for Wrda's feedback on Hive):

- Fix GetPagedButtonsType.
- Mention that RemovePagedButtonsId is incomplete.
- Remove function RefreshPagedButtonsPage.
- Make option constants public.
- Add separators in API documentation comment.
- Add callback functions GetTriggerChangingShop, GetTriggerPreviousPage, GetTriggerAvailableObject, 
TriggerRegisterChangePagedButtons and TriggerRegisterObjectAvailable and use them in the example map.
- Use different structs for spacers than for actual object IDs to save memory.
- Configure unit and item types in the example map config to show how it can be used.
- Only apply start delay once to refresh the stock.
- Only apply replenish delay if the current stock is smaller than maximum stock.
- Fix traversing list in method timerFunctionUpdateTime.
- Fix setting elapsedTimeReplenishInterval to 0 in method timerFunctionUpdateTime.
*/

endlibrary
