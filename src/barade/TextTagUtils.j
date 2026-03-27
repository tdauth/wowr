library TextTagUtils

function ShowTextTagForForce takes force whichForce, texttag textTag, boolean show returns nothing
    if (IsPlayerInForce(GetLocalPlayer(), whichForce)) then
        call SetTextTagVisibility(textTag, show)
    endif
endfunction

function ShowFadingTextTagForForce takes force whichForce, string text, real size, real x, real y, integer red, integer green, integer blue, integer alpha, real velocity, real fadepoint, real lifespan returns nothing
    local texttag textTag = CreateTextTag()
    call SetTextTagText(textTag, text, size)
    call SetTextTagPos(textTag, x, y, 0.0)
    call SetTextTagColor(textTag, red, green, blue, alpha)
    call SetTextTagVelocity(textTag, 0.0, velocity)
    if (whichForce == null) then
        call SetTextTagVisibility(textTag, true)
    else
        call ShowTextTagForForce(whichForce, textTag, true)
    endif
    call SetTextTagFadepoint(textTag, fadepoint)
    call SetTextTagLifespan(textTag, lifespan)
    call SetTextTagPermanent(textTag, false)
    set textTag = null
endfunction

function ShowGeneralFadingTextTagForForce takes force whichForce, string text, real x, real y, integer red, integer green, integer blue, integer alpha returns nothing
    call ShowFadingTextTagForForce(whichForce, text, 0.025, x, y, red, green, blue, alpha, 0.03, 1.0, 2.0)
endfunction

function ShowGoldTextTagForForce takes force whichForce, real x, real y, integer gold returns nothing
    call ShowFadingTextTagForForce(whichForce, "+" + I2S(gold), 0.025, x, y, 255, 220, 0, 255, 0.03, 1.0, 2.0)
endfunction

function ShowLumberTextTagForForce takes force whichForce, real x, real y, integer lumber returns nothing
    call ShowFadingTextTagForForce(whichForce, "+" + I2S(lumber), 0.025, x, y, 0, 200, 80, 255, 0.03, 1.0, 2.0)
endfunction

function ShowBountyTextTagForForce takes force whichForce, real x, real y, integer bounty returns nothing
    call ShowFadingTextTagForForce(whichForce, "+" + I2S(bounty), 0.025, x, y, 255, 220, 0, 255, 0.03, 2.0, 3.0)
endfunction

function ShowMissTextTagForForce takes force whichForce, real x, real y returns nothing
    call ShowFadingTextTagForForce(whichForce, GetLocalizedString("MISS") + "!", 0.025, x, y, 255, 0, 0, 255, 0.03, 1.0, 3.0)
endfunction

function ShowCriticalStrikeTextTagForForce takes force whichForce, real x, real y, integer damage returns nothing
    call ShowFadingTextTagForForce(whichForce, I2S(damage) + "!", 0.025, x, y, 255, 0, 0, 255, 0.04, 2.0, 5.0)
endfunction

function ShowShadowStrikeTextTagForForce takes force whichForce, real x, real y, integer damage returns nothing
    call ShowFadingTextTagForForce(whichForce, I2S(damage) + "!", 0.025, x, y, 160, 255, 0, 255, 0.04, 2.0, 5.0)
endfunction

function ShowManaBurnTextTagForForce takes force whichForce, real x, real y, integer damage returns nothing
    call ShowFadingTextTagForForce(whichForce, "-" + I2S(damage), 0.025, x, y, 82, 82, 255, 255, 0.04, 2.0, 5.0)
endfunction

function ShowBashTextTagForForce takes force whichForce, real x, real y, integer damage returns nothing
    call ShowFadingTextTagForForce(whichForce, I2S(damage) + "!", 0.025, x, y, 255, 0, 0, 255, 0.04, 2.0, 5.0)
endfunction

