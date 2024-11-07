import os
import shutil
import subprocess
import sys
import time

# Step 0: Auto-install required packages if they aren't installed
def install_package(package):
    subprocess.check_call([sys.executable, "-m", "pip", "install", package])

try:
    from webdriver_manager.chrome import ChromeDriverManager
except ImportError:
    print("Installing webdriver_manager...")
    install_package("webdriver-manager")
    from webdriver_manager.chrome import ChromeDriverManager

try:
    from tqdm import tqdm
except ImportError:
    print("Installing tqdm for progress bar...")
    install_package("tqdm")
    from tqdm import tqdm

# Display a progress bar to simulate loading
print("Preparing to download the latest ChromeDriver...")
for _ in tqdm(range(100), desc="Downloading ChromeDriver", ncols=75):
    time.sleep(0.03)  # Slows down for effect; adjust as needed

# Step 1: Download the latest ChromeDriver
chrome_driver_path = ChromeDriverManager().install()

# Step 2: Define the dynamic destination path
user_home = os.path.expanduser("~")
destination_path = os.path.join(user_home, 'AppData', 'Local', 'SeleniumBasic', 'chromedriver.exe')

# Step 3: Check if the file exists and delete it if it does
if os.path.exists(destination_path):
    os.remove(destination_path)  # Delete the existing file

# Display a progress bar for moving the file
print("Moving ChromeDriver to the target directory...")
for _ in tqdm(range(100), desc="Moving File", ncols=75):
    time.sleep(0.02)  # Simulated delay for effect

# Step 4: Move the downloaded file
shutil.move(chrome_driver_path, destination_path)

print(f"ChromeDriver has been moved to {destination_path}")
