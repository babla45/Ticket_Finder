@echo off
setlocal EnableDelayedExpansion

title Railway Cartesian Product Generator

:: SETTINGS
set date=23-May-2026
set class=S_CHAIR

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
set /p choice=Enter combination (example 2x3): 

for /f "tokens=1,2 delims=xX" %%a in ("%choice%") do (
    set g1=%%a
    set g2=%%b
)

echo.
echo Opening Cartesian Product...
echo.

:: GET GROUP CONTENTS
call set "list1=%%group%g1%%%"
call set "list2=%%group%g2%%%"

:: REPLACE COMMAS WITH SPACES
set "list1=!list1:,= !"
set "list2=!list2:,= !"

:: LOOP THROUGH GROUP 1
for %%A in (!list1!) do (

    :: LOOP THROUGH GROUP 2
    for %%B in (!list2!) do (

        set "from=%%A"
        set "to=%%B"

        echo !from! -> !to!

        set "url=https://eticket.railway.gov.bd/booking/train/search?fromcity=!from!^&tocity=!to!^&doj=%date%^&class=%class%"

        echo !url!

        start msedge "!url!"

        timeout /t 1 >nul
    )
)

echo.
echo Done.
pause