import subprocess
import requests
import json
import platform

def dependency():
    check_php = subprocess.getoutput("php -v")
    if "not found" in check_php:
        exit("please install php \n command > sudo apt install php and on windows download lastest php and try again")

    try:
        from colorama import Fore,Style
        import requests,psutil

    except:
        exit("please install library \n command > python3 -m pip install -r requirements.txt")



def check_update():
    http = requests.get("https://raw.githubusercontent.com/Ch4120N/Chphisher-v2/main/chphisher-www/Settings.json").text
    
    http_json = json.loads(http)

    with open("chphisher-www/Settings.json", "r") as jsonFile:

        data = json.load(jsonFile)
        if data['version'] < http_json['version']:
            exit("Please Update Tool")


def system():
    if platform.system().lower() == "windows":
        return "windows"
    else:
        return "linux"