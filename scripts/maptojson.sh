#!/bin/bash
# https://github.com/ChiefOfGxBxL/WC3MapTranslator
npm install wc3maptranslator # installs the lib globally

INPUT_DIR="../wowr.w3x/"
OUTPUT_DIR="./json"
node maptojson.ts "$INPUT_DIR" "$OUTPUT_DIR"
