from colorama import Fore
from modules.config import PROJECT_NAME, VERSION_INFO, ASCII_TEXT

def print_success(message: str): print(f'{Fore.LIGHTGREEN_EX}[ {Fore.LIGHTWHITE_EX}+ {Fore.LIGHTGREEN_EX}]{Fore.LIGHTGREEN_EX} {message} {Fore.RESET}')
def print_failed(message: str): print(f'{Fore.LIGHTRED_EX}[ {Fore.LIGHTWHITE_EX}- {Fore.LIGHTRED_EX}]{Fore.LIGHTRED_EX} {message} {Fore.RESET}')
def print_info(message: str): print(f'{Fore.LIGHTCYAN_EX}[ {Fore.LIGHTWHITE_EX}* {Fore.LIGHTCYAN_EX}]{Fore.WHITE} {message} {Fore.RESET}')
def print_warning(message: str): print(f'{Fore.YELLOW}[ {Fore.LIGHTWHITE_EX}! {Fore.YELLOW}]{Fore.YELLOW} {message} {Fore.RESET}')
def print_input(message: str): print(f'{Fore.LIGHTMAGENTA_EX}[ {Fore.LIGHTWHITE_EX}> {Fore.LIGHTMAGENTA_EX}]{Fore.WHITE} {message} {Fore.RESET}', end='')

def print_banner():
    print(ASCII_TEXT.format(
        **{
            "ART_COLOR" : Fore.LIGHTMAGENTA_EX,
            "PROJECT_COLOR": Fore.LIGHTCYAN_EX,
            "PROJECT_NAME": PROJECT_NAME,
            "VERSION_COLOR": Fore.LIGHTGREEN_EX,
            "VERSION_INFO": VERSION_INFO,
            "ARROW_COLOR": Fore.LIGHTWHITE_EX,
            "TEXT_COLOR": Fore.LIGHTMAGENTA_EX,
            "BRACKET_COLOR": Fore.LIGHTBLUE_EX,
            "WBRACKET_COLOR": Fore.LIGHTWHITE_EX,
            "OWNER_COLOR": Fore.LIGHTRED_EX
        }
    ))

def print_serverinfo(data: dict):
    print_success(
        f"{Fore.LIGHTWHITE_EX}Web Panel URL:"
        f"{Fore.LIGHTBLUE_EX} http://{data.get('host')}:{data.get('port')}"
    )
    print_info(
        f"{Fore.WHITE}You can use port forwarding softwares/services like ("
        f"{Fore.LIGHTWHITE_EX}Ngrok, CloudFlare Tunnel or LocalXpose{Fore.WHITE}) "
        f"on this port: {Fore.YELLOW}{data.get('port')}"
    )
