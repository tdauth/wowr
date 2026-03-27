library HideAbility requires StringUtils
/*
https://www.hiveworkshop.com/threads/blzunithideability-and-blzunitdisableability-dont-work.312477/#post-3325089

BlzUnitHideAbility & BlzUnitDisableAbility increase/decerase counters on each usage. The Ability switchs hidden/shown Enabled/Disabled state only when moving over the 0 even line.

https://www.hiveworkshop.com/threads/blzunithideability-and-blzunitdisableability-dont-work.312477/#post-3482672
*/

globals
    private hashtable h = InitHashtable()
endglobals

function UnitHideAbilitySafely takes unit u, integer abilityId, boolean hide returns nothing
    local integer handleId = GetHandleId(u)
    local boolean flag = LoadBoolean(h, handleId, abilityId)
    if (flag and hide) or (not flag and not hide) then
        //call BJDebugMsg("Ignoring hide call for " + GetObjectName(abilityId) + " with hide value " + B2S(hide))
        return //do nothing
    endif
    
    //call BJDebugMsg("Not ignoring hide call for " + GetObjectName(abilityId) + " with hide value " + B2S(hide))
    call SaveBoolean(h, handleId, abilityId, hide)
    call BlzUnitHideAbility(u, abilityId, hide)
endfunction

private function RemoveUnitHook takes unit whichUnit returns nothing
    call FlushChildHashtable(h, GetHandleId(whichUnit))
endfunction

hook RemoveUnit RemoveUnitHook

endlibrary
