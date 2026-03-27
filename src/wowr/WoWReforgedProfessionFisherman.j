library WoWReforgedProfessionFisherman requires SimError

private function ShowFishFloatingText takes unit hero, item whichItem returns nothing
    local force whichForce = CreateForce()
    call ForceAddPlayer(whichForce, GetOwningPlayer(hero))
    call ShowGeneralFadingTextTagForForce(whichForce, Format(GetLocalizedString("CRAFT_BONUS")).i(GetItemCharges(whichItem)).s(GetItemName(whichItem)).result(), GetUnitX(hero), GetUnitY(hero), 0, 0, 0, 0)
    call ForceClear(whichForce)
    call DestroyForce(whichForce)
    set whichForce = null
endfunction

private function ShowNoFishFloatingText takes unit hero returns nothing
    local force whichForce = CreateForce()
    call ForceAddPlayer(whichForce, GetOwningPlayer(hero))
    call ShowGeneralFadingTextTagForForce(whichForce, GetLocalizedString("NO_FISH"), GetUnitX(hero), GetUnitY(hero), 0, 0, 0, 0)
    call ForceClear(whichForce)
    call DestroyForce(whichForce)
    set whichForce = null
endfunction

function CreateFishForFishingRod takes unit hero returns item
    local item whichItem = null
    if (GetRandomInt(0, 100) <= 60) then
        set whichItem = UnitAddItemById(hero, 'I0KN')
        if (GetRandomInt(0, 100) <= 15) then
            call SetItemCharges(whichItem, GetItemCharges(whichItem) + GetRandomInt(2, 6))
        endif
        
        call ShowFishFloatingText(hero, whichItem)
        
        return whichItem
    else
        call ShowNoFishFloatingText(hero)
    endif
    
    return null
endfunction

function UseFishingRod takes unit hero, real x, real y returns nothing
    if (not IsTerrainPathable(x, y, PATHING_TYPE_FLOATABILITY)) then
        call CreateFishForFishingRod(hero)
    else
        call IssueImmediateOrder(hero, "stop")
        call SimError(GetOwningPlayer(hero), GetLocalizedString("TARGET_AREA_MUST_BE_WATER"))
    endif
endfunction

function SellFishToFishMarket takes unit hero, unit shop, item whichItem returns nothing
    local integer gold = GetItemCharges(whichItem) * 10
    call AdjustPlayerStateBJ(gold, GetOwningPlayer(hero), PLAYER_STATE_RESOURCE_GOLD)
    call Bounty(bj_FORCE_PLAYER[GetPlayerId(GetOwningPlayer(hero))], GetUnitX(shop), GetUnitY(shop), gold)
endfunction

endlibrary
