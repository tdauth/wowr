library WoWReforgedRaceHuman

globals
    private hashtable h = InitHashtable()
    private group arcaneObservatories = CreateGroup()
endglobals

function AddArcaneObservatory takes unit whichUnit returns nothing
    if (not IsUnitInGroup(whichUnit, arcaneObservatories)) then
        call GroupAddUnit(arcaneObservatories, whichUnit)
        call SaveFogModifierHandle(h, GetHandleId(whichUnit), 0, CreateFogModifierRadius(GetOwningPlayer(whichUnit), FOG_OF_WAR_VISIBLE, GetUnitX(whichUnit), GetUnitY(whichUnit), 8000.00, true, true))
    endif
endfunction

function RemoveArcaneObservatory takes unit whichUnit returns nothing
    if (IsUnitInGroup(whichUnit, arcaneObservatories)) then
        call GroupRemoveUnit(arcaneObservatories, whichUnit)
        call DestroyFogModifier(LoadFogModifierHandle(h, GetHandleId(whichUnit), 0))
        call FlushChildHashtable(h, GetHandleId(whichUnit))
    endif
endfunction

endlibrary
