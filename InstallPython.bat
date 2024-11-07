@echo off

:: Check if Python is installed
python --version >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
    echo Python is already installed.
    pause
    exit /b
)

:: Check if winget is available
winget --version >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo winget is not available on this system. Please install it or use an alternative method.
    pause
    exit /b
)

:: Install Python using winget
echo Installing Python with winget...
winget install --id Python.Python.3 -e --source winget

:: Verify the Python installation
python --version >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo Python installation failed. Please try again.
    pause
    exit /b
)

echo Python installed successfully.
pause
