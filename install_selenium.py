import subprocess
import sys

def install_package(package):
    try:
        print(f"Attempting to install {package}...")
        subprocess.check_call([sys.executable, "-m", "pip", "install", package])
        print(f"{package} installed successfully.")
    except subprocess.CalledProcessError as e:
        print(f"Failed to install {package}. Error: {e}")

# Install Selenium
install_package("selenium")
