library WoWReforgedHeroGlow initializer Init requires WorldBounds

// Hide the hero glow ability to hide the buff icon.

globals
    public constant integer ABILITY_ID = 'A071'
    public constant integer BUFF_ID = 'B00B'
    
    private trigger enterTrigger = CreateTrigger()
endglobals

private function TriggerActionEnter takes nothing returns nothing
    if (GetUnitAbilityLevel(GetTriggerUnit(), ABILITY_ID) > 0) then
        call BlzUnitHideAbility(GetTriggerUnit(), ABILITY_ID, true)
        call BlzUnitHideAbility(GetTriggerUnit(), BUFF_ID, true)
        //call BJDebugMsg("Hide hero glow ability for " + GetUnitName(GetTriggerUnit()))
    endif
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterEnterRegion(enterTrigger, WorldBounds.worldRegion, null)
    call TriggerAddAction(enterTrigger, function TriggerActionEnter)
endfunction

endlibrary
