from modules import check
check.dependency()
# check.check_update()
from colorama import Back,Fore,Style
from modules import banner, phpServer, kill



PORT = 8080

while True:
    banner.banner()
    phpServer.run_php_server(PORT)
    try:
        input(" "+Fore.WHITE+Back.RED+"If You Want Exit And Turn Off localhost / press enter or CTRL+C "+Style.RESET_ALL)
        kill.kill_php_proc()
        exit()
    
    except:
        kill.kill_php_proc()
        exit()