var Translator = require('wc3maptranslator');

const inputDir = process.argv[2];
const outputDir = process.argv[3];
console.log("inputDir: " + inputDir);
console.log("outputDir: " + outputDir);

Object.keys(Translator).forEach(key => console.log(key));

const abilitiesResult = Translator.ObjectsTranslator.warToJson(inputDir + '/war3map.w3a');
fs.writeFileSync(outputDir + '/abilities.json', abilitiesResult.buffer);