@echo off
rem View System Information

:submenu
cls
echo.
echo --- System Information Menu ---
echo.
echo 1. System Summary
echo 2. Detailed System Information (systeminfo)
echo 3. OS, BIOS, and Time Zone
echo 4. Processor Information
echo 5. Memory Information
echo 6. Disk Drive Information
echo 7. Hostname
echo 8. Network Interfaces
echo 9. Current Date
echo 10. Current Time
echo 11. All Information
echo.
set /p choice=Choose an option (1-10) or 'q' to quit: 
if "%choice%"=="1" goto basicinfo
if "%choice%"=="2" goto detailedsysteminfo
if "%choice%"=="3" goto computerinfo
if "%choice%"=="4" goto processorinfo
if "%choice%"=="5" goto memoryinfo
if "%choice%"=="6" goto diskinfo
if "%choice%"=="7" goto hostnameinfo
if "%choice%"=="8" goto networkinfo
if "%choice%"=="9" goto dateinfo
if "%choice%"=="10" goto timeinfo
if "%choice%"=="q" exit /b 0
else ( 
    echo Invalid choice. Please try again.
    pause
)
goto submenu

:basicinfo
rem Display Basic System Information
cls
echo.
echo Computer Name: %COMPUTERNAME%
echo User Name: %USERNAME%
echo Login Server: %LOGONSERVER%
echo User Domain: %USERDOMAIN%
echo Processor: %PROCESSOR_IDENTIFIER%
echo Number of Processors: %NUMBER_OF_PROCESSORS%
echo Architecture: %PROCESSOR_ARCHITECTURE%
echo OS: %OS%
echo.
echo Windows Version:
ver
echo.
pause
goto submenu

:detailedsysteminfo
rem Display Detailed System Information
cls
echo.
systeminfo
echo.
pause
goto submenu

:computerinfo
rem Display Computer Information
cls
echo.
systeminfo | findstr /C:"OS Name" /C:"OS Version" /C:"System Type" /C:"System Locale" /C:"Time Zone"
echo.
pause
goto submenu

:processorinfo
rem Display Processor Information
cls
echo.
echo Basic Info:
echo Processor: %PROCESSOR_IDENTIFIER%
echo Number of Processors: %NUMBER_OF_PROCESSORS%
echo Architecture: %PROCESSOR_ARCHITECTURE%
echo.
echo Detailed Info:
systeminfo | findstr /C:"Processor(s)"
echo.
pause
goto submenu

:memoryinfo
rem Display Memory Information
cls
echo.
systeminfo | findstr /C:"Total Physical Memory" /C:"Available Physical Memory" /C:"Virtual Memory"
echo.
pause
goto submenu

:diskinfo
rem Display Disk Drive Information
cls
echo.
echo Available Drives:
fsutil fsinfo drives
echo.
echo Disk Space Information:
for %%d in (C D E F G H) do (
	if exist %%d:\ (
		echo.
		echo Drive %%d:
		vol %%d:
		fsutil volume diskfree %%d:
	)
)
echo.
pause
goto submenu

:hostnameinfo
rem Display Hostname
cls
echo.
echo Computer Name: %COMPUTERNAME%
echo.
echo Full Hostname:
hostname
echo.
pause
goto submenu

:networkinfo
rem Display TCP/IP Network Configuration
cls
echo.
ipconfig /all
echo.
pause
goto submenu

:dateinfo
rem Display Current Date
cls
echo.
echo Date: %DATE%
echo.
pause
goto submenu

:timeinfo
rem Display Current Time
cls
echo.
echo Time: %TIME%
echo.
pause
goto submenu