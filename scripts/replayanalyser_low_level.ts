const ReplayParser = require("w3gjs/dist/lib/parsers/ReplayParser").default;
const fs = require("fs");
const filePath = process.argv[2];
//console.log("Replay file path: " + filePath);

// https://github.com/PBug90/w3gjs/blob/master/src/parsers/ActionParser.ts
const typeLabels = {
  [0x10]: "UnitBuildingAbilityActionNoParams",
  [0x11]: "UnitBuildingAbilityActionTargetPosition",
  [0x12]: "UnitBuildingAbilityActionTargetPositionTargetObjectId",
  [0x51]: "TransferResourcesAction",
  [0x13]: "GiveItemToUnitAciton",
  [0x14]: "UnitBuildingAbilityActionTwoTargetPositions",
  [0x16]: "ChangeSelectionAction",
  [0x17]: "AssignGroupHotkeyAction", // leave game block id: 0x17;
  [0x18]: "SelectGroupHotkeyAction",
  [0x19]: "SelectSubgroupAction",
  [0x1d]: "CancelHeroRevival",
  [0x65]: "ChooseHeroSkillSubmenu",
  [0x66]: "ChooseHeroSkillSubmenu",
  [0x67]: "EnterBuildingSubmenu",
  [0x61]: "ESCPressedAction",
  [0x1e]: "RemoveUnitFromBuildingQueue",
  [0x1f]: "RemoveUnitFromBuildingQueue",
  [0x1a]: "PreSubselectionAction",
  [0x6b]: "W3MMDAction",
  [0x79]: "CommandFrameAction",
  [0x76]: "MouseAction",
  [0x73]: "BlzCacheClearUnitAction",
  [0x78]: "BlzSyncAction"
};

(async () => {
  const buffer = fs.readFileSync(filePath);
  const parser = new ReplayParser();
  parser.on("basic_replay_information", (info) => {
    //console.log(JSON.stringify(info, null, "\t"))
  });
  parser.on("gamedatablock", (block) => {
    //console.log(JSON.stringify(block, null, "\t"));

    if (block.id != null && block.commandBlocks != null) {
      for (let item of block.commandBlocks) {
        if (item.actions != null && item.actions.length > 0) { // item.playerId > 1 &&

          //console.log(JSON.stringify(item, null, "\t"));

          var actions = [];

          for (let a of item.actions) {
            a.name = (typeof a).name;
            a.idhex = "0x" + a.id.toString(16);
            a.type = typeLabels[a.id] ? typeLabels[a.id] : "unknown";
            actions.push(a);
          }

          var p = {
            playerId: item.playerId,
            actions: actions
          };

          console.log(JSON.stringify(p, null, "\t"));
        }
      }
    }
  });
  const result = await parser.parse(buffer);
  //console.log(JSON.stringify(result, null, "\t"));
})().catch(console.error);
