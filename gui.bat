@echo off
setlocal EnableDelayedExpansion

title Railway Cartesian Product Generator

:: SETTINGS
set class=S_CHAIR

:: LOAD DATES
echo ==============================
echo   AVAILABLE DATES
echo ==============================
set dateCount=0
for /f "usebackq" %%D in (`powershell -NoProfile -Command "0..10 | ForEach-Object { (Get-Date).AddDays($_).ToString('dd-MMM-yyyy') }"`) do (
    set /a dateCount+=1
    set "travelDate!dateCount!=%%D"
    echo !dateCount! = %%D
)
echo.

:: LOAD GROUPS
set count=0

for /f "usebackq delims=" %%A in ("groups.txt") do (
    set /a count+=1
    set "group!count!=%%A"
)

echo ==============================
echo   AVAILABLE GROUPS
echo ==============================
echo.

for /L %%i in (1,1,%count%) do (
    echo %%i = !group%%i!
)

echo.
set /p choice=Enter date index and combination (example 1 2x3): 

for /f "tokens=1,2,3 delims=xX " %%a in ("%choice%") do (
    set dateIndex=%%a
    set g1=%%b
    set g2=%%c
)

call set "selectedDate=%%travelDate!dateIndex!%%"

echo.
echo Opening Cartesian Product for !selectedDate!...
echo.

:: GET GROUP CONTENTS
call set "list1=%%group!g1!%%"
call set "list2=%%group!g2!%%"

:: REPLACE COMMAS WITH SPACES
set "list1=!list1:,= !"
set "list2=!list2:,= !"

:: LOOP THROUGH GROUP 1
for %%A in (!list1!) do (

    :: LOOP THROUGH GROUP 2
    for %%B in (!list2!) do (

        set "from=%%A"
        set "to=%%B"

        echo !from! -^> !to!

        set "url=https://eticket.railway.gov.bd/booking/train/search?fromcity=!from!^&tocity=!to!^&doj=!selectedDate!^&class=%class%"

        echo !url!

        start msedge "!url!"

        timeout /t 1 >nul
    )
)

echo.
echo Done.
pause