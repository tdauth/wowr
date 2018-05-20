# World of Warcraft The Second Rebirth
This is a Warcraft III: The Frozen Throne map based on [World of Warcraft Reborn](https://www.hiveworkshop.com/threads/world-of-warcraft-reborn.80480/#resource-3941) which has been made by the users DeMoNiKuS.
DeMoNiKuS modified the map World of Warcraft by the user EvilPitlord.
It is an RPG map where every player chooses a hero in the beginning and can either play as warlord or as freelancer.
Warlords can build a base, collect resources and reward freelancers for their work.
Freelancers have more start attributes and gain faster experience but cannot build a base or collect resources.
Alliances can be forged between players and quests can be solved which are rewarded with useful items.
Usually, the map has a very long play time since players build their bases and defeat the bosses after some time.
The map can only be won by killing the final boss.

## Normal Version of the Map
* [Version 1.4](./wowtsr.w3x) which works with patch 1.29.

## Optimized Versions of the Map
* [Version 1.3](./releases/wowtsr1.3.w3x) which works with patch 1.28.
* [Version 1.2](./releases/wowtsr1.2.w3x)
* [Version 1.1](./releases/wowtsr1.1.w3x)

## New Features (Version 1.4)
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
* Added Outland area with a new boss.
* New Outland area with four goldmines and four quests.
* Outland portals all over the map.
* '-nowin' replaced 'nodefeat'. The game can be won by killing the final boss in the Outland area.
* Hand of God at level 35.
* Ability 'Reward Freelancer' in all main buildings.
* Ability 'Give Units to Another Allied Player' in all main buildings.
* Random hero support.
* Freelancers gain more experience from killing hostile units.

## Bugfixes
It does also fix several bugs of the original map:
* When placing a building at creep spawns, the creeps will respawn when the building is destroyed. In the original map the creeps did never respawn again.
* The quest with Maiev was bugged in the original map. Maiev could not be moved.
* Summoned units won't respawn again like regular creeps.

## Reconstruction
The original map had no trigger data, so all triggers had to be recreated based on the original map script.
The original map script has been added to this repository as well as the original map strings:
* [war3map.j](./original_map/war3map.j)
* [war3map.wts](./translations/war3map.wts)

## Links
* [English Map on Hiveworkshop](https://www.hiveworkshop.com/threads/world-of-warcraft-tsr-1-4.304616/)
* [German inWarcraft.de Thread](https://warcraft.ingame.de/forum/threads/215354-World-of-Warcraft-The-Second-Rebirth)
* [English Blog](https://diemachtdesfeuers.wordpress.com/)