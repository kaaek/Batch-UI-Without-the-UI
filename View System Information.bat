@echo off
rem View System Information

echo Computer Name: %COMPUTERNAME%
echo User Name: %USERNAME%
echo Login Server: %LOGONSERVER%
echo User Domain: %USERDOMAIN%
echo Processor: %PROCESSOR_IDENTIFIER%
echo Number of Processors: %NUMBER_OF_PROCESSORS%
echo Architecture: %PROCESSOR_ARCHITECTURE%
echo OS: %OS%
echo.

echo --- Windows Version ---
ver
echo.

echo --- Current User ---
whoami
echo.

echo --- User Groups ---
whoami /groups
echo.

echo --- Available Drives ---
fsutil fsinfo drives
echo.

echo --- Installed Drivers ---
driverquery
echo.

echo --- Detailed System Information ---
systeminfo