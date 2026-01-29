@echo off

rem File Operations
:submenu
cls
echo.
echo --- File Operations Menu ---
echo 1. List Files in a directory
echo 2. Create a File
echo 3. Copy a File
echo 4. Move a File
echo 5. Create a shortcut
echo 6. Display a File's ACL
echo 7. Display or Change File Attributes
echo 8. Display or Change Current Directory
echo 9. Delete Files
echo 10. Create a Directory
echo 11. Remove a Directory
echo 12. Rename a File
echo 13. Save and Change Directory (pushd/popd)
echo 14. Replace a File
echo 15. Display Directory Tree
echo 16. Copy Files and Directory Trees (xcopy)
echo.
set /p choice=Choose an option (1-16) or 'q' to quit: 
if "%choice%"=="1" goto listfiles
if "%choice%"=="2" goto createfile
if "%choice%"=="3" goto copyfile
if "%choice%"=="4" goto movefile
if "%choice%"=="5" goto createshortcut
if "%choice%"=="6" goto displayacl
if "%choice%"=="7" goto fileattributes
if "%choice%"=="8" goto changedir
if "%choice%"=="9" goto deletefiles
if "%choice%"=="10" goto createdir
if "%choice%"=="11" goto removedir
if "%choice%"=="12" goto renamefile
if "%choice%"=="13" goto pushdpopd
if "%choice%"=="14" goto replacefile
if "%choice%"=="15" goto dirtree
if "%choice%"=="16" goto xcopyfiles
if "%choice%"=="q" exit /b 0
echo Invalid choice. Please try again.
pause
goto submenu

:listfiles
echo.
set /p directory=Specify a directory: 
if [%directory%]==[] (
	echo.
	echo Directory cannot be empty.
	echo.
	goto submenu
)
set directory=%directory:"=%
dir "%directory%"
echo.
pause
echo.
goto submenu

:createfile
echo.
set /p filename=Input filename (with path if needed, example: %USERPROFILE%\Desktop\newfile.txt or just newfile.txt): 
set /p bytesize=Input file size in bytes (leave empty for 1000 bytes): 
if [%filename%]==[] (
	echo.
	echo Filename cannot be empty.
	echo.
	goto submenu
)
set filename=%filename:"=%
if [%bytesize%]==[] (
	fsutil file createNew "%filename%" 1000 
) else (
	set bytesize=%bytesize:"=%
	fsutil file createNew "%filename%" %bytesize%
)
echo.
pause
echo.
goto submenu

:copyfile
echo.
set /p source=Input source file: 
set /p destination=Input destination directory: 
if [%source%]==[] (
	echo.
	echo Source file cannot be empty.
	echo.
	goto submenu
)
if [%destination%]==[] (
	echo.
	echo Destination directory cannot be empty.
	echo.
	goto submenu
)
set source=%source:"=%
set destination=%destination:"=%
call copy "%source%" "%destination%"
echo.
pause
echo.
goto submenu

:movefile
echo.
set /p source=Input source file: 
set /p destination=Input destination directory: 
if [%source%]==[] (
	echo.
	echo Source file cannot be empty.
	echo.
	goto submenu
)
if [%destination%]==[] (
	echo.
	echo Destination directory cannot be empty.
	echo.
	goto submenu
)
set source=%source:"=%
set destination=%destination:"=%
call move "%source%" "%destination%"
echo.
pause
echo.
goto submenu

:createshortcut
echo.
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
if [%target%]==[] (
	echo.
	echo Target cannot be empty.
	echo.
	goto submenu
)
if [%name%]==[] (
	echo.
	echo Shortcut name cannot be empty.
	echo.
	goto submenu
)
set name=%name:"=%
mklink "%name%" "%target%"
echo.
echo You might want to move the generated shortcut somewhere else.
echo.
goto submenu
:createshortcutd
set /p name=Input new shortcut name:
if [%target%]==[] (
	echo.
	echo Target cannot be empty.
	echo.
	goto submenu
)
if [%name%]==[] (
	echo.
	echo Shortcut name cannot be empty.
	echo.
	goto submenu
)
set name=%name:"=%
mklink /D "%name%" "%target%"
echo.
echo You might want to move the generated shortcut somewhere else.
echo.
pause
echo.
goto submenu

:displayacl
echo.
echo --- Display a File's ACL (Access control list, to view permissions) ---
set /p in=Specify a file or directory: 
if [%in%]==[] (
	echo File or directory cannot be empty.
	goto submenu
)
set in=%in:"=%
icacls "%in%"
echo.
pause
echo.
goto submenu