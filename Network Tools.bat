@echo off
rem Network Tools

:submenu
echo.
echo --- Network Tools Menu ---
echo 1. Check Network Interfaces
echo 2. Ping Test
echo 3. Traceroute
echo 4. DNS Lookup
set /p choice=Choose an option (1-5) or 'q' to quit: 
if "%choice%"=="1" goto networkinterfaces
if "%choice%"=="2" goto pingtest
if "%choice%"=="3" goto traceroute
if "%choice%"=="4" goto dns
if "%choice%"=="5" goto activeconnections
if "%choice%"=="q" goto mainmenu
else (
	echo Invalid choice. Please try again.
	goto submenu
)

:networkinterfaces
echo --- Network Interfaces ---
ipconfig /all
echo.
goto submenu

:pingtest
echo --- Ping Test ---
set /p pingtarget=Enter the IP address or hostname to ping (leave empty for Google DNS 8.8.8.8):
if [%pingtarget%]==[] set pingtarget=8.8.8.8
ping %pingtarget%
echo.
goto submenu

:traceroute
echo --- Traceroute ---
set /p tracerttarget=Enter the IP address or hostname to traceroute (leave empty for Google DNS 8.8.8.8):
if [%tracerttarget%]==[] set tracerttarget=8.8.8.8
tracert %tracerttarget%
echo.
goto submenu

:activeconnections
echo --- Active Network Connections ---
netstat -an
echo.
goto submenu

:dns
echo --- DNS Lookup ---
set /p dnstarget=Enter the domain name to look up (leave empty for example.com):
if [%dnstarget%]==[] set dnstarget=example.com
nslookup %dnstarget%
echo.
goto submenu

:mainmenu