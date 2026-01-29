@echo off

rem File Operations (TO-DO: add labels for each functionality. Need an outer label for this submenu.)
:submenu
echo File Operations Menu:
echo 1. List Files in a directory
echo 2. Create a File
echo 3. Copy a File
echo 4. Move a File
echo 5. Create a shortcut
echo 6. Display a File's ACL (Access control list, to view permissions)
set /p choice=Choose an option (1-6) or 'q' to quit: 
if "%choice%"=="1" goto listfiles
if "%choice%"=="2" goto createfile
if "%choice%"=="3" goto copyfile
if "%choice%"=="4" goto movefile
if "%choice%"=="5" goto createshortcut
if "%choice%"=="6" goto displayacl
if "%choice%"=="q" goto mainmenu
else (
	echo Invalid choice. Please try again.
	goto submenu
)

:listfiles
rem List Files in a directory
set /p directory=Specify a directory: 
if "%directory%"=="" (
	echo Directory cannot be empty.
	goto submenu
)
set directory=%directory:"=%
dir "%directory%"
echo Exit code: %ERRORLEVEL%
goto submenu

:createfile
rem Create a File
set /p filename=Input filename (with path if needed, example: %USERPROFILE%\Desktop\newfile.txt or just newfile.txt): 
set /p bytesize=Input file size in bytes (leave empty for 1000 bytes): 
if "%filename%"=="" (
	echo Filename cannot be empty.
	goto submenu
)
set filename=%filename:"=%
if "%bytesize%"=="" (
	fsutil file createNew "%filename%" 1000 
) else (
	set bytesize=%bytesize:"=%
	fsutil file createNew "%filename%" %bytesize%
)
echo Exit code: %ERRORLEVEL%
goto submenu

:copyfile
rem Copy a File
set /p source=Input source file: 
set /p destination=Input destination directory: 
if "%source%"=="" (
	echo Source file cannot be empty.
	goto submenu
)
if "%destination%"=="" (
	echo Destination directory cannot be empty.
	goto submenu
)
set source=%source:"=%
set destination=%destination:"=%
call copy "%source%" "%destination%"
echo Exit code: %ERRORLEVEL%
goto submenu
:movefile
rem Move a File
set /p source=Input source file: 
set /p destination=Input destination directory: 
if "%source%"=="" (
	echo Source file cannot be empty.
	goto submenu
)
if "%destination%"=="" (
	echo Destination directory cannot be empty.
	goto submenu
)
set source=%source:"=%
set destination=%destination:"=%
call move "%source%" "%destination%"
echo Exit code: %ERRORLEVEL%
goto submenu

:createshortcut
rem Create a shortcut
set /p choice=Do you want to link to a file or directory? (f/d):
if "%choice%"=="f" (
	set /p target=Input the path (relative or absolute) to the file you want to link:
	set target=%target:"=%
	goto createshortcutf
) else (
	set /p target=Input the path (relative or absolute) to the directory you want to link:
	set target=%target:"=%
	goto createshortcutd
)
:createshortcutf
set /p name=Input new shortcut name:
if "%target%"=="" (
	echo Target cannot be empty.
	goto submenu
)
if "%name%"=="" (
	echo Shortcut name cannot be empty.
	goto submenu
)
set name=%name:"=%
mklink "%name%" "%target%"
echo Exit code: %ERRORLEVEL%
echo You might want to move the generated shortcut somewhere else.
goto submenu
:createshortcutd
set /p name=Input new shortcut name:
if "%target%"=="" (
	echo Target cannot be empty.
	goto submenu
)
if "%name%"=="" (
	echo Shortcut name cannot be empty.
	goto submenu
)
set name=%name:"=%
mklink /D "%name%" "%target%"
echo Exit code: %ERRORLEVEL%
echo You might want to move the generated shortcut somewhere else.
goto submenu

:displayacl
rem Display a File's ACL
set /p in=Specify a file or directory: 
if "%in%"=="" (
	echo File or directory cannot be empty.
	goto submenu
)
set in=%in:"=%
icacls "%in%"
echo Exit code: %ERRORLEVEL%
goto submenu