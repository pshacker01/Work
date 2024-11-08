import subprocess
import sys

def install_package(package):
    subprocess.check_call([sys.executable, "-m", "pip", "install", package])

# Install Selenium
install_package("selenium")
print("Selenium installed successfully.")
