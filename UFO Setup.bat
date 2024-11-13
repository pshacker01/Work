@echo off
:menu
cls
echo =======================================
echo Please choose an option (1-5):
echo For first-time users, please follow steps 1-4 in order.
echo 1. Install Python
echo 2. Install SeleniumBasic
echo 3. Install Selenium IDE
echo 4. Update ChromeDriver
echo 5. Exit
echo =======================================
set /p choice=Enter your choice (1-5): 

if "%choice%"=="1" goto install_python
if "%choice%"=="2" goto install_selenium_basic
if "%choice%"=="3" goto install_chrome_ide
if "%choice%"=="4" goto update_chromedriver
if "%choice%"=="5" goto exit_script
echo Invalid choice, please try again.
pause
goto menu

:install_python
echo Installing Python...
winget install python.python.3.13 --silent

:: Wait a moment to ensure installation completes
timeout /t 5 /nobreak >nul

:: Check if Python is accessible in PATH
where python >nul 2>&1
if errorlevel 1 (
    echo Python not found in PATH. Attempting to add manually.

    :: Default installation path for Python on Windows
    set PYTHON_DIR=%LocalAppData%\Microsoft\WindowsApps\

    if exist "%PYTHON_DIR%python.exe" (
        setx PATH "%PATH%;%PYTHON_DIR%"
        echo Python added to PATH.
    ) else (
        echo Python installation failed or not found in expected location.
        pause
        goto menu
    )
) else (
    echo Python is already in PATH.
)

pause
goto menu

:install_selenium_basic
echo Downloading and installing SeleniumBasic...
set downloadPath=%temp%\SeleniumBasic-2.0.9.0.exe
bitsadmin /transfer DownloadSeleniumBasic https://github.com/florentbr/SeleniumBasic/releases/download/v2.0.9.0/SeleniumBasic-2.0.9.0.exe %downloadPath%
start %downloadPath%
pause
goto menu

:install_chrome_ide
echo Opening Selenium IDE in Chrome...
if exist "C:\Program Files\Google\Chrome\Application\chrome.exe" (
    start "Chrome" "C:\Program Files\Google\Chrome\Application\chrome.exe" "https://chrome.google.com/webstore/detail/selenium-ide/mooikfkahbdckldjjndioackbalphokd"
) else if exist "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" (
    start "Chrome" "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" "https://chrome.google.com/webstore/detail/selenium-ide/mooikfkahbdckldjjndioackbalphokd"
) else (
    echo Chrome not found.
)
pause
goto menu

:update_chromedriver
echo Updating ChromeDriver...
set downloadPath=%temp%\ChromeDriver_Download.py
bitsadmin /transfer DownloadChromeDriverScript "https://raw.githubusercontent.com/pshacker01/Work/main/ChromeDriver_Download.py" %downloadPath%
python %downloadPath%
pause
goto menu

:exit_script
echo Exiting and cleaning up...
pause
exit
