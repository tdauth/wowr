set dir="C:\Users\Tamino\Documents\Projekte\wowr"
set map=%dir%\wowr.w3x
%dir%\pjass.exe -v
for %%f in (%map%\war3mapImported\*.ai) do %dir%\pjass.exe %map%\scripts\common.j %map%\scripts\common.ai "%%f"
for %%f in (%map%\wowr.w3x\*.j) do %map%\pjass.exe %map%\scripts\common.j %map%\scripts\common.ai %map%\wc3reforged\Blizzard.j "%%f"

pause
