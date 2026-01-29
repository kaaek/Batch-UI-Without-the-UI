@echo off

rem File Operations
:submenu
cls
echo.
echo --- File Operations Menu ---
echo.
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
set /p choice=Choose an option ^(1-16^) or 'q' to quit: 
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
cls
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
cls
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
cls
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
cls
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
cls
echo.
set /p choice=Do you want to link to a file or directory? ^(f/d^): 
if "%choice%"=="f" (
	goto createshortcutf
) else if "%choice%"=="d" (
	goto createshortcutd
) else (
	echo Invalid choice.
	pause
	goto submenu
)
:createshortcutf
set /p target=Input the path ^(relative or absolute^) to the file you want to link: 
set target=%target:"=%
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
pause
goto submenu
:createshortcutd
set /p target=Input the path ^(relative or absolute^) to the directory you want to link: 
set target=%target:"=%
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
pause
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

:fileattributes
echo.
set /p filepath=Enter file or directory path: 
if [%filepath%]==[] (
	echo.
	echo Path cannot be empty.
	echo.
	pause
	goto submenu
)
set filepath=%filepath:"=%
echo.
echo Current attributes:
attrib "%filepath%"
echo.
set /p change=Change attributes? ^(y/n^): 
if /i "%change%"=="y" (
	goto changeattributes
)
pause
echo.
goto submenu
:changeattributes
echo.
echo --- Attribute Options ---
echo 1. Read-only
echo 2. Hidden
echo 3. System
echo 4. Archive
echo.
set /p attrchoice=Which attribute do you want to edit? (1-4): 
if [%attrchoice%]==[] (
	echo Selection cannot be empty.
	pause
	goto submenu
)
echo.
set /p addremove=Do you want to add or remove this attribute? (add/remove): 
if [%addremove%]==[] (
	echo Selection cannot be empty.
	pause
	goto submenu
)
echo.
if "%attrchoice%"=="1" (
	if /i "%addremove%"=="add" (
		attrib +R "%filepath%"
	) else if /i "%addremove%"=="remove" (
		attrib -R "%filepath%"
	) else (
		echo Invalid selection.
		pause
		goto submenu
	)
) else if "%attrchoice%"=="2" (
	if /i "%addremove%"=="add" (
		attrib +H "%filepath%"
	) else if /i "%addremove%"=="remove" (
		attrib -H "%filepath%"
	) else (
		echo Invalid selection.
		pause
		goto submenu
	)
) else if "%attrchoice%"=="3" (
	if /i "%addremove%"=="add" (
		attrib +S "%filepath%"
	) else if /i "%addremove%"=="remove" (
		attrib -S "%filepath%"
	) else (
		echo Invalid selection.
		pause
		goto submenu
	)
) else if "%attrchoice%"=="4" (
	if /i "%addremove%"=="add" (
		attrib +A "%filepath%"
	) else if /i "%addremove%"=="remove" (
		attrib -A "%filepath%"
	) else (
		echo Invalid selection.
		pause
		goto submenu
	)
) else (
	echo Invalid attribute selection.
	pause
	goto submenu
)
if %ERRORLEVEL%==0 (
	echo Attribute changed successfully.
	echo New attributes:
	attrib "%filepath%"
)
pause
goto submenu

:changedir
echo.
echo Current directory:
cd
echo.
set /p newdir=Enter new directory path (or press Enter to keep current): 
if [%newdir%]==[] (
	echo Directory unchanged.
	pause
	goto submenu
)
set newdir=%newdir:"=%
if exist "%newdir%" (
	cd /d "%newdir%"
	echo.
	echo Changed to: %CD%
) else (
	echo Directory does not exist: %newdir%
)
pause
echo.
goto submenu

:deletefiles
echo.
set /p filepath=Enter file path to delete: 
if [%filepath%]==[] (
	echo.
	echo File path cannot be empty.
	echo.
	pause
	goto submenu
)
set filepath=%filepath:"=%
if not exist "%filepath%" (
	echo.
	echo File does not exist: %filepath%
	echo.
	pause
	goto submenu
)
echo.
echo This will permanently delete the file(s).
set /p confirm=Are you sure you want to delete "%filepath%"? ^(y/n^): 
if /i "%confirm%"=="y" (
	del "%filepath%"
	echo.
	if errorlevel 1 (
		echo Failed to delete file.
	) else (
		echo File^(s^) deleted successfully.
	)
) else (
	echo Deletion cancelled.
)
pause
echo.
goto submenu

:createdir
echo.
set /p dirpath=Enter directory path to create: 
if [%dirpath%]==[] (
	echo Directory path cannot be empty.
	pause
	goto submenu
)
set dirpath=%dirpath:"=%
if exist "%dirpath%" (
	echo Directory already exists: %dirpath%
) else (
	mkdir "%dirpath%"
	echo.
	if %ERRORLEVEL%==0 (
		echo Directory created successfully: %dirpath%
	)
)
pause
echo.
goto submenu

