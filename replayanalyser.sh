#!/bin/bash
# https://pbug90.github.io/w3gjs/
npm install w3gjs # installs the lib globally
node replayanalyser_high_level.ts "$HOME/Downloads/3237553800_Jens_HawK_Autumn Leaves 20.w3g" > ./replays/replay_high_level.json
node replayanalyser_low_level.ts "$HOME/Downloads/3237553800_Jens_HawK_Autumn Leaves 20.w3g" > ./replays/replay_low_level.json
