var Translator = require('wc3maptranslator');
const fs = require('fs');

const inputDir = process.argv[2];
const outputDir = process.argv[3];
console.log("inputDir: " + inputDir);
console.log("outputDir: " + outputDir);

//Object.keys(Translator).forEach(key => console.log(key));

fs.readFile(inputDir + '/war3map.w3a', function(err, data) {
    var abilitiesResult = new Translator.Objects.warToJson(data, 'abilities'); // << specify 'abilities' as first argument. pass in `data` from reading the file, not the file path
    fs.writeFileSync(outputDir + '/abilities.json', JSON.stringify(abilitiesResult.json, null, 4)); // << use abilitiesResult.json, not abilitiesResult.buffer
});