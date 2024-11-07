@echo off
:: Set URL for the Python script on GitHub
set "script_url=https://raw.githubusercontent.com/pshacker01/Work/main/ChromeDriver_Download.py"
set "script_path=%TEMP%\ChromeDriver_Download.py"

:: Download the Python script
echo Downloading Python script from GitHub...
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%script_url%', '%script_path%')"

:: Check if the script downloaded successfully
IF NOT EXIST %script_path% (
    echo Failed to download Python script. Please check the URL or network connection.
    pause
    exit /b
)

:: Run the Python script
echo Running Python script...
python %script_path%

:: Clean up
del %script_path%

echo Python script executed successfully.
pause
