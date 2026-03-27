library WoWReforgedRecordPlayer initializer Init requires PagedButtonsUI, QueueUI

globals
    private trigger sellTrigger = CreateTrigger()
    private trigger deathTrigger = CreateTrigger()

    private hashtable h = InitHashtable()
endglobals

private function GetMusicFromRecordPlayer takes unit recordPlayer returns sound
    return LoadSoundHandle(h, GetHandleId(recordPlayer), 0)
endfunction

private function StopMusicFromRecordPlayer takes unit recordPlayer returns nothing
    local sound s = GetMusicFromRecordPlayer(recordPlayer)
    if (s != null) then
        call StopSound(s, false, false)
    endif
endfunction

private function PlayMusicFromRecordPlayer takes unit recordPlayer, sound s returns nothing
    call StopMusicFromRecordPlayer(recordPlayer)
    call SaveSoundHandle(h, GetHandleId(recordPlayer), 0, s)
    call PlaySoundOnUnitBJ(s, 100.0, recordPlayer)
endfunction

private function FlushRecordPlayer takes unit recordPlayer returns nothing
    call StopMusicFromRecordPlayer(recordPlayer)
    call FlushChildHashtable(h, GetHandleId(recordPlayer))
endfunction

function IsRecordPlayer takes integer unitTypeId returns boolean
    return unitTypeId == RECORD_PLAYER
endfunction

function IsUnitRecordPlayer takes unit whichUnit returns boolean
    return IsRecordPlayer(GetUnitTypeId(whichUnit))
endfunction

function AddRecordPlayer takes unit whichUnit returns nothing
    call IgnoreQueueUnit(whichUnit)
    call EnablePagedButtons(whichUnit)
    call SetPagedButtonsSlotsPerPage(whichUnit, 9)
    call AddPagedButtonsUnitType(whichUnit, 'h0G3')
    call AddPagedButtonsUnitType(whichUnit, 'h0G4')
    call SetPagedButtonsCurrentPageName(whichUnit, "Azeroth")
    call AddPagedButtonsSpacersRemaining(whichUnit)
endfunction

private function TriggerConditionSell takes nothing returns boolean
    if (GetUnitTypeId(GetSoldUnit()) == MUSIC_STORM_EARTH_FIRE) then
        call RemoveUnit(GetSoldUnit())
        call SetUnitAnimation(GetSellingUnit(), "Stand Alternate")
        call PlayMusicFromRecordPlayer(GetSellingUnit(), gg_snd_PH102)
    elseif (GetUnitTypeId(GetSoldUnit()) == STOP_MUSIC) then
        call RemoveUnit(GetSoldUnit())
        call SetUnitAnimation(GetSellingUnit(), "Stand")
        call StopMusicFromRecordPlayer(GetSellingUnit())
    endif
    return false
endfunction

private function TriggerConditionDeath takes nothing returns boolean
    if (IsUnitRecordPlayer(GetTriggerUnit())) then
        call DisablePagedButtons(GetTriggerUnit())
        call FlushRecordPlayer(GetTriggerUnit())
        call SetUnitAnimation(GetTriggerUnit(), "Death")
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(sellTrigger, EVENT_PLAYER_UNIT_SELL)
    call TriggerAddCondition(sellTrigger, Condition(function TriggerConditionSell))
    
    call TriggerRegisterAnyUnitEventBJ(deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(deathTrigger, Condition(function TriggerConditionDeath))
endfunction

endlibrary
