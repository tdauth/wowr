library WoWReforgedItemWater initializer Init requires SimError

globals
    private trigger channelTrigger = CreateTrigger()
endglobals

private function WaterGround takes unit caster, real x, real y returns nothing
    if (not IsTerrainPathable(x, y, PATHING_TYPE_AMPHIBIOUSPATHING)) then
        // TODO Create pathing for a whole cell.
        if (not IsTerrainPathable(x, y, PATHING_TYPE_FLOATABILITY)) then
            //call SetTerrainPathable(x, y, 0, 0, 0, 0)
            call SetTerrainPathable(x, y, PATHING_TYPE_FLOATABILITY, false)
            call SetTerrainPathable(x, y, PATHING_TYPE_WALKABILITY, true)
        else
            //call SetTerrainPathable(x, y, 0, 0, 0, 0)
            call SetTerrainPathable(x, y, PATHING_TYPE_FLOATABILITY, true)
            call SetTerrainPathable(x, y, PATHING_TYPE_WALKABILITY, false)
        endif
        call CreateUbersplat(x, y, "NMED", 255, 255, 255, 0, false, false)
    else
        call IssueImmediateOrder(caster, "stop")
        call SimError(GetOwningPlayer(caster), GetLocalizedString("UNABLE_TO_WATER_GROUND_HERE"))
    endif
endfunction

private function TriggerConditionChannel takes nothing returns boolean
    if (GetSpellAbilityId() == 'A16T') then
        call WaterGround(GetTriggerUnit(), GetSpellTargetX(), GetSpellTargetY())
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(channelTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(channelTrigger, Condition(function TriggerConditionChannel))
endfunction

endlibrary
