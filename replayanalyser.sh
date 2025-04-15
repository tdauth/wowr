#!/bin/bash
# https://pbug90.github.io/w3gjs/
npm install w3gjs # installs the lib globally

find ./replays/ -name "*.w3g" | while IFS= read -r file; do
    echo "$file"
    DIR="$(dirname "${file}")"
    FILE="$(basename "${file}")"
    node replayanalyser_high_level.ts "$file" > "$DIR"/replay_high_level.json
    node replayanalyser_low_level.ts "$file" > "$DIR"/replay_low_level.json
done
