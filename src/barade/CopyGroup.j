library CopyGroup

function CopyGroup takes group whichGroup returns group
    local group copy = CreateGroup()
    //call BlzGroupAddGroupFast(copy, whichGroup) // seems broken
    call GroupAddGroup(whichGroup, copy)
    return copy
endfunction

endlibrary
