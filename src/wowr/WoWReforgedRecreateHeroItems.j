library WoWReforgedRecreateHeroItems requires SimError, WoWReforgedUtils, WoWReforgedRaces, WoWReforgedProfessions

private function UnitAddItemByIdIfNotInInventory takes unit hero, integer itemTypeId returns item
    if (not UnitHasItemOfTypeBJ(hero, itemTypeId)) then
        return UnitAddItemById(hero, itemTypeId)
    endif
    return null
endfunction

function RecreateHeroItems takes player whichPlayer returns nothing
    if (GetPlayerHero1(whichPlayer) != null) then
        if (GetPlayerProfession1(whichPlayer) != udg_ProfessionNone) then
            call UnitAddItemByIdIfNotInInventory(GetPlayerHero1(whichPlayer), GetProfessionBookItemTypeId(GetPlayerProfession1(whichPlayer)))
        endif
        if (GetPlayerProfession2(whichPlayer) != udg_ProfessionNone and GetPlayerProfession2(whichPlayer) != GetPlayerProfession1(whichPlayer)) then
            call UnitAddItemByIdIfNotInInventory(GetPlayerHero1(whichPlayer), GetProfessionBookItemTypeId(GetPlayerProfession2(whichPlayer)))
        endif
        if (GetPlayerProfession3(whichPlayer) != udg_ProfessionNone and GetPlayerProfession3(whichPlayer) != GetPlayerProfession2(whichPlayer) and GetPlayerProfession3(whichPlayer) != GetPlayerProfession1(whichPlayer)) then
            call UnitAddItemByIdIfNotInInventory(GetPlayerHero1(whichPlayer), GetProfessionBookItemTypeId(GetPlayerProfession3(whichPlayer)))
        endif
        if (GetPlayerRace1(whichPlayer) != udg_RaceNone) then
            call UnitAddItemByIdIfNotInInventory(GetPlayerHero1(whichPlayer), GetRaceObjectTypeId(GetPlayerRace1(whichPlayer), RACE_OBJECT_TYPE_SCEPTER_ITEM))
        endif
        if (GetPlayerRace2(whichPlayer) != udg_RaceNone and GetPlayerRace2(whichPlayer) != GetPlayerRace1(whichPlayer)) then
            call UnitAddItemByIdIfNotInInventory(GetPlayerHero1(whichPlayer), GetRaceObjectTypeId(GetPlayerRace2(whichPlayer), RACE_OBJECT_TYPE_SCEPTER_ITEM))
        endif
        if (GetPlayerRace3(whichPlayer) != udg_RaceNone and GetPlayerRace3(whichPlayer) != GetPlayerRace2(whichPlayer) and GetPlayerRace3(whichPlayer) != GetPlayerRace1(whichPlayer)) then
            call UnitAddItemByIdIfNotInInventory(GetPlayerHero1(whichPlayer), GetRaceObjectTypeId(GetPlayerRace3(whichPlayer), RACE_OBJECT_TYPE_SCEPTER_ITEM))
        endif
        call DisplayTextToPlayer(whichPlayer, 0.0, 0.0, GetLocalizedString("RECREATED_ITEMS"))
    else
        call SimError(whichPlayer, GetLocalizedString("DOT_NO_HERO_1"))
    endif
endfunction

endlibrary
