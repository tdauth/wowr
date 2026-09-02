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

function GetQuestItemIndex takes quest whichQuest, questitem whichQuestItem returns integer
        local integer handleId = GetHandleId(whichQuest)
        local integer counter = LoadInteger(h, handleId, KEY_COUNTER)
        local integer i = 0
        local questitem existing = null
        loop
            exitwhen (i >= counter)
            set existing = LoadQuestItemHandle(h, handleId, i)
            if (existing == whichQuestItem) then
                return i
            endif
            set i = i + 1
        endloop
        return -1
endfunction

function AddQuestItemToQuest takes quest whichQuest, questitem whichQuestItem returns integer
    local integer handleId = GetHandleId(whichQuest)
    local integer counter = LoadInteger(h, handleId, KEY_COUNTER)
    local integer index = GetQuestItemIndex(whichQuest, whichQuestItem)
    if (index == -1) then
        call SaveQuestItemHandle(h, handleId, counter, whichQuestItem)
        call SaveInteger(h, handleId, KEY_COUNTER, counter + 1)
        set index = counter
    endif
    return index
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

private function QuestSetTitleHook takes quest whichQuest, string title returns nothing
    call SaveStr(h, GetHandleId(whichQuest), KEY_TITLE, title)
endfunction

private function QuestSetDescriptionHook takes quest whichQuest, string description returns nothing
    call SaveStr(h, GetHandleId(whichQuest), KEY_DESCRIPTION, description)
endfunction

private function QuestItemSetDescriptionHook takes questitem whichQuestItem, string description returns nothing
    call SaveStr(h, GetHandleId(whichQuestItem), KEY_DESCRIPTION, description)
endfunction

private function DestroyQuestHook takes quest whichQuest returns nothing
    local integer handleId = GetHandleId(whichQuest)
    local integer i = 0
    local integer max = LoadInteger(h, handleId, KEY_COUNTER)
    local questitem qi = null

    loop
        exitwhen (i >= max)
        set qi = LoadQuestItemHandle(h, handleId, i)
        if (qi != null) then
            call FlushChildHashtable(h, GetHandleId(qi))
            set qi = null
        endif
        set i = i + 1
    endloop

    call FlushChildHashtable(h, handleId)
endfunction

private function CreateQuestBJHook takes integer questType, string title, string description, string iconPath returns nothing
    set lastQuestTitle = title
    set lastQuestDescription = description
endfunction

private function GetLastCreatedQuestBJHook takes nothing returns nothing
    if (not HaveSavedString(h, GetHandleId(bj_lastCreatedQuest), KEY_TITLE)) then
        call QuestSetTitleHook(bj_lastCreatedQuest, lastQuestTitle)
    endif
    if (not HaveSavedString(h, GetHandleId(bj_lastCreatedQuest), KEY_DESCRIPTION)) then
        call QuestSetDescriptionHook(bj_lastCreatedQuest, lastQuestDescription)
    endif
endfunction

private function CreateQuestItemBJHook takes quest whichQuest, string description returns nothing
    set lastQuestForQuestItem = whichQuest
    set lastQuestItemDescription = description
endfunction

private function GetLastCreatedQuestItemBJHook takes nothing returns nothing
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
hook GetLastCreatedQuestItemBJ GetLastCreatedQuestItemBJHook

endlibrary
