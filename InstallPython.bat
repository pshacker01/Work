@echo off
setlocal

:: Check if Python is installed
python --version >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
    echo Python is already installed.
    pause
    exit /b
)

:: Set download URL and paths
set "python_url=https://www.python.org/ftp/python/3.11.4/python-3.11.4-amd64.exe"
set "installer_path=%TEMP%\python_installer.exe"
set "python_install_dir=%USERPROFILE%\AppData\Local\Programs\Python311"

:: Download Python installer
echo Downloading Python installer...
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%python_url%', '%installer_path%')"

:: Verify download success
IF NOT EXIST "%installer_path%" (
    echo Failed to download the Python installer. Access may be denied or URL may be incorrect.
    pause
    exit /b
)

:: Install Python for the current user only
echo Installing Python...
"%installer_path%" /quiet InstallAllUsers=0 TargetDir="%python_install_dir%" PrependPath=1

:: Check if Python installed successfully
"%python_install_dir%\python.exe" --version >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo Python installation failed. Please check installation permissions and try again.
    pause
    exit /b
)

:: Add Python to PATH for this session only
set PATH=%python_install_dir%;%PATH%

:: Confirm installation and show Python version
python --version

:: Clean up the installer file
del "%installer_path%"

echo Python has been installed successfully.
pause
