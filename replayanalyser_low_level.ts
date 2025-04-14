const ReplayParser = require("w3gjs/dist/lib/parsers/ReplayParser").default;
const fs = require("fs");
const filePath = process.argv[2];
//console.log("Replay file path: " + filePath);

(async () => {
  const buffer = fs.readFileSync(filePath);
  const parser = new ReplayParser();
  parser.on("basic_replay_information", (info) => console.log(JSON.stringify(info, null, "\t")));
  parser.on("gamedatablock", (block) => console.log(JSON.stringify(block, null, "\t")));
  const result = await parser.parse(buffer);
  console.log(JSON.stringify(result, null, "\t"));
})().catch(console.error);