@echo off
:menu
cls
echo =======================================
echo Please choose an option (1-5):
echo For first-time users, please follow steps 1-4 in order.
echo 1. Install Python
echo 2. Install SeleniumBasic
echo 3. Install Selenium IDE
echo 4. Download and Run ChromeDriver Updater
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

:: Try locating Python dynamically
for /f "delims=" %%p in ('where python 2^>nul') do set "PYTHON_PATH=%%p"

:: If Python is still not found, use provided fallback path
if "%PYTHON_PATH%"=="" (
    if exist "C:\Program Files\Python312\python.exe" (
        set "PYTHON_PATH=C:\Program Files\Python312\python.exe"
        echo Python found at %PYTHON_PATH%.
    ) else (
        echo Python not found in PATH or standard locations. Please ensure Python is installed correctly.
        pause
        goto menu
    )
)

:: Add Python to PATH temporarily for the session
set "PATH=%PATH%;%~dpPYTHON_PATH%"

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
echo Downloading ChromeDriver updater script...
set downloadPath=%temp%\ChromeDriver_Download.py
bitsadmin /transfer DownloadChromeDriverScript "https://raw.githubusercontent.com/pshacker01/Work/main/ChromeDriver_Download.py" %downloadPath%

:: Check if download was successful
if not exist "%downloadPath%" (
    echo Failed to download ChromeDriver_Download.py. Please check the URL.
    pause
    goto menu
)

echo Running ChromeDriver updater script...
"%PYTHON_PATH%" "%downloadPath%"
pause
goto menu

:exit_script
echo Exiting and cleaning up...
pause
exit