function Bounty takes force whichForce, real x, real y, integer bounty returns nothing
    local string effectPath = ""
    local effect whichEffect
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        if (IsPlayerInForce(Player(i), whichForce)) then
            call SetPlayerState(Player(i), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(Player(i), PLAYER_STATE_RESOURCE_GOLD) + bounty)
        endif
        set i = i + 1
    endloop
    if (IsPlayerInForce(GetLocalPlayer(), whichForce)) then
        set effectPath = "UI\\Feedback\\GoldCredit\\GoldCredit.mdl"
    endif
    set whichEffect = AddSpecialEffect(effectPath, x, y)
    call DestroyEffect(whichEffect)
    set whichEffect = null
    call ShowBountyTextTagForForce(whichForce, x, y, bounty)
endfunction

function BountyLumber takes force whichForce, real x, real y, integer bounty returns nothing
    local string effectPath = ""
    local effect whichEffect
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        if (IsPlayerInForce(Player(i), whichForce)) then
            call SetPlayerState(Player(i), PLAYER_STATE_RESOURCE_LUMBER, GetPlayerState(Player(i), PLAYER_STATE_RESOURCE_LUMBER) + bounty)
        endif
        set i = i + 1
    endloop
    if (IsPlayerInForce(GetLocalPlayer(), whichForce)) then
        set effectPath = "Abilities\\Spells\\Items\\ResourceItems\\ResourceEffectTarget.mdl"
    endif
    set whichEffect = AddSpecialEffect(effectPath, x, y)
    call DestroyEffect(whichEffect)
    set whichEffect = null
    call ShowLumberTextTagForForce(whichForce, x, y, bounty)
endfunction

globals
    private texttag enumTextTag = null
    private texttag array allTextTags
    private integer allTextTagsCounter = 0
    private hashtable h = InitHashtable()
endglobals

function AddTextTag takes texttag t returns nothing
    local integer handleId = GetHandleId(t)
    if (not HaveSavedHandle(h, handleId, 0)) then
        set allTextTags[allTextTagsCounter] = t
        set allTextTagsCounter = allTextTagsCounter + 1
        call SaveTextTagHandle(h, handleId, 0, t)
    endif
endfunction

function AddLastCreatedTextTag takes nothing returns nothing
    call AddTextTag(GetLastCreatedTextTag())
endfunction

private function SetTextTagTextHook takes texttag t, string s, real height returns nothing
    call AddTextTag(t)
endfunction

private function RemoveTextTagFromAll takes texttag t returns nothing
    local boolean found = false
    local integer i = 0
    loop
        exitwhen (i >= allTextTagsCounter)
        if (found) then
            set allTextTags[i - 1] = allTextTags[i]
        elseif (allTextTags[i] == t) then
            set found = true
        endif
        set i = i + 1
    endloop
endfunction

private function DestroyTextTagHook takes texttag t returns nothing
    local integer handleId = GetHandleId(t)
    if (HaveSavedHandle(h, handleId, 0)) then
        call RemoveTextTagFromAll(t)
        call FlushChildHashtable(h, handleId)
    endif
endfunction

private function SetTextTagPermanentHook takes texttag t, boolean permanent returns nothing
    local integer handleId = GetHandleId(t)
    if (not permanent and HaveSavedHandle(h, handleId, 0)) then
        call RemoveTextTagFromAll(t)
        call FlushChildHashtable(h, handleId)
    endif
endfunction

function GetEnumTextTag takes nothing returns texttag
    return enumTextTag
endfunction

function ForAllTextTags takes code f returns nothing
    local integer i = 0
    loop
        exitwhen (i >= allTextTagsCounter)
        set enumTextTag = allTextTags[i]
        call NewOpLimit(f)
        set i = i + 1
    endloop
endfunction

hook SetTextTagText SetTextTagTextHook
hook DestroyTextTag DestroyTextTagHook
hook SetTextTagPermanent SetTextTagPermanentHook
hook SetTextTagPermanentBJ SetTextTagPermanentHook

endlibrary