:removedir
echo.
set /p dirpath=Enter directory path to remove: 
if [%dirpath%]==[] (
	echo Directory path cannot be empty.
	pause
	goto submenu
)
set dirpath=%dirpath:"=%
if not exist "%dirpath%" (
	echo.
	echo Directory does not exist: %dirpath%
	echo.
	pause
	goto submenu
)
echo.
echo This will remove the directory.
set /p confirm=Are you sure you want to remove "%dirpath%"? (y/n): 
if /i "%confirm%"=="y" (
	echo.
	goto removedirconfirm
) else (
	echo Removal cancelled.
)
pause
goto submenu
:removedirconfirm
set /p recursive=Remove subdirectories and files too? (y/n): 
if /i "%recursive%"=="y" (
	rmdir /s /q "%dirpath%"
) else (
	rmdir /q "%dirpath%"
)
echo.
if %ERRORLEVEL%==0 (
	echo Directory removed successfully.
)
pause
goto submenu

:renamefile
echo.
set /p oldname=Enter current file name: 
if [%oldname%]==[] (
	echo File name cannot be empty.
	pause
	goto submenu
)
set oldname=%oldname:"=%
if not exist "%oldname%" (
	echo File does not exist: %oldname%
	pause
	goto submenu
)
set /p newname=Enter new file name: 
if [%newname%]==[] (
	echo New file name cannot be empty.
	pause
	goto submenu
)
set newname=%newname:"=%
ren "%oldname%" "%newname%"
if %ERRORLEVEL%==0 (
	echo File renamed successfully.
)
pause
echo.
goto submenu

:pushdpopd
echo.
echo Current directory: %CD%
echo.
echo 1. Push (save current and change to new directory)
echo 2. Pop (return to last saved directory)
echo.
set /p pdchoice=Choose option (1-2): 
if "%pdchoice%"=="1" (
	goto push
) else if "%pdchoice%"=="2" (
	popd
	echo.
	echo Returned to: %CD%
) else (
	echo Invalid choice.
)
pause
echo.
goto submenu
:push
set /p newdir=Enter new directory path: 
if [%newdir%]==[] (
	echo.
	echo Directory path cannot be empty.
	echo.
	pause
	goto submenu
)
set newdir=%newdir:"=%
if exist "%newdir%" (
	pushd "%newdir%"
	echo.
	echo Saved previous directory and changed to: %CD%
) else (
	echo Directory does not exist: !newdir!
)
echo.
pause
goto submenu

:replacefile
echo.
set /p sourcefile=Enter source file path: 
if [%sourcefile%]==[] (
	echo Source file cannot be empty.
	pause
	goto submenu
)
set sourcefile=%sourcefile:"=%
if not exist "%sourcefile%" (
	echo.
	echo Source file does not exist: %sourcefile%
	echo.
	pause
	goto submenu
)
set /p destdir=Enter destination directory: 
if [%destdir%]==[] (
	echo.
	echo Destination directory cannot be empty.
	pause
	goto submenu
)
set destdir=%destdir:"=%
if not exist "%destdir%" (
	echo Destination directory does not exist: %destdir%
	pause
	goto submenu
)
echo.
echo This will replace existing files in the destination.
set /p confirm=Continue? (y/n): 
if /i "%confirm%"=="y" (
	replace "%sourcefile%" "%destdir%"
) else (
	echo Replace cancelled.
)
pause
echo.
goto submenu

:dirtree
echo.
set /p dirpath=Enter directory path (or press Enter for current): 
if [%dirpath%]==[] (
	set "dirpath=%CD%"
) else (
	set dirpath=%dirpath:"=%
)
if not exist "%dirpath%" (
	echo Directory does not exist: %dirpath%
	pause
	goto submenu
)
echo.
echo Directory tree for: %dirpath%
echo.
tree "%dirpath%" /F
pause
goto submenu

:xcopyfiles
echo.
set /p source=Enter source path: 
if [%source%]==[] (
	echo.
	echo Source path cannot be empty.
	pause
	goto submenu
)
set source=%source:"=%
if not exist "%source%" (
	echo Source does not exist: %source%
	pause
	goto submenu
)
set /p destination=Enter destination path: 
if [%destination%]==[] (
	echo Destination path cannot be empty.
	pause
	goto submenu
)
set destination=%destination:"=%
echo.
echo Copy options:
echo 1. Copy files only
echo 2. Copy subdirectories (including empty ones)
echo 3. Copy subdirectories (excluding empty ones)
echo.
set /p xcopyopt=Choose option (1-3): 
if "%xcopyopt%"=="1" (
	xcopy "%source%" "%destination%" /Y
) else if "%xcopyopt%"=="2" (
	xcopy "%source%" "%destination%" /E /Y
) else if "%xcopyopt%"=="3" (
	xcopy "%source%" "%destination%" /S /Y
) else (
	echo Invalid option.
	pause
	goto submenu
)
pause
echo.
goto submenu