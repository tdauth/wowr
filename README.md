# World of Warcraft Reforged

Warcraft III: Reforged fun map based on [World of Warcraft Reborn](https://www.hiveworkshop.com/threads/world-of-warcraft-reborn.80480/#resource-3941) which has been created by the users DeMoNiKuS and EvilPitlord.
DeMoNiKuS modified the map World of Warcraft by EvilPitlord.
It is an open world RPG map in which each player chooses a hero in the beginning and can play either as warlord or as freelancer.
Warlords can build a base, collect resources and reward freelancers for their work.
Freelancers have higher start attributes and gain faster experience but cannot build a base or collect resources.
However, they can be rewarded by warlords and build a hideout.
Alliances can be forged between players and quests can be solved which are rewarded with useful items.
Usually, the map has a very long play time since players build their bases and defeat the bosses after some time.
The map can only be won by killing the final boss.

## Play the Map

* [Discord Server](https://discord.gg/eM34z36)
* [Official download on Hiveworkshop](https://www.hiveworkshop.com/threads/world-of-warcraft-tsr-1-4.304616/)
* [Current development version](./wowr1.7.w3x)

*Issues with HD graphics:* HD graphics might lead to a weak performance and desyncs.

## How to Play

Usually, it is the best to ally one Freelancer with one Warlord from the beginning.
The Warlord can support the Freelancer with units, resources and XP and the Freelancer can level faster.
Alliances can be made via Warcraft's menu. Build many custom goldmines as Warlords to collect gold much faster.
Defend your base with towers and close the gates if necessary.
Strong bases are almost impossible to conquer.
Find some good creep spots or enemies (maybe Warlord AI) to level your hero constantly.
A big army helps leveling much faster, so either train and upgrade units or get support from a Warlord.
Prevent hostile players from leveling and completing quests by hunting them down constantly.
However, this could lead to making them leave quickly and it's not the best strategy if you want to play a long game.
You can change alliances and offer others your services to get an alliance in return.
This strategy works best for new players who need some support in the beginning.
Killing bosses and completing quests will give you better items and a big advantage during fights.

## New Features

This version provides several new features compared to the original map:

* 24 players instead of 10.
* Backpack system.
* Repicking your hero with the chat command '-repick'.
* Increased maximum hero level.
* Increased maximum hero ability levels.
* Every hero can learn the ability 'Attribute Bonus'.
* Increased boss hero levels.
* New heroes from the TFT patches are available.
* Trees have 5000 hitpoints which allows longer harvesting before restoring the trees.
* Night Elves workers harvest 10 lumber per interval as balance.
* The race item can be dropped.
* Naga can build a shop.
* Naga villagers can walk on water.
* Increased the maximum supply to 300 and the supply cost levels to 100 and 200.
* New race: Demon.
* Added Outland area with a new boss.
* New Outland area with four goldmines and four quests.
* Outland portals all over the map.
* '-nowin' replaced 'nodefeat'. The game can be won by killing the final boss in the Outland area.
* Hand of God at level 35.
* Ability 'Reward Freelancer' in all main buildings.
* Ability 'Give Units to Another Allied Player' in all main buildings.
* Random hero support.
* Freelancers gain more experience than warlords from killing hostile units.
* Basic support AI for computer-controlled warlord players.
* Chat command '-players'.
* The number of towers is limited for all players.
* Hero selection has been moved to the Outland area.
* Secret chamber at level 40 for special heroes.
* Chat command '-ping'.
* Acolytes can build goldmines on Undead housings.
* Spell books for crafting have no cooldown after crafting items.
* Citizens can build harbours.
* Ships and Zeppelins cost food to keep their number limited.
* Theramore contains a market with killed creeps and dropped items.
* Bonus heroes can be chosen at level 40.
* XP bonus from Tier 2 and Tier 3 for every hero.
* No Chaos damage for Naga and Blood Elf anymore.
* Blood Elf can train Sorceress.
* Blood Elf upgrades are not visible to Human anymore.
* New race: Draenei.
* New hero: Akama.
* New upgrade: Evolution.
* New Forsaken quest: Legendary Items.
* New Lich King quest: The Burning Legion.

## Bug Fixes

This version contains fixes of several bugs from the original map:

* When placing a building at creep spawns, the creeps will respawn when the building is destroyed. In the original map the creeps did never respawn again.
* The quest with Maiev was bugged in the original map. Maiev could not be moved.
* Summoned units won't respawn again like regular creeps.
* Undead housings can be used as Undead goldmines.

## Computer AI

The map uses Warcraft's AI for computer players.

### Warlords

The following files are imported into the map whenever they are updated. They contain a very basic warlord AI for computer players:

* [Human.ai](./ai/Human.ai)
* [Orc.ai](./ai/Orc.ai)
* [Undead.ai](./ai/Undead.ai)
* [NightElf.ai](./ai/NightElf.ai)
* [Naga.ai](./ai/Naga.ai)
* [BloodElf.ai](./ai/BloodElf.ai)
* [Demon.ai](./ai/Demon.ai)
* [Draenei.ai](./ai/Draenei.ai)

The face is determined from the race set in the lobby of the game.
If the race is Night Elf it will either be Night Elf or Naga.
If the race is Human it will either be Human or Blood Elf.
Warlord computer players start with a town hall and workers besides their hero.
Whenever they lose all workers and town halls, they will get a new town hall automatically to rebuild their base.

### Freelancers

The following files are imported into the map whenever they are updated. They contain a very basic freelancer AI for computer players:

* [HumanFreelancer.ai](./ai/HumanFreelancer.ai)
* [OrcFreelancer.ai](./ai/OrcFreelancer.ai)
* [UndeadFreelancer.ai](./ai/UndeadFreelancer.ai)
* [NightElfFreelancer.ai](./ai/NightElfFreelancer.ai)

Currently, the freelancer AI mode is disabled. All computer players will choose the game mode warlord.

## Replays

Some interesting replays are stored in [replays](./replays).

## Crashes

At the moment the map seems to end after some time. We played some games for one hour and suddenly the game ended and all players saw the score screen.
Hence, I am trying to collect replays with the game ending to reconstruct the bug.

[crashes](./crashes) contains folders with map and replay files of the corresponding games.

## Reconstruction

The original map had no trigger data, so all triggers had to be recreated based on the original map script.
The original map script has been added to this repository as well as the original map strings:

* [war3map.j](./original_map/war3map.j)
* [war3map.wts](./translations/war3map.wts)

## Old Versions

**Note:** Some of these versions might have been optimized:

* [wowtsr1.6.w3x](./releases/wowtsr1.6.w3x)
* [wowtsr1.5.w3x](./releases/wowtsr1.5.w3x)
* [wowtsr1.4.w3x](./releases/wowtsr1.4.w3x)
* [wowtsr1.3.w3x](./releases/wowtsr1.3.w3x)
* [wowtsr1.2.w3x](./releases/wowtsr1.2.w3x)
* [wowtsr1.1.w3x](./releases/wowtsr1.1.w3x)

## Credits

* Baradé: Creator.
* Deranor: Tests.
* Runeblade14: Tests.
* EvilPitlord: Original map.
* DeMoNiKuS: Original map.