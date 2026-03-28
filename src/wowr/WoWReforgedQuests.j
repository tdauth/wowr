library WoWReforgedQuests requires QuestUtils, StringFormat

globals
    private integer questsMax = 0
    private quest array questHandle
    private string array questId
    private string array questTitle
    private string array questDescription
    private string array questIcon
    private unit array questNpc
    private integer array questReward
    private integer array questRequirement
    
    private string tmpIconPath = null
    private string tmpTitle = null
    private string tmpDescription = null
    private integer tmpRequirement = -1
endglobals

private function AddQuestWoWReforged takes nothing returns integer
    local integer index = questsMax
    set questId[index] = udg_TmpString
    set questIcon[index] = tmpIconPath
    set questTitle[index] = tmpTitle
    set questDescription[index] = tmpDescription
    set questNpc[index] = udg_TmpUnit
    set questReward[index] = udg_TmpItemTypeId
    set questRequirement[index] = tmpRequirement
    set questsMax = questsMax + 1

    return index
endfunction

function GetQuestsMax takes nothing returns integer
    return questsMax
endfunction

function GetQuest takes integer q returns quest
    return questHandle[q]
endfunction

function GetQuestId takes integer q returns string
    return questId[q]
endfunction

function GetQuestIcon takes integer q returns string
    return questIcon[q]
endfunction

function GetQuestTitle takes integer q returns string
    return questTitle[q]
endfunction

function GetQuestDescription takes integer q returns string
    return questDescription[q]
endfunction

function GetQuestNpc takes integer q returns unit
    return questNpc[q]
endfunction

function GetQuestReward takes integer q returns integer
    return questReward[q]
endfunction

function GetQuestRequirement takes integer q returns integer
    return questRequirement[q]
endfunction

function SetQuestRequirementToLast takes nothing returns nothing
    set tmpRequirement = IMaxBJ(GetQuestsMax() - 1, 0)
endfunction

function SetQuestNoRequirement takes nothing returns nothing
    set tmpRequirement = -1
endfunction

private function CreateQuestBJHook takes integer questType, string title, string description, string iconPath returns nothing
    local boolean required = (questType == bj_QUESTTYPE_REQ_DISCOVERED) or (questType == bj_QUESTTYPE_REQ_UNDISCOVERED)

    if (not required) then
        set tmpIconPath = iconPath
        set tmpTitle = GetLocalizedString(title)
        set tmpDescription = GetLocalizedString(description) // Barade: this leads some how to a cut off string on the website
        
        call AddQuestWoWReforged()
    endif
endfunction

hook CreateQuestBJ CreateQuestBJHook

private function GetLastCreatedQuestBJHook takes nothing returns nothing
    local integer index = questsMax - 1
    if (not IsQuestRequired(bj_lastCreatedQuest) and questHandle[index] == null) then
        set questHandle[index] = bj_lastCreatedQuest
    endif
endfunction

hook GetLastCreatedQuestBJ GetLastCreatedQuestBJHook

function AddQuest takes string id, string title, string description, string iconPath, unit npc, integer rewardItemTypeId returns quest
    local integer index = questsMax
    local quest q = CreateQuest()

    set bj_lastCreatedQuest = q
    call QuestSetTitle(q, title)
    call QuestSetDescription(q, description)
    call QuestSetIconPath(q, iconPath)
    call QuestSetRequired(q, false)
    call QuestSetDiscovered(q, false)
    call QuestSetCompleted(q, false)

    set questId[index] = id
    set questTitle[index] = title
    set questDescription[index] = description
    set questIcon[index] = iconPath
    set questNpc[index] = npc
    set questReward[index] = rewardItemTypeId
    set questRequirement[index] = -1
    set questsMax = questsMax + 1

    return q
endfunction

