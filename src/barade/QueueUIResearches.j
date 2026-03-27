library QueueUIResearches initializer Init

/*
Required as a workaround to extract the correct level data for researches since there are no natives at this point in time.
Register all research data for levels higher than 0 here to fix the names and icons.
Disable to always use level 0 data.
*/

globals
    private hashtable h = InitHashtable()
    private constant integer KEY_LEVELS = 0
    private constant integer KEY_LEVEL_1 = 1 // start with level
endglobals

private struct Research
    string name
    string icon
endstruct

private function AddResearch takes integer id, string name, string icon returns nothing
    local Research this = Research.create()
    local integer level = LoadInteger(h, id, KEY_LEVELS)
    set this.name = name
    set this.icon = icon
    call SaveInteger(h, id, KEY_LEVEL_1 + level, this)
    call SaveInteger(h, id, KEY_LEVELS, level + 1)
endfunction

private function GetResearch takes integer id, player whichPlayer returns Research
    local integer level = GetPlayerTechCount(whichPlayer, id, true)
    if (level > 0) then
        return LoadInteger(h, id, level) // start with level 1
    endif
    return 0
endfunction

public function GetName takes integer id, player whichPlayer returns string
    local Research r = GetResearch(id, whichPlayer)
    if (r != 0) then
        return r.name
    endif
    return GetObjectName(id)
endfunction

public function GetIcon takes integer id, player whichPlayer returns string
    local Research r = GetResearch(id, whichPlayer)
    if (r != 0) then
        return r.icon
    endif
    return BlzGetAbilityIcon(id)
endfunction

