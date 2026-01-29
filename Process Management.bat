@echo off
rem Process Management (Allow the user to view running processes, terminate a process, or start a new process.)

:submenu
cls
echo.
echo --- Process Management Menu ---
echo.
echo 1. View Running Processes
echo 2. View Detailed Process Information
echo 3. Terminate a Process
echo 4. Start a New Process
echo.
set /p choice=Choose an option ^(1-4^) or 'q' to quit: 
if "%choice%"=="1" goto viewprocesses
if "%choice%"=="2" goto detailedprocesses
if "%choice%"=="3" goto terminateprocess
if "%choice%"=="4" goto startprocess
if "%choice%"=="q" exit /b 0
echo Invalid choice. Please try again.
pause
goto submenu

:viewprocesses
rem View Running Processes
echo.
echo --- Running Processes ---
tasklist
echo.
pause
goto submenu

:detailedprocesses
rem View Detailed Process Information
echo.
echo --- Detailed Process Information ---
echo.
set "processname="
set /p processname=Enter process name ^(e.g., notepad.exe^) or press Enter to view all: 
if [%processname%]==[] (
	tasklist /v
) else (
	set processname=%processname:"=%
	tasklist /fi "imagename eq %processname%" /v
)
echo.
pause
goto submenu

:terminateprocess
rem Terminate a Process
echo.
echo --- Terminate a Process ---
echo.
set "processkill="
set /p processkill=Enter process name or PID to terminate: 
if [%processkill%]==[] (
    echo.
	echo Process name or PID cannot be empty.
    echo.
	pause
	goto submenu
)
set processkill=%processkill:"=%
echo.
echo Terminating processes can cause data loss.
set /p confirm=Are you sure you want to terminate "%processkill%"? ^(y/n^): 
if /i "%confirm%"=="y" (
	call set processkill=%processkill%
	taskkill /f /im "%processkill%" 2>nul
	if errorlevel 1 (
		taskkill /f /pid "%processkill%" 2>nul
	)
	echo.
) else (
	echo Termination cancelled.
)
pause
goto submenu

:startprocess
rem Start a New Process
echo.
echo --- Start a New Process ---
echo.
set "program="
set /p program=Enter program path to start ^(e.g., C:\Program Files\notepad.exe^): 
set program=%program:"=%
if ["%program%"]==[] (
	echo Program name cannot be empty.
	pause
	goto submenu
)
call set program=%program%
start "" "%program%"
echo.

pause
goto submenu