set dir="C:\Users\Tamino\Documents\Projekte\wowr"
set map=%dir%\wowr.w3x
%dir%\pjass.exe -v
for /F "delims=" %%f in ('dir /s/b %map%\*.ai') do (
   (Echo "%%f" | FIND /I "common.ai" 1>NUL) || (
        %dir%\pjass.exe %map%\scripts\common.j %map%\scripts\common.ai %dir%\wc3reforged\Blizzard.j "%%f"
   )
)
for /F "delims=" %%f in ('dir /s/b %map%\*.pld') do %dir%\pjass.exe %map%\scripts\common.j %map%\scripts\common.ai "%%f"
for /F "delims=" %%f in ('dir /s/b %map%\*.j') do (
   (Echo "%%f" | FIND /I "common.j" 1>NUL) || (
        %dir%\pjass.exe %map%\scripts\common.j %map%\scripts\common.ai %dir%\wc3reforged\Blizzard.j "%%f"
   )
)
for /F "delims=" %%f in ('dir /s/b %map%\*.fdf') do java -cp %dir%\* com.etheller.warsmash.fdfparser.Main "%%f"

pause
