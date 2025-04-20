set dir=..
set scriptsdir=%dir%\scripts\
set map=%dir%\wowr.w3x
%scriptsdir%\pjass.exe -v
for /F "delims=" %%f in ('dir /s/b %map%\*.ai') do (
   (Echo "%%f" | FIND /I "common.ai" 1>NUL) || (
        %scriptsdir%\pjass.exe %map%\scripts\common.j %map%\scripts\common.ai %dir%\wc3\Blizzard.j "%%f"
   )
)
for /F "delims=" %%f in ('dir /s/b %map%\*.pld') do %scriptsdir%\pjass.exe %map%\scripts\common.j %map%\scripts\common.ai "%%f"
for /F "delims=" %%f in ('dir /s/b %map%\*.j') do (
   (Echo "%%f" | FIND /I "common.j" 1>NUL) || (
        %scriptsdir%\pjass.exe %map%\scripts\common.j %dir%\wc3\Blizzard.j "%%f"
   )
)
for /F "delims=" %%f in ('dir /s/b %map%\*.fdf') do java -cp %scriptsdir%\* com.etheller.warsmash.fdfparser.Main "%%f"
for /F "delims=" %%f in ('dir /s/b %dir%\out\*.j') do %scriptsdir%\pjass.exe %map%\scripts\common.j %dir%\wc3\Blizzard.j "%%f"

pause
