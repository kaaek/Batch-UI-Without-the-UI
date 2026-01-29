@echo off
:mainmenu
rem cls
echo.
echo =======================================
echo        BATCH UI WITHOUT THE UI 
echo =======================================
echo.
echo 1. File Operations
echo 2. View System Information
echo 3. Process Management
echo 4. Network Tools
echo 5. Data Analysis
echo.
set /p choice=Choose an option ^(1-5^) or 'q' to quit: 

if "%choice%"=="1" call "File Operations.bat"
if "%choice%"=="2" call "View System Information.bat"
if "%choice%"=="3" call "Process Management.bat"
if "%choice%"=="4" call "Network Tools.bat"
if "%choice%"=="5" call "Data Analysis.bat"
if "%choice%"=="q" exit /b 0
echo Invalid choice. Please try again.
pause
goto mainmenu