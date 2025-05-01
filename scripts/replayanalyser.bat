REM https://pbug90.github.io/w3gjs/
REM npm install w3gjs
REM set replay="C:\\Users\\Tamino\\Documents\\Warcraft III\\Errors\\2025-04-05 20.50.53 914e7d20\\TempReplay.w3g"
REM set replay=".\\replays\\desync\\2025-03-29 17.15.01 f9edca4c\\TempReplay.w3g"
REM set replay=".\\replays\\desync\\2025-04-05 20.47.52 899b4664\\TempReplay.w3g"
REM set replay=".\\replays\\desync\\2025-03-31 01.07.01 d1898034\\TempReplay.w3g"
REM set replay=".\\replays\\desync\\2025-03-30 17.14.46 5c0a162c\\TempReplay.w3g"
REM set replay=".\\replays\\desync\\2025-03-30 23.50.52 03a7ce94\\TempReplay.w3g"
REM set replay="..\\replays\\desync\\2025-04-27 16.20.09 62cc5948"
REM set replayf=%replay%\\TempReplay.w3g
REM set replay="..\\replays\\melee\\aaaaaa"
REM set replayf=%replay%\\aaaaaa.w3g
REM set replay="..\\replays\\warchasers"
REM set replayf=%replay%\\warchasers.w3g
REM set replay="..\\replays\\wowr"
REM set replayf=%replay%\\WoWReforged4.0Short.w3g
REM set replayf=%replay%\\WoWReforged4.0ShortNoMouseUtils.w3g
set replay="..\\replays\\desync\\2025-05-01 22.10.52 44fdea8c"
set replayf=%replay%\\TempReplay.w3g
node replayanalyser_high_level.ts %replayf% >%replay%/replay_high_level.json
node replayanalyser_low_level.ts %replayf% >%replay%/replay_low_level.json
pause
