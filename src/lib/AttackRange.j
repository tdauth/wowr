library AttackRange
/*
https://www.hiveworkshop.com/threads/snippet-set-unit-range-partial-fix-set-unit-aoe-small-fix.352220/
https://www.hiveworkshop.com/threads/list-of-non-working-object-data-constants.317769/#post-3523488
*/

function SetUnitAttackRange takes unit u, real newRange returns nothing
    call BlzSetUnitWeaponRealField(u, UNIT_WEAPON_RF_ATTACK_RANGE, 1, newRange - BlzGetUnitWeaponRealField(u, UNIT_WEAPON_RF_ATTACK_RANGE, 0) + BlzGetUnitWeaponRealField(u, UNIT_WEAPON_RF_ATTACK_RANGE, 1))
endfunction

endlibrary
