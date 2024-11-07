@echo off

REM Check if Python is installed
python --version >nul 2>&1
IF ERRORLEVEL 1 (
    echo Python is not installed. Installing Python...
    
    REM Download Python installer
    powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://www.python.org/ftp/python/3.11.4/python-3.11.4-amd64.exe', 'python_installer.exe')"
    
    REM Install Python silently
    start /wait python_installer.exe /quiet InstallAllUsers=1 PrependPath=1
    
    REM Clean up installer file
    del python_installer.exe
) ELSE (
    echo Python is already installed.
)

REM Confirm Python installation
python --version >nul 2>&1
IF ERRORLEVEL 1 (
    echo Python installation failed. Please install Python manually.
    pause
    exit /b
)

REM Download the Python script from GitHub
echo Downloading ChromeDriver_Download.py...
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/pshacker01/Work/main/ChromeDriver_Download.py', 'ChromeDriver_Download.py')"

REM Check if the file was downloaded successfully
IF EXIST ChromeDriver_Download.py (
    echo File downloaded successfully.
    echo Running Python script...
    python ChromeDriver_Download.py
) ELSE (
    echo Failed to download file. Please check the URL or network connection.
)

REM Keep the command window open to view output
pause
