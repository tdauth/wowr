D:\wowr\pjass.exe -v
for %%f in (D:\wowr\wowr.w3x\war3mapImported\*.ai) do D:\wowr\pjass.exe D:\wowr\wowr.w3x\scripts\common.j D:\wowr\wowr.w3x\scripts\common.ai "%%f"
for %%f in (D:\wowr\wowr.w3x\*.j) do D:\wowr\pjass.exe D:\wowr\wowr.w3x\scripts\common.j D:\wowr\wowr.w3x\scripts\common.ai D:\wowr\wc3reforged\Blizzard.j "%%f"

pause
