@echo off
:menu
cls
echo =======================================
echo Please choose an option (1-5):
echo For first-time users, please follow steps 1-4 in order.
echo 1. Install Python
echo 2. Install SeleniumBasic
echo 3. Install Selenium IDE
echo 4. Download and Run ChromeDriver Updater Script
echo 5. Exit
echo =======================================
set /p choice=Enter your choice (1-5): 

if "%choice%"=="1" goto install_python
if "%choice%"=="2" goto install_selenium_basic
if "%choice%"=="3" goto install_chrome_ide
if "%choice%"=="4" goto download_and_run_chromedriver_script
if "%choice%"=="5" goto exit_script
echo Invalid choice, please try again.
goto menu

:install_python
echo Installing Python...
winget install python.python.3.13 --silent
goto menu

:install_selenium_basic
echo Downloading and installing SeleniumBasic...
set downloadPath=%USERPROFILE%\Downloads\SeleniumBasic-2.0.9.0.exe
bitsadmin /transfer DownloadSeleniumBasic https://github.com/florentbr/SeleniumBasic/releases/download/v2.0.9.0/SeleniumBasic-2.0.9.0.exe %downloadPath%
start %downloadPath%
goto menu

:install_chrome_ide
echo Opening Selenium IDE in Chrome...
if exist "C:\Program Files\Google\Chrome\Application\chrome.exe" (
    start "" "C:\Program Files\Google\Chrome\Application\chrome.exe" "https://chrome.google.com/webstore/detail/selenium-ide/mooikfkahbdckldjjndioackbalphokd"
) else if exist "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" (
    start "" "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" "https://chrome.google.com/webstore/detail/selenium-ide/mooikfkahbdckldjjndioackbalphokd"
) else (
    echo Chrome not found.
)
goto menu

:download_and_run_chromedriver_script
echo Downloading ChromeDriver updater script...
set downloadPath=%USERPROFILE%\Downloads\ChromeDriver_Download.py
bitsadmin /transfer DownloadChromeDriverScript "https://raw.githubusercontent.com/pshacker01/Work/main/ChromeDriver_Download.py" %downloadPath%

:: Check if download was successful
if not exist "%downloadPath%" (
    echo Failed to download ChromeDriver_Download.py. Please check the URL.
    goto menu
)

echo ChromeDriver updater script downloaded to %USERPROFILE%\Downloads.
echo Running the script and closing the window on completion.

:: Open a new Command Prompt, navigate to Downloads, run the Python script, and automatically close the window
start cmd /c "cd /d %USERPROFILE%\Downloads && python ChromeDriver_Download.py"
goto menu

:exit_script
echo Exiting and cleaning up...
exit
