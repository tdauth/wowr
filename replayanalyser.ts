const W3GReplay = require("w3gjs").default;
const parser = new W3GReplay();

(async () => {
  const result = await parser.parse("C:\\Users\\Tamino\\Documents\\Warcraft III\\Errors\\2025-04-05 20.50.53 914e7d20\\TempReplay.w3g.w3g");
  console.log(result);
})().catch(console.error);
