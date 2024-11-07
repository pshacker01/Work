@echo off

:: Set the download URL for the Python installer
set "python_url=https://www.python.org/ftp/python/3.11.4/python-3.11.4-amd64.exe"
set "installer_path=%TEMP%\python_installer.exe"
set "python_install_dir=%USERPROFILE%\AppData\Local\Programs\Python311"

:: Download Python installer
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%python_url%', '%installer_path%')"

:: Install Python for the current user only, no admin permissions needed
%installer_path% /quiet TargetDir="%python_install_dir%" PrependPath=0

:: Add Python to PATH for this session only
set PATH=%python_install_dir%;%PATH%

:: Confirm installation and show version
python --version

:: Clean up the installer
del %installer_path%
