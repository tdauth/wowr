library QuestUtils

globals
    private hashtable h = InitHashtable()
    private constant integer KEY_TITLE = 0
    private constant integer KEY_DESCRIPTION = 1
    private constant integer KEY_COUNTER = 2
    
    private string lastQuestTitle = ""
    private string lastQuestDescription = ""
    private quest lastQuestForQuestItem = null
    private string lastQuestItemDescription = ""
endglobals

function QuestMessageForPlayer takes player whichPlayer, integer messageType, string message returns nothing
    local force f = GetForceOfPlayer(whichPlayer)
    call QuestMessageBJ(f, messageType, message)
    call ForceClear(f)
    call DestroyForce(f)
    set f = null
endfunction

function AddQuestItemToQuest takes quest whichQuest, questitem whichQuestItem returns integer
    local integer handleId = GetHandleId(whichQuest)
    local integer counter = LoadInteger(h, handleId, KEY_COUNTER)
    call SaveQuestItemHandle(h, handleId, counter, whichQuestItem)
    call SaveInteger(h, handleId, KEY_COUNTER, counter + 1)
    return counter
endfunction

function AddLastQuestItemToLastQuest takes nothing returns integer
    return AddQuestItemToQuest(bj_lastCreatedQuest, bj_lastCreatedQuestItem)
endfunction

function CreateQuestItem takes quest whichQuest, string description returns questitem
    set bj_lastCreatedQuestItem = QuestCreateItem(whichQuest)
    call QuestItemSetDescription(bj_lastCreatedQuestItem, description)
    call QuestItemSetCompleted(bj_lastCreatedQuestItem, false)
    call AddLastQuestItemToLastQuest()
    return bj_lastCreatedQuestItem
endfunction

function AddQuestItem takes string description returns questitem
    return CreateQuestItem(bj_lastCreatedQuest, description)
endfunction

function QuestGetTitle takes quest whichQuest returns string
    return LoadStr(h, GetHandleId(whichQuest), KEY_TITLE)
endfunction

function QuestGetDescription takes quest whichQuest returns string
    return LoadStr(h, GetHandleId(whichQuest), KEY_DESCRIPTION)
endfunction

function QuestGetItemCount takes quest whichQuest returns integer
    return LoadInteger(h, GetHandleId(whichQuest), KEY_COUNTER)
endfunction

function QuestGetItem takes quest whichQuest, integer index returns questitem
    return LoadQuestItemHandle(h, GetHandleId(whichQuest), index)
endfunction

function QuestItemGetDescription takes questitem whichQuestItem returns string
    return LoadStr(h, GetHandleId(whichQuestItem), KEY_DESCRIPTION)
endfunction

function QuestSetTitleHook takes quest whichQuest, string title returns nothing
    call SaveStr(h, GetHandleId(whichQuest), KEY_TITLE, title)
endfunction

function QuestSetDescriptionHook takes quest whichQuest, string description returns nothing
    call SaveStr(h, GetHandleId(whichQuest), KEY_DESCRIPTION, description)
endfunction

function QuestItemSetDescriptionHook takes questitem whichQuestItem, string description returns nothing
    call SaveStr(h, GetHandleId(whichQuestItem), KEY_DESCRIPTION, description)
endfunction

function DestroyQuestHook takes quest whichQuest returns nothing
    call FlushChildHashtable(h, GetHandleId(whichQuest))
endfunction

function CreateQuestBJHook takes integer questType, string title, string description, string iconPath returns nothing
    set lastQuestTitle = title
    set lastQuestDescription = description
endfunction

function GetLastCreatedQuestBJHook takes nothing returns nothing
    if (not HaveSavedString(h, GetHandleId(bj_lastCreatedQuest), KEY_TITLE)) then
        call QuestSetTitleHook(bj_lastCreatedQuest, lastQuestTitle)
    endif
    if (not HaveSavedString(h, GetHandleId(bj_lastCreatedQuest), KEY_DESCRIPTION)) then
        call QuestSetDescriptionHook(bj_lastCreatedQuest, lastQuestDescription)
    endif
endfunction

function CreateQuestItemBJHook takes quest whichQuest, string description returns nothing
    set lastQuestForQuestItem = whichQuest
    set lastQuestItemDescription = description
endfunction

function UpdateLastQuestItem takes nothing returns nothing
    call QuestItemSetDescriptionHook(bj_lastCreatedQuestItem, lastQuestItemDescription)
    call AddQuestItemToQuest(lastQuestForQuestItem, bj_lastCreatedQuestItem)
endfunction

hook QuestSetTitle QuestSetTitleHook
hook QuestSetTitleBJ QuestSetTitleHook
hook QuestSetDescription QuestSetDescriptionHook
hook QuestSetDescriptionBJ QuestSetDescriptionHook
hook QuestItemSetDescription QuestItemSetDescriptionHook
hook QuestItemSetDescriptionBJ QuestItemSetDescriptionHook
hook DestroyQuest DestroyQuestHook
hook DestroyQuestBJ DestroyQuestHook
hook CreateQuestBJ CreateQuestBJHook
hook GetLastCreatedQuestBJ GetLastCreatedQuestBJHook
hook CreateQuestItemBJ CreateQuestItemBJHook
hook GetLastCreatedQuestItemBJ UpdateLastQuestItem

endlibrary
