library Villager255
/**
 * https://www.hiveworkshop.com/threads/villager-255-animations.192204/
 * https://www.hiveworkshop.com/threads/villager-255-animation-index-list-and-how-to-remove-the-animation-delay.263727/
 */

globals
    constant integer VILLAGER_255_ANIMATION_STAND = 0
    constant integer VILLAGER_255_ANIMATION_ATTACK_NO_WEAPON = 1
    constant integer VILLAGER_255_ANIMATION_ATTACK_TWO_HAND_SWORD = 2
    constant integer VILLAGER_255_ANIMATION_ATTACK_SHIELD = 3
    constant integer VILLAGER_255_ANIMATION_ATTACK_BOW = 4
    constant integer VILLAGER_255_ANIMATION_ATTACK_THROW_SPEAR = 5
    constant integer VILLAGER_255_ANIMATION_ATTACK_SPEAR = 6
    constant integer VILLAGER_255_ANIMATION_ATTACK_TWO_HAND_LANCE = 7
    constant integer VILLAGER_255_ANIMATION_ATTACK_TWO_HAND_HAMMER = 8
    constant integer VILLAGER_255_ANIMATION_ATTACK_TWO_WEAPONS = 9
    constant integer VILLAGER_255_ANIMATION_ATTACK_LEFT_HAND_WEAPON = 10
    constant integer VILLAGER_255_ANIMATION_ATTACK_RIGHT_HAND_WEAPON = 11
    constant integer VILLAGER_255_ANIMATION_ATTACK_MINIGUN = 12
    constant integer VILLAGER_255_ANIMATION_ATTACK_TWO_HAND = 13
    constant integer VILLAGER_255_ANIMATION_ATTACK_SHOOT_GUN = 14

    private integer array animations
    private integer animationsCounter = 0
endglobals

public function ResetAnimations takes nothing returns nothing
    set animationsCounter = 0
endfunction

public function AddAnimation takes integer index returns nothing
    set animations[animationsCounter] = index
    set animationsCounter = animationsCounter + 1
endfunction

public function GetRandomAnimation takes nothing returns integer
    return animations[GetRandomInt(0, animationsCounter - 1)]
endfunction

function SetVillager255Animation takes unit whichUnit, integer category returns nothing
    //call BJDebugMsg("Play animation with category " + I2S(category))
    // [1] [2] [3] - Stand Animation Regular
    if (category == VILLAGER_255_ANIMATION_STAND) then
        call SetUnitAnimationByIndex(whichUnit, GetRandomInt(0, 2))
    // Attack 1 - 15, no weapon
    elseif (category == VILLAGER_255_ANIMATION_ATTACK_NO_WEAPON) then
        call SetUnitAnimationByIndex(whichUnit, GetRandomInt(13, 20))
        //call BJDebugMsg("Attack without weapon")
    // Attack Alternate 1 - 9, two handed sword
    elseif (category == VILLAGER_255_ANIMATION_ATTACK_TWO_HAND_SWORD) then
        call SetUnitAnimationByIndex(whichUnit, GetRandomInt(27, 29))
    // Attack Defend 1 - 2, attack with buckler
    // basically this should be already provided by the animation tag "defend"
    elseif (category == VILLAGER_255_ANIMATION_ATTACK_SHIELD) then
        call SetUnitAnimationByIndex(whichUnit, 112)
        //call BJDebugMsg("Attack with buckler")
    // Attack throw 6 - 7, bow
    elseif (category == VILLAGER_255_ANIMATION_ATTACK_BOW) then
        call SetUnitAnimationByIndex(whichUnit, GetRandomInt(122, 123))
        //call BJDebugMsg("Attack with bow")
    // throwing spear
    elseif (category == VILLAGER_255_ANIMATION_ATTACK_THROW_SPEAR) then
        call SetUnitAnimationByIndex(whichUnit, 118) //  119
        //call BJDebugMsg("Attack with a throwing spear")
    // attacking with spear in melee
    elseif (category == VILLAGER_255_ANIMATION_ATTACK_SPEAR) then
        call SetUnitAnimationByIndex(whichUnit, 117)
        //call BJDebugMsg("Attack with spear in melee")
    // attacking with two handed lance
    elseif (category == VILLAGER_255_ANIMATION_ATTACK_TWO_HAND_LANCE) then
        call SetUnitAnimationByIndex(whichUnit, 61)
        //call BJDebugMsg("Attack with two handed lance")
    // attacking with two handed hammer
    elseif (category == VILLAGER_255_ANIMATION_ATTACK_TWO_HAND_HAMMER) then
        call SetUnitAnimationByIndex(whichUnit, 62)
        //call BJDebugMsg("Attack with two handed hammer")
    // attack with a weapon in each hand -> no buckler in right hand
    elseif (category == VILLAGER_255_ANIMATION_ATTACK_TWO_WEAPONS) then
        // attack either with left or right hand TODO animation for both hands?
        call ResetAnimations()
        call AddAnimation(21)
        call AddAnimation(22)
        call AddAnimation(40)
        call AddAnimation(41)
        call AddAnimation(23)
        call AddAnimation(24)
        call AddAnimation(25)
        call AddAnimation(26)
        call SetUnitAnimationByIndex(whichUnit, GetRandomAnimation())
        //call BJDebugMsg("Attack with two weapons")
    // Attack with one left handed weapon
    elseif (category == VILLAGER_255_ANIMATION_ATTACK_LEFT_HAND_WEAPON) then
        call ResetAnimations()
        call AddAnimation(21)
        call AddAnimation(41)
        call AddAnimation(42)
        call AddAnimation(23)
        call AddAnimation(25)
        call SetUnitAnimationByIndex(whichUnit, GetRandomAnimation())
        //call BJDebugMsg("Attack with one left handed weapon")
    // Attack with one right handed weapon
    elseif (category == VILLAGER_255_ANIMATION_ATTACK_RIGHT_HAND_WEAPON) then
        call ResetAnimations()
        call AddAnimation(22)
        call AddAnimation(39)
        call AddAnimation(40)
        call AddAnimation(24)
        call AddAnimation(26)
        call SetUnitAnimationByIndex(whichUnit, GetRandomAnimation())
    elseif (category == VILLAGER_255_ANIMATION_ATTACK_MINIGUN) then
        call ResetAnimations()
        call AddAnimation(150)
        call AddAnimation(156)
        call SetUnitAnimationByIndex(whichUnit, GetRandomAnimation())
    elseif (category == VILLAGER_255_ANIMATION_ATTACK_SHOOT_GUN) then
        call ResetAnimations()
        call AddAnimation(148)
        call AddAnimation(149)
        call AddAnimation(151)
        call AddAnimation(154)
        call AddAnimation(155)
        call AddAnimation(157)
        call SetUnitAnimationByIndex(whichUnit, GetRandomAnimation())
    elseif (category == VILLAGER_255_ANIMATION_ATTACK_TWO_HAND) then
        call SetUnitAnimationByIndex(whichUnit, GetRandomInt(56, 59))
    endif
endfunction

endlibrary
