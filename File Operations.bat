@echo off
rem File Operations (TO-DO: add labels for each functionality. Need an outer label for this submenu.)
rem List Files in a directory
set /p directory=Specify a directory: 
dir %directory%
rem Create a File (TO-DO: check if the filename is empty.)
set /p filename=Input filename: 
set /p bytesize=Input file size in bytes (leave empty for 1000 bytes): 
if [%bytesize%]==[] (
	fsutil file createNew %filename% 1000 
) else (
	fsutil file createNew %filename% %bytesize%
)
rem Copy a File (TO-DO: might need to check source and destination are formatted correctly)
set /p source=Input source file: 
set /p destination=Input destination directory: 
copy %source% %destination%
rem Move a File (TO-DO: might need to check source and destination are formatted correctly)
set /p source=Input source file: 
set /p destination=Input destination directory: 
move %source% %destination%
rem Create a shortcut (TO-DO: add an option to choose between a link to file and a link to directory, becomes mklink /D <link target>)
set /p target=Input target file:
mklink %target%
echo You might want to move the generated shortcut somewhere else.
rem Display a File's ACL (TO-Do: might need to check in is formatted correctly)
set /p in=Specify a file or directory: 
icacls %in%