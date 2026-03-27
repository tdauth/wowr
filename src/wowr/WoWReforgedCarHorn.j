library WoWReforgedCarHorn initializer Init

globals
    private constant integer ABILITY_ID = 'A23N'
    private sound array hornSound
    private integer hornSoundCounter = 0
    
    private trigger castTrigger = CreateTrigger()
endglobals

private function PlayCarHornSound takes unit whichUnit returns nothing
    local integer r = GetRandomInt(0, hornSoundCounter - 1)
    call PlaySoundOnUnitBJ(hornSound[r], 100.0, whichUnit)
endfunction

private function AddHornSound takes sound whichSound returns nothing
    set hornSound[hornSoundCounter] = whichSound
    set hornSoundCounter = hornSoundCounter + 1
endfunction

private function TriggerConditionCast takes nothing returns boolean
    if (GetSpellAbilityId() == ABILITY_ID) then
        call PlayCarHornSound(GetTriggerUnit())
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call AddHornSound(gg_snd_War3CarHonk02)
    call AddHornSound(gg_snd_War3CarHonk03)
    call AddHornSound(gg_snd_War3CarHonk05)
    call AddHornSound(gg_snd_War3CarHonk08)
    
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))
endfunction

endlibrary
