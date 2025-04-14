const ReplayParser = require("w3gjs/dist/lib/parsers/ReplayParser").default;
const fs = require("fs");
const filePath = process.argv[2];
//console.log("Replay file path: " + filePath);

(async () => {
  const buffer = fs.readFileSync(filePath);
  const parser = new ReplayParser();
  parser.on("basic_replay_information", (info) => {
    //console.log(JSON.stringify(info, null, "\t"))
  });
  parser.on("gamedatablock", (block) => {
    //console.log(JSON.stringify(block, null, "\t"));

    // https://github.com/PBug90/w3gjs/blob/master/src/parsers/ActionParser.ts
    if (block.id != null && block.commandBlocks != null) {
      for (let item of block.commandBlocks) {
        if (item.playerId > 1 && item.actions != null && item.actions.length > 0) {

            //console.log(JSON.stringify(item, null, "\t"));
          var actions = [];

          for (let a of item.actions) {
            a.name = (typeof a).name;
            a.idhex = "0x" + a.id.toString(16);
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
