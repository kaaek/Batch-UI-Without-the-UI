@echo off
rem Data Analysis

:submenu
cls
echo.
echo --- Data Analysis Menu ---
echo.
echo 1. Count Lines in a File
echo 2. Search for Pattern in File
echo 3. Count Word/Pattern Occurrences
echo 4. Display File Statistics
echo 5. Sort File Contents
echo 6. Compare Two Files
echo 7. Display File Contents
echo 8. Display Hello World
echo.
set /p choice=Choose an option (1-8) or 'q' to quit: 
if "%choice%"=="1" goto countlines
if "%choice%"=="2" goto searchpattern
if "%choice%"=="3" goto countoccurrences
if "%choice%"=="4" goto filestats
if "%choice%"=="5" goto sortfile
if "%choice%"=="6" goto comparefiles
if "%choice%"=="7" goto displayfile
if "%choice%"=="8" goto helloworld
if "%choice%"=="q" exit /b 0
echo Invalid choice. Please try again.
pause
goto submenu

:countlines
rem Count Lines in a File
echo.
echo --- Count Lines in a File ---
echo.
set "filepath="
set /p filepath=Enter file path: 
if [%filepath%]==[] (
    echo.
	echo File path cannot be empty.
    echo.
	pause
	goto submenu
)
set filepath=%filepath:"=%
call set filepath=%%filepath%%
if not exist "%filepath%" (
    echo.
	echo File does not exist: %filepath%
    echo.
	pause
	goto submenu
)
echo.
echo Counting lines in: %filepath%
echo.
find /c /v "" "%filepath%"
echo.
pause
goto submenu

:searchpattern
rem Search for Pattern in File
echo.
echo --- Search for Pattern in File ---
echo.
set "filepath="
set "pattern="
set /p filepath=Enter file path: 
if [%filepath%]==[] (
	echo File path cannot be empty.
	pause
	goto submenu
)
set filepath=%filepath:"=%
call set filepath=%%filepath%%
if not exist "%filepath%" (
	echo File does not exist: %filepath%
	pause
	goto submenu
)
set /p pattern=Enter search pattern: 
if [%pattern%]==[] (
	echo Search pattern cannot be empty.
	pause
	goto submenu
)
set pattern=%pattern:"=%
echo.
echo Searching for "%pattern%" in: %filepath%
echo.
findstr /n /i "%pattern%" "%filepath%"
if errorlevel 1 (
	echo No matches found.
) else (
	echo.
)
pause
goto submenu

:countoccurrences
rem Count Word/Pattern Occurrences
echo.
echo --- Count Word/Pattern Occurrences ---
echo.
set "filepath="
set "pattern="
set /p filepath=Enter file path: 
if [%filepath%]==[] (
	echo File path cannot be empty.
	pause
	goto submenu
)
set filepath=%filepath:"=%
call set filepath=%%filepath%%
if not exist "%filepath%" (
	echo File does not exist: %filepath%
	pause
	goto submenu
)
set /p pattern=Enter word/pattern to count: 
if "%pattern%"=="" (
	echo Pattern cannot be empty.
	pause
	goto submenu
)
set pattern=%pattern:"=%
echo.
echo Counting occurrences of "%pattern%" in %filepath%
echo.
findstr /i /c:"%pattern%" "%filepath%" | find /c /v ""
echo.
pause
goto submenu

:filestats
rem Display File Statistics
echo.
echo --- File Statistics ---
echo.
set "filepath="
set /p filepath=Enter file path: 
if [%filepath%]==[] (
	echo File path cannot be empty.
	pause
	goto submenu
)
set filepath=%filepath:"=%
call set filepath=%%filepath%%
if not exist "%filepath%" (
	echo File does not exist: %filepath%
	pause
	goto submenu
)
echo.
echo Statistics for: %filepath%
echo ========================================
echo.
echo File details:
dir "%filepath%" | findstr /v "Directory"
echo.
echo Line count:
find /c /v "" "%filepath%"
echo.
echo Word count (approximate):
for /f %%a in ('type "%filepath%" ^| find /c " "') do set /a words=%%a+1
echo Words: %words%
echo.
pause
goto submenu

:sortfile
rem Sort File Contents
echo.
echo --- Sort File Contents ---
echo.
set "filepath="
set /p filepath=Enter file path to sort: 
if "%filepath%"=="" (
	echo File path cannot be empty.
	pause
	goto submenu
)
set filepath=%filepath:"=%
call set filepath=%%filepath%%
if not exist "%filepath%" (
	echo File does not exist: %filepath%
	pause
	goto submenu
)
echo.
echo This will overwrite the original file.
set /p confirm=Are you sure you want to sort "%filepath%"? (y/n): 
if /i not "%confirm%"=="y" (
	echo Sort cancelled.
	pause
	goto submenu
)
echo.
sort "%filepath%" /o "%filepath%"
if %ERRORLEVEL%==0 (
	echo Successfully sorted and saved to:
	echo %filepath%
) else (
	echo Error occurred while sorting file.
)
echo.
pause
goto submenu

:comparefiles
rem Compare Two Files
echo.
echo --- Compare Two Files ---
echo.
set "file1="
set "file2="
set /p file1=Enter first file path: 
if [%file1%]==[] (
	echo File path cannot be empty.
	pause
	goto submenu
)
set file1=%file1:"=%
call set file1=%%file1%%
if not exist "%file1%" (
	echo File does not exist: %file1%
	pause
	goto submenu
)
set /p file2=Enter second file path: 
if [%file2%]==[] (
	echo File path cannot be empty.
	pause
	goto submenu
)
set file2=%file2:"=%
call set file2=%%file2%%
if not exist "%file2%" (
	echo File does not exist: %file2%
	pause
	goto submenu
)
echo.
echo Comparing files:
echo File 1: %file1%
echo File 2: %file2%
echo ========================================
echo.
fc "%file1%" "%file2%"
echo.
if %ERRORLEVEL%==0 (
	echo Files are identical.
) else (
	echo Files differ.
)
pause
goto submenu

:displayfile
rem Display File Contents
echo.
echo --- Display File Contents ---
echo.
set "filepath="
set /p filepath=Enter file path to display: 
if "%filepath%"=="" (
	echo File path cannot be empty.
	pause
	goto submenu
)
set filepath=%filepath:"=%
call set filepath=%%filepath%%
if not exist "%filepath%" (
	echo File does not exist: %filepath%
	pause
	goto submenu
)
echo.
echo Contents of: %filepath%
echo ========================================
echo.
type "%filepath%"
echo.
echo ========================================
pause
goto submenu

:helloworld
rem Display Hello World
echo.
echo Hello, World!
echo.
pause
goto submenu