private function Init takes nothing returns nothing
    // Human
    call AddResearch('Rhme', "Steel Forged Swords", "ReplaceableTextures\\CommandButtons\\BTNThoriumMelee.blp")
    call AddResearch('Rhme', "Mithril Forged Swords", "ReplaceableTextures\\CommandButtons\\BTNArcaniteMelee.blp")
    call AddResearch('Rhra', "Refined Gunpowder", "ReplaceableTextures\\CommandButtons\\BTNHumanMissileUpTwo.blp")
    call AddResearch('Rhra', "Imbued Gunpowder", "ReplaceableTextures\\CommandButtons\\BTNHumanMissileUpThree.blp")
    call AddResearch('Rhla', "Reinforced Leather Armor", "ReplaceableTextures\\CommandButtons\\BTNLeatherUpgradeTwo.blp")
    call AddResearch('Rhla', "Dragonhide Armor", "ReplaceableTextures\\CommandButtons\\BTNLeatherUpgradeThree.blp")
    call AddResearch('Rhar', "Steel Plating", "ReplaceableTextures\\CommandButtons\\BTNHumanArmorUpTwo.blp")
    call AddResearch('Rhar', "Mithril Plating", "ReplaceableTextures\\CommandButtons\\BTNHumanArmorUpThree.blp")
    call AddResearch('Rhlh', "Advanced Lumber Harvesting", "ReplaceableTextures\\CommandButtons\\BTNHumanLumberUpgrade2.blp")
    call AddResearch('Rhac', "Advanced Masonry", "ReplaceableTextures\\CommandButtons\\BTNArcaniteArchitecture.blp")
    call AddResearch('Rhac', "Imbued Masonry", "ReplaceableTextures\\CommandButtons\\BTNImbuedMasonry.blp")
    call AddResearch('Rhpt', "Priest Master Training", "ReplaceableTextures\\CommandButtons\\BTNPriestMaster.blp")
    call AddResearch('Rhst', "Sorceress Master Training", "ReplaceableTextures\\CommandButtons\\BTNSorceressMaster.blp")
    
    // Orc
    call AddResearch('Rost', "Shaman Master Training", "ReplaceableTextures\\CommandButtons\\BTNShamanMaster.blp")
    call AddResearch('Rosp', "Improved Spiked Barricades", "ReplaceableTextures\\CommandButtons\\BTNImprovedSpikedBarricades.blp")
    call AddResearch('Rosp', "Advanced Spiked Barricades", "ReplaceableTextures\\CommandButtons\\BTNAdvancedSpikedBarricades.blp")
    call AddResearch('Rowt', "Spirit Walker Master Training", "ReplaceableTextures\\CommandButtons\\BTNSpiritWalkerMasterTraining.blp")
    call AddResearch('Roar', "Thorium Armor", "ReplaceableTextures\\CommandButtons\\BTNThoriumArmor.blp")
    call AddResearch('Roar', "Arcanite Armor", "ReplaceableTextures\\CommandButtons\\BTNArcaniteArmor.blp")
    call AddResearch('Rome', "Thorium Melee Weapons", "ReplaceableTextures\\CommandButtons\\BTNOrcMeleeUpTwo.blp")
    call AddResearch('Rome', "Arcanite Melee Weapons", "ReplaceableTextures\\CommandButtons\\BTNOrcMeleeUpThree.blp")
    call AddResearch('Rora', "Thorium Ranged Weapons", "ReplaceableTextures\\CommandButtons\\BTNThoriumRanged.blp")
    call AddResearch('Rora', "Arcanite Ranged Weapons", "ReplaceableTextures\\CommandButtons\\BTNArcaniteRanged.blp")
    call AddResearch('Rowd', "Witch Doctor Master Training", "ReplaceableTextures\\CommandButtons\\BTNWitchDoctorMaster.blp")
    
    // Undead
    call AddResearch('Ruba', "Banshee Master Training", "ReplaceableTextures\\CommandButtons\\BTNBansheeMaster.blp")
    call AddResearch('Rura', "Improved Creature Attack", "ReplaceableTextures\\CommandButtons\\BTNImprovedCreatureAttack.blp")
    call AddResearch('Rura', "Advanced Creature Attack", "ReplaceableTextures\\CommandButtons\\BTNAdvancedCreatureAttack.blp")
    call AddResearch('Rucr', "Improved Creature Carapace", "ReplaceableTextures\\CommandButtons\\BTNImprovedCreatureCarapace.blp")
    call AddResearch('Rucr', "Advanced Creature Carapace", "ReplaceableTextures\\CommandButtons\\BTNAdvancedCreatureCarapace.blp")
    call AddResearch('Rune', "Necromancer Master Training", "ReplaceableTextures\\CommandButtons\\BTNNecromancerMaster.blp")
    call AddResearch('Ruar', "Improved Unholy Armor", "ReplaceableTextures\\CommandButtons\\BTNImprovedUnholyArmor.blp")
    call AddResearch('Ruar', "Advanced Unholy Armor", "ReplaceableTextures\\CommandButtons\\BTNAdvancedUnholyArmor.blp")
    call AddResearch('Rume', "Improved Unholy Strength", "ReplaceableTextures\\CommandButtons\\BTNImprovedUnholyStrength.blp")
    call AddResearch('Rume', "Advanced Unholy Strength", "ReplaceableTextures\\CommandButtons\\BTNAdvancedUnholyStrength.blp")
    
    // Night Elf
    call AddResearch('Redc', "Druid of the Claw Master Training", "ReplaceableTextures\\CommandButtons\\BTNDOCMasterTraining.blp")
    call AddResearch('Redt', "Druid of the Talon Master Training", "ReplaceableTextures\\CommandButtons\\BTNDOTMasterTraining.blp")
    call AddResearch('Rema', "Improved Moon Armor", "ReplaceableTextures\\CommandButtons\\BTNImprovedMoonArmor.blp")
    call AddResearch('Rema', "Advanced Moon Armor", "ReplaceableTextures\\CommandButtons\\BTNAdvancedMoonArmor.blp")
    call AddResearch('Rerh', "Improved Reinforced Hides", "ReplaceableTextures\\CommandButtons\\BTNImprovedReinforcedHides.blp")
    call AddResearch('Rerh', "Advanced Reinforced Hides", "ReplaceableTextures\\CommandButtons\\BTNAdvancedReinforcedHides.blp")
    call AddResearch('Resm', "Improved Strength of the Moon", "ReplaceableTextures\\CommandButtons\\BTNImprovedStrengthOfTheMoon.blp")
    call AddResearch('Resm', "Advanced Strength of the Moon", "ReplaceableTextures\\CommandButtons\\BTNAdvancedStrengthOfTheMoon.blp")
    call AddResearch('Resw', "Improved Strength of the Wild", "ReplaceableTextures\\CommandButtons\\BTNImprovedStrengthOfTheWild.blp")
    call AddResearch('Resw', "Advanced Strength of the Wild", "ReplaceableTextures\\CommandButtons\\BTNAdvancedStrengthOfTheWild.blp")
    
    // Naga
    call AddResearch('Rnat', "Chitinous Blades", "ReplaceableTextures\\CommandButtons\\BTNNagaWeaponUp2.blp")
    call AddResearch('Rnat', "Razorspine Blades", "ReplaceableTextures\\CommandButtons\\BTNNagaWeaponUp3.blp")
    call AddResearch('Rnam', "Chitinous Scales", "ReplaceableTextures\\CommandButtons\\BTNNagaArmorUp2.blp")
    call AddResearch('Rnam', "Razorspine Scales", "ReplaceableTextures\\CommandButtons\\BTNNagaArmorUp3.blp")
    call AddResearch('Rnsw', "Naga Siren Master Training", "ReplaceableTextures\\CommandButtons\\BTNSirenMaster.blp")
endfunction

endlibrary
