library GenerateIds

globals
    // prevent generating the same IDs multiple times
    private integer array generatedIds
    private integer generatedIdsCounter = 0
    
    private string array generatedIdsStrings
    private integer generatedIdsStringsCounter = 0
endglobals

function ClearGeneratedIds takes nothing returns nothing
    set generatedIdsCounter = 0
endfunction

function GenerateId takes integer id returns boolean
    local boolean result = true
    local integer i = 0
    if (id == 0) then
        return false
    endif
    loop
        exitwhen (i == generatedIdsCounter or not result)
        if (generatedIds[i] == id) then
            set result = false
        endif
        set i = i + 1
    endloop
    if (result) then
        set generatedIds[generatedIdsCounter] = id
        set generatedIdsCounter = generatedIdsCounter + 1
    endif
    return result
endfunction

function ClearGeneratedStringIds takes nothing returns nothing
    set generatedIdsStringsCounter = 0
endfunction

function GenerateIdString takes string id returns boolean
    local boolean result = true
    local integer i = 0
    loop
        exitwhen (i == generatedIdsStringsCounter or not result)
        if (generatedIdsStrings[i] == id) then
            set result = false
        endif
        set i = i + 1
    endloop
    if (result) then
        set generatedIdsStrings[generatedIdsStringsCounter] = id
        set generatedIdsStringsCounter = generatedIdsStringsCounter + 1
    endif
    return result
endfunction

endlibrary
