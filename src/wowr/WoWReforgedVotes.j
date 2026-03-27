library WoWReforgedVotes requires Votes
    
function AddWowReforgedVote takes nothing returns nothing
    local integer vote = VoteCreate(udg_TmpString)
    //call VoteAddYesChoice(vote)
    call VoteAddChoice(vote, false, udg_TmpString2, udg_TmpString2)
    call VoteSetStartChatCommand(vote, udg_TmpString2)
    call VoteSetYesTrigger(vote, udg_TmpTrigger)
endfunction

endlibrary