function AddQuestNext takes string id, string title, string description, string iconPath, unit npc, integer rewardItemTypeId returns quest
    local quest q = AddQuest(id, title, description, iconPath, npc, rewardItemTypeId)
    if (questsMax >= 2) then
        set questRequirement[questsMax - 1] = questsMax - 2
    endif
    return q
endfunction

function ShowQuestRewards takes player whichPlayer returns nothing
    local integer max = GetQuestsMax()
    local string message = ""
    local integer i = 0
    loop
        exitwhen (i == max)
        if (i > 0) then
            set message = message + ", "
        endif
        set message = message + GetQuestTitle(i) + ": " + GetObjectName(GetQuestReward(i))
        set i = i + 1
    endloop
    call DisplayTimedTextToPlayer(whichPlayer, 0.0, 0.0, 15.0, message)
endfunction

function AddQuestItemWoWReforged takes nothing returns nothing
    call AddQuestItem(udg_TmpString)
endfunction

/*
|cffffcc00MAIN QUEST UPDATE|r
Enchanted Gemstone
  - |cff808080Find the Enchanted Gemstone (Completed)|r
  - Bring the Enchanted Gemstone to the Spectral Bridge
  - Cairne Bloodhoof must survive
*/
private function QuestItemsMessage takes quest q returns string
    local string msg = ""
    local questitem questItem = null
    local integer i = 0
    local integer max = QuestGetItemCount(q)
    if (max > 0) then
        set msg = msg + "\n"
        loop
            exitwhen (i == max)
            set questItem = QuestGetItem(q, i)
            if (i > 0) then
                set msg = msg + "\n"
            endif
            if (IsQuestItemCompleted(questItem)) then
                set msg = msg + Format(GetLocalizedString("QUEST_ITEM_COMPLETED")).s(GetLocalizedString(QuestItemGetDescription(questItem))).result()
            else
                set msg = msg + Format(GetLocalizedString("QUEST_ITEM")).s(GetLocalizedString(QuestItemGetDescription(questItem))).result()
            endif
            set i = i + 1
        endloop
    endif
    return msg
endfunction

function QuestDiscover takes nothing returns nothing
    call FlashQuestDialogButton()
    call QuestSetDiscovered(udg_TmpQuest, true)
    call QuestMessageBJ(GetPlayersAll(), bj_QUESTMESSAGE_COMPLETED, Format(GetLocalizedString("QUEST_DISCOVERED")).s(GetLocalizedString(QuestGetTitle(udg_TmpQuest))).s(QuestItemsMessage(udg_TmpQuest)).result())
endfunction

function QuestUpdate takes nothing returns nothing
    call FlashQuestDialogButton()
    call QuestMessageBJ(GetPlayersAll(), bj_QUESTMESSAGE_UPDATED, Format(GetLocalizedString("QUEST_UPDATE")).s(GetLocalizedString(QuestGetTitle(udg_TmpQuest))).s(QuestItemsMessage(udg_TmpQuest)).result())
endfunction

function QuestCompleteItem takes integer index returns nothing
    if (index >= 0 and index <= QuestGetItemCount(udg_TmpQuest)) then
        call QuestItemSetCompleted(QuestGetItem(udg_TmpQuest, index), true)
    endif
    call QuestUpdate()
endfunction

function QuestComplete takes nothing returns nothing
    local integer i = 0
    local integer max = QuestGetItemCount(udg_TmpQuest)
    loop
        exitwhen (i == max)
        call QuestItemSetCompleted(QuestGetItem(udg_TmpQuest, i), true)
        set i = i + 1
    endloop
    call FlashQuestDialogButton()
    call QuestSetCompleted(udg_TmpQuest, true)
    call QuestMessageBJ(GetPlayersAll(), bj_QUESTMESSAGE_COMPLETED, Format(GetLocalizedString("QUEST_COMPLETED")).s(GetLocalizedString(QuestGetTitle(udg_TmpQuest))).s(QuestItemsMessage(udg_TmpQuest)).result())
endfunction

endlibrary
