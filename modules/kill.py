import subprocess
from modules.check import system

def kill_php_proc():
    try:
        # for i in pid:
        if system() == "windows":
            subprocess.getoutput(f"taskkill /f /im php.exe")
        else:
            subprocess.getoutput("killall php")

    except:
        pass
