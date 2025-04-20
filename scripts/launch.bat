set version=3.36
set wc3="C:\Program Files (x86)\Warcraft III\_retail_\x86_64\Warcraft III.exe"
REM --launch --classicui --assert --window --productcode=w3
REM https://www.hiveworkshop.com/threads/complete-command-line-arguments-guide.288224/
%wc3% -legacykerning -loadfile "C:\Users\Tamino\Documents\Projekte\wowr\releases\wowr%version%.w3x" -windowmode windowed
pause
