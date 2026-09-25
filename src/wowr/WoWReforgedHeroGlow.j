library WoWReforgedHeroGlow initializer Init requires WorldBounds

// Hide the hero glow ability to hide the buff icon.

globals
    private trigger enterTrigger = CreateTrigger()
endglobals

private function TriggerActionEnter takes nothing returns nothing
    if (GetUnitAbilityLevel(GetTriggerUnit(), HERO_GLOW_ABILITY_ID) > 0) then
        call BlzUnitHideAbility(GetTriggerUnit(), HERO_GLOW_ABILITY_ID, true)
        call BlzUnitHideAbility(GetTriggerUnit(), HERO_GLOW_BUFF_ID, true)
        //call BJDebugMsg("Hide hero glow ability for " + GetUnitName(GetTriggerUnit()))
    endif
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterEnterRegion(enterTrigger, WorldBounds.worldRegion, null)
    call TriggerAddAction(enterTrigger, function TriggerActionEnter)
endfunction

endlibrary
