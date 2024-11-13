@echo off
:menu
cls
echo =======================================
echo Please choose an option (1-4):
echo For first time users, please follow steps 1-4 in order.
echo 1. Install Python
echo 2. Install SeleniumBasic
echo 3. Install Selenium IDE
echo 4. Update ChromeDriver
echo =======================================
set /p choice=Enter your choice (1-4): 

if "%choice%"=="1" goto install_python
if "%choice%"=="2" goto install_selenium_basic
if "%choice%"=="3" goto open_chrome_ide
if "%choice%"=="4" goto update_chromedriver
echo Invalid choice, please try again.
pause
goto menu

:install_python
echo Installing Python and pip...
winget install python.python.3.13 --silent
pause
goto menu

:install_selenium_basic
echo Downloading and running SeleniumBasic installer...
set downloadPath=%temp%\SeleniumBasic-2.0.9.0.exe
bitsadmin /transfer "DownloadSeleniumBasic" https://github.com/florentbr/SeleniumBasic/releases/download/v2.0.9.0/SeleniumBasic-2.0.9.0.exe %downloadPath%
echo Running the SeleniumBasic installer...
start "" %downloadPath%
pause
goto menu

:open_chrome_ide
echo Opening Chrome Extension Page for Selenium IDE in Chrome...

:: Try common paths for Chrome
if exist "C:\Program Files\Google\Chrome\Application\chrome.exe" (
    start "" "C:\Program Files\Google\Chrome\Application\chrome.exe" "https://chrome.google.com/webstore/detail/selenium-ide/mooikfkahbdckldjjndioackbalphokd"
) else if exist "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" (
    start "" "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" "https://chrome.google.com/webstore/detail/selenium-ide/mooikfkahbdckldjjndioackbalphokd"
) else (
    echo Google Chrome not found. Please check your installation.
)

pause
goto menu

:update_chromedriver
echo Downloading and running ChromeDriver update script...
set downloadPath=%temp%\ChromeDriver_Download.py
bitsadmin /transfer "DownloadChromeDriverScript" "https://raw.githubusercontent.com/pshacker01/Work/main/ChromeDriver_Download.py" %downloadPath%
echo Running ChromeDriver update script...
python %downloadPath%
pause
goto menu
