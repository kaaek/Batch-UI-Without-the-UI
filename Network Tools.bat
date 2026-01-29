@echo off
rem Network Tools

:submenu
cls
echo.
echo --- Network Tools Menu ---
echo.
echo 1. Check Network Interfaces
echo 2. Ping Test
echo 3. Traceroute
echo 4. DNS Lookup
echo 5. Active Network Connections
echo 6. View Password and Logon Restrictions
echo 7. Display Server or Workgroup Settings
echo 8. Add or Remove Computer from Domain
echo 9. View User Account Details
echo 10. Stop or Start a Service
echo 11. Display Network Statistics
echo.
set /p choice=Choose an option ^(1-12^) or 'q' to quit: 
if "%choice%"=="1" goto networkinterfaces
if "%choice%"=="2" goto pingtest
if "%choice%"=="3" goto traceroute
if "%choice%"=="4" goto dns
if "%choice%"=="5" goto activeconnections
if "%choice%"=="6" goto accountrestrictions
if "%choice%"=="7" goto serverworkgroup
if "%choice%"=="8" goto domaincomputer
if "%choice%"=="9" goto userdetails
if "%choice%"=="10" goto manageservice
if "%choice%"=="11" goto networkstats
if "%choice%"=="q" exit /b 0
echo Invalid choice. Please try again.
pause
goto submenu

:networkinterfaces
cls
echo.
echo --- Network Interfaces ---
ipconfig /all
echo.
pause
goto submenu

:pingtest
cls
set /p pingtarget=Enter the IP address or hostname to ping ^(leave empty for Google DNS 8.8.8.8^):
if [%pingtarget%]==[] set pingtarget=8.8.8.8
ping %pingtarget%
echo.
pause
goto submenu

:traceroute
cls
set /p tracerttarget=Enter the IP address or hostname to traceroute ^(leave empty for Google DNS 8.8.8.8^):
if [%tracerttarget%]==[] set tracerttarget=8.8.8.8
tracert %tracerttarget%
echo.
pause
goto submenu

:activeconnections
cls
echo.
echo --- Active Network Connections ---
netstat -an
echo.
pause
goto submenu

:dns
cls
set /p dnstarget=Enter the domain name to look up ^(leave empty for example.com^):
if [%dnstarget%]==[] set dnstarget=example.com
nslookup %dnstarget%
echo.
pause
goto submenu

:accountrestrictions
cls
echo.
net accounts
echo.
pause
goto submenu

:serverworkgroup
cls
echo.
echo 1. Workstation Settings
echo 2. Server Settings
echo.
set "configchoice="
set /p configchoice=Choose option ^(1-2^): 
if "%configchoice%"=="1" (
	echo.
	net config workstation
) else if "%configchoice%"=="2" (
	echo.
	net config server
) else (
	echo Invalid choice.
)
echo.
pause
goto submenu

:domaincomputer
cls
echo.
echo --- Add or Remove Computer from Domain ---
echo.
echo 1. Add computer to domain
echo 2. Remove computer from domain
echo.
set "domainaction="
set /p domainaction=Choose option ^(1-2^): 
if "%domainaction%"=="1" (
	set "computername="
	set /p computername=Enter computer name to add: 
	if [%computername%]==[] (
		echo Computer name cannot be empty.
	) else (
		echo.
		echo This requires administrator privileges.
		net computer \\%computername% /add
	)
) else if "%domainaction%"=="2" (
	set "computername="
	set /p computername=Enter computer name to remove: 
	if [%computername%]==[] (
		echo Computer name cannot be empty.
	) else (
		echo.
		echo This requires administrator privileges.
		set /p confirm=Are you sure you want to remove \\%computername%? ^(y/n^): 
		if /i "!confirm!"=="y" (
			net computer \\%computername% /del
		) else (
			echo Operation cancelled.
		)
	)
) else (
	echo Invalid choice.
)
echo.
pause
goto submenu

:userdetails
cls
echo.
echo --- View User Account Details ---
echo.
set "username="
set /p username=Enter username (or press Enter to list all users): 
if [%username%]==[] (
	echo.
	echo Listing all user accounts:
	net user
) else (
	echo.
	echo Details for user: %username%
	net user "%username%"
)
echo.
pause
goto submenu

:manageservice
cls
echo 1. Start a service
echo 2. Stop a service
echo 3. List running services
echo.
set "serviceaction="
set /p serviceaction=Choose option ^(1-3^): 
if "%serviceaction%"=="1" (
	goto servicestart
) else if "%serviceaction%"=="2" (
	goto servicestop
) else if "%serviceaction%"=="3" (
	echo.
	echo Running services:
	net start
) else (
	echo Invalid choice.
)
echo.
pause
goto submenu
:servicestart
set "servicename="
set /p servicename=Enter service name to start: 
if ["%servicename%"]==[] (
    echo Service name cannot be empty.
) else (
    echo.
    echo Starting service: %servicename%
    net start "%servicename%"
)
pause
goto submenu
:servicestop
set "servicename="
set /p servicename=Enter service name to stop: 
if ["%servicename%"]==[] (
    echo Service name cannot be empty.
) else (
    echo.
    echo Stopping service: %servicename%
    net stop "%servicename%"
)
pause
goto submenu

:networkstats
cls
echo.
echo --- Network Statistics ---
echo.
echo 1. Workstation statistics
echo 2. Server statistics
echo.
set "statschoice="
set /p statschoice=Choose option ^(1-2^): 
if "%statschoice%"=="1" (
	echo.
	net statistics workstation
) else if "%statschoice%"=="2" (
	echo.
	net statistics server
) else (
	echo Invalid choice.
)
echo.
pause
goto submenu