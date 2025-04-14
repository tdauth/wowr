REM https://pbug90.github.io/w3gjs/
REM npm install -g w3gjs
node replayanalyser_high_level.ts "C:\\Users\\Tamino\\Documents\\Warcraft III\\Errors\\2025-04-05 20.50.53 914e7d20\\TempReplay.w3g" >./replays/replay_high_level.json
node replayanalyser_low_level.ts "C:\\Users\\Tamino\\Documents\\Warcraft III\\Errors\\2025-04-05 20.50.53 914e7d20\\TempReplay.w3g" >./replays/replay_low_level.json
pause
