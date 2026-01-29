# BATCH UI WITHOUT THE UI UTILITY

A command-line menu system for Windows that provides easy access to common system administration, file management, network diagnostics, and data analysis tasks using native Windows CMD batch scripting.

## Description

This project is a multi-menu batch script system designed to access Windows system administration tasks through the terminal. It requires proper input validation, quote handling, environment variable expansion, and menu navigation.

## Features

### 1. File Operations (16 operations)
- List files in a directory
- Create files with custom sizes
- Copy and move files
- Create symbolic links (shortcuts)
- Display and modify file ACLs (Access Control Lists)
- View and change file attributes (Read-only, Hidden, System, Archive)
- Navigate and change directories
- Delete files with confirmation
- Create and remove directories
- Rename files
- Directory stack management (pushd/popd)
- Replace files in directories
- Display directory trees
- Advanced file copying with xcopy

### 2. View System Information (11 options)
- System summary
- Detailed system information
- OS, BIOS, and time zone details
- Processor information
- Memory information
- Disk drive information
- Hostname
- Network interface configuration
- Current date and time
- Comprehensive system overview

### 3. Process Management (4 operations)
- View running processes
- View detailed process information with filtering
- Terminate processes (by name or PID)
- Start new processes

### 4. Network Tools (11 operations)
- Check network interfaces (ipconfig)
- Ping test with custom targets
- Traceroute diagnostics
- DNS lookups
- View active network connections
- View password and logon restrictions
- Display workstation/server settings
- Add/remove computers from domain
- View user account details
- Start/stop Windows services
- Display network statistics

### 5. Data Analysis (8 operations)
- Count lines in files
- Search for patterns in files
- Count word/pattern occurrences
- Display file statistics
- Sort file contents (with confirmation)
- Compare two files
- Display file contents
- Hello World demonstration

## Requirements

Just native Windows CMD

## Installation

1. Download by one of two ways:
    - **Better way:** using git, run `git clone https://github.com/kaaek/Batch-UI-Without-the-UI`. A folder `Batch-UI-Without-the-UI` should appear in your working directory. Navigate to it.
    - **Alternatively:** copy all `.bat` files to a single directory. Navigate to it.
2. Ensure all files are in the same folder:
   - `Main Menu.bat`
   - `File Operations.bat`
   - `View System Information.bat`
   - `Process Management.bat`
   - `Network Tools.bat`
   - `Data Analysis.bat`

## Usage

### Basic Usage
1. Double-click `Main Menu.bat` or run it from a command prompt
2. Enter the number corresponding to your desired menu
3. Follow the on-screen prompts
4. Type 'q' when prompted to return to the previous menu or exit

### Administrator Mode
For operations requiring elevated privileges (domain management, service control, etc.):
1. Right-click `Main Menu.bat`
2. Select "Run as administrator"

### Input Guidelines
- **File paths**: You can use tab completion to auto-complete paths (quotes are handled automatically)
- **Empty inputs**: Press Enter on optional prompts to use default values
- **Confirmation prompts**: Type 'y' or 'n' (case-insensitive)

## File Structure

```
Windows-CMD-Batch-Menu/
│
├── Main Menu.bat                    # Main orchestrator menu
├── File Operations.bat              # File and directory operations
├── View System Information.bat      # System information display
├── Process Management.bat           # Process control operations
├── Network Tools.bat                # Network diagnostics and configuration
├── Data Analysis.bat                # File analysis and manipulation
└── README.md                        # This file
```

## Technical Features

### Scripting Techniques
- **Quote handling**: Automatic quote stripping for user inputs
- **Empty input validation**: Robust checking using `[%var%]==[]` pattern
- **Variable clearing**: Prevention of variable persistence across iterations
- **Escaped parentheses**: Proper escaping in prompts within conditional blocks

### Error Handling
- Input validation for user prompts
- File existence checks before operations
- Confirmation prompts for destructive operations
- Graceful error messages with pause for user acknowledgment

## Known issues
- Handling environment variables in the input is clunky.
- Submenus do not return correctly to the main menu when the user passes the input `q`

## Examples

### Creating a File
```
Choose option: 2
Input filename: C:\Users\YourName\Desktop\test.txt
Input file size in bytes: 1000
```

### Changing File Attributes
```
Choose option: 7
Enter file or directory path: C:\Users\YourName\Desktop\test.txt
Change attributes? (y/n): y
Which attribute do you want to edit? (1-4): 2
Do you want to add or remove this attribute? (add/remove): add
```

### Network Ping Test
```
Choose option: 2
Enter IP address or hostname (leave empty for 8.8.8.8): google.com
```

## License

This project is provided as-is for educational purposes.

## Author

Khalil El Kaaki

---

**Note**: Always back up important data before performing file operations or system changes.
