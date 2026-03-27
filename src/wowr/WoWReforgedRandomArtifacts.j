library WoWReforgedRandomArtifacts initializer Init

globals
    private integer array abilityIds
    private integer abilityIdsCounter = 0
endglobals

private function RegisterItemAbility takes integer abilityId returns nothing
    set abilityIds[abilityIdsCounter] = abilityId
    set abilityIdsCounter = abilityIdsCounter + 1
endfunction

private function Init takes nothing returns nothing
    call RegisterItemAbility('AIt6')
    call RegisterItemAbility('AIt9')
    call RegisterItemAbility('AId0')
    call RegisterItemAbility('AId4')
    call RegisterItemAbility('AId5')
    call RegisterItemAbility('AId7')
    call RegisterItemAbility('AIx1')
    call RegisterItemAbility('AIx2')
    call RegisterItemAbility('AIx3')
    call RegisterItemAbility('AIx4')
    call RegisterItemAbility('AI2m')
    call RegisterItemAbility('AIl2')
endfunction

function RandomizeItemAbility takes item whichItem returns nothing
    if (BlzGetItemAbilityByIndex(whichItem, 1) != null) then
        call BlzItemRemoveAbility(whichItem, BlzGetAbilityId(BlzGetItemAbilityByIndex(whichItem, 1)))
    endif
    call BlzItemAddAbility(whichItem, abilityIds[GetRandomInt(0, abilityIdsCounter - 1)])
endfunction

function InitialRandomizeItemAbility takes item whichItem returns nothing
    if (BlzGetItemAbilityByIndex(whichItem, 1) == null) then
        call RandomizeItemAbility(whichItem)
    endif
endfunction

endlibrary
