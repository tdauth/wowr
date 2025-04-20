const W3GReplay = require("w3gjs").default;
const parser = new W3GReplay();
const filePath = process.argv[2];
//console.log("Replay file path: " + filePath);

(async () => {
  const result = await parser.parse(filePath);
  console.log(JSON.stringify(result, null, "\t"));
})().catch(console.error);