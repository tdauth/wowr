library WoWReforgedMapVotes initializer Init requires Votes

private function Add takes string title, string choice, trigger whichTrigger returns nothing
    local integer vote = VoteCreate(title)
    //call VoteAddYesChoice(vote)
    call VoteAddChoice(vote, false, choice, choice)
    call VoteSetStartChatCommand(vote, choice)
    call VoteSetYesTrigger(vote, whichTrigger)
endfunction

private function Init takes nothing returns nothing
    call Add(GetLocalizedStringSafe("CIN_DALARAN"), "-cindalaran", gg_trg_Cinematics_Dalaran)
endfunction

endlibrary
