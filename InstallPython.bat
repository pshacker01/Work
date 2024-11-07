@echo off
:: Check if Python is installed
python --version >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
    echo Python is already installed.
    pause
    exit /b
)

:: If Python is not installed, download and install it
echo Python is not installed. Downloading and installing Python...

:: Set the download URL and install directory
set "python_url=https://www.python.org/ftp/python/3.11.4/python-3.11.4-amd64.exe"
set "installer_path=%TEMP%\python_installer.exe"
set "python_install_dir=%USERPROFILE%\AppData\Local\Programs\Python311"

:: Download Python installer
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%python_url%', '%installer_path%')"

:: Install Python for the current user only
%installer_path% /quiet TargetDir="%python_install_dir%" PrependPath=0

:: Add Python to PATH for this session only
set PATH=%python_install_dir%;%PATH%

:: Confirm installation and show Python version
python --version

:: Clean up the installer file
del %installer_path%

echo Python has been installed successfully.
pause
