library PagedButtonsConfig initializer Init requires ItemTypeUtils

globals
    private hashtable h = InitHashtable()
endglobals

struct PagedButtonsConfig
    integer heroGoldCost
    integer heroLumberCost
    integer stockInitialAfterStartDelay
    integer stockMaximum
    integer stockReplenishInterval
    integer stockStartDelay
    real modelX
    real modelY
    real modelScale
    string modelPath
endstruct

function AddPagedButtonsConfig takes integer id, integer heroGoldCost, integer heroLumberCost, integer stockInitialAfterStartDelay, integer stockMaximum, integer stockReplenishInterval, integer stockStartDelay, real modelX, real modelY, real modelScale, string modelPath returns nothing
    local PagedButtonsConfig c = PagedButtonsConfig.create()
    set c.heroGoldCost = heroGoldCost
    set c.heroLumberCost = heroLumberCost
    set c.stockInitialAfterStartDelay = stockInitialAfterStartDelay
    set c.stockMaximum = stockMaximum
    set c.stockReplenishInterval = stockReplenishInterval
    set c.stockStartDelay = stockStartDelay
    set c.modelX = modelX
    set c.modelY = modelY
    set c.modelScale = modelScale
    set c.modelPath = modelPath
    
    call SaveInteger(h, id, 0, c)
endfunction

function AddPagedButtonsConfigHero takes integer id, integer heroGoldCost, integer heroLumberCost, integer stockInitialAfterStartDelay, integer stockMaximum, integer stockReplenishInterval, integer stockStartDelay, string modelPath returns nothing
    local PagedButtonsConfig c = PagedButtonsConfig.create()
    set c.heroGoldCost = heroGoldCost
    set c.heroLumberCost = heroLumberCost
    set c.stockInitialAfterStartDelay = stockInitialAfterStartDelay
    set c.stockMaximum = stockMaximum
    set c.stockReplenishInterval = stockReplenishInterval
    set c.modelX = 0.73
    set c.modelY = 0.26
    set c.modelScale = 0.0002
    set c.modelPath = modelPath
    call SaveInteger(h, id, 0, c)
endfunction

function AddPagedButtonsConfigUnit takes integer id, integer stockInitialAfterStartDelay, integer stockMaximum, integer stockReplenishInterval, integer stockStartDelay, string modelPath returns nothing
    local PagedButtonsConfig c = PagedButtonsConfig.create()
    set c.heroGoldCost = 0
    set c.heroLumberCost = 0
    set c.stockInitialAfterStartDelay = stockInitialAfterStartDelay
    set c.stockMaximum = stockMaximum
    set c.stockReplenishInterval = stockReplenishInterval
    set c.modelX = 0.73
    set c.modelY = 0.26
    set c.modelScale = 0.0002
    set c.modelPath = modelPath
    call SaveInteger(h, id, 0, c)
endfunction

function AddPagedButtonsConfigItem takes integer id, integer stockInitialAfterStartDelay, integer stockMaximum, integer stockReplenishInterval, integer stockStartDelay returns nothing
    local PagedButtonsConfig c = PagedButtonsConfig.create()
    set c.heroGoldCost = 0
    set c.heroLumberCost = 0
    set c.stockInitialAfterStartDelay = stockInitialAfterStartDelay
    set c.stockMaximum = stockMaximum
    set c.stockReplenishInterval = stockReplenishInterval
    set c.stockStartDelay = stockStartDelay
    set c.modelX = 0.73
    set c.modelY = 0.26
    set c.modelScale = 0.0007
    set c.modelPath = GetItemTypeModel(id)
    call SaveInteger(h, id, 0, c)
endfunction

function GetPagedButtonsConfig takes integer id returns PagedButtonsConfig
    local PagedButtonsConfig c = LoadInteger(h, id, 0)
    if (c == 0) then
        return LoadInteger(h, 0, 0) // 0 is the default config
    endif
    return c
endfunction

function SetPagedButtonsConfigHeroCostsDefault takes integer heroGoldCost, integer heroLumberCost returns nothing
    local PagedButtonsConfig c = GetPagedButtonsConfig(0)
    set c.heroGoldCost = heroGoldCost
    set c.heroLumberCost = heroLumberCost
endfunction

private function Init takes nothing returns nothing
    // Default config which is used if the user does not register any for ID 0.
    call AddPagedButtonsConfig(0, 0, 0, 1, 1, 0, 0, 0.0, 0.0, 0.0, "")
endfunction

endlibrary
