from colorama import Fore,Back,Style
import platform,os

OsName = platform.uname()[0]

def banner():
    if OsName == "Windows":
      os.system("cls")
    else:
      os.system("clear")
    print(fr"""
    {Fore.LIGHTWHITE_EX}   (       )            )            )            
    {Fore.LIGHTWHITE_EX}   )\   ( /(         ( /( (       ( /(    (   (   
    {Fore.LIGHTWHITE_EX} (((_)  )\()) `  )   )\()))\  (   )\())  ))\  )(  
    {Fore.LIGHTWHITE_EX} )\___ ((_)\  /(/(  ((_)\((_) )\ ((_)\  /((_)(()\ 
    {Fore.LIGHTCYAN_EX}((/ __|| |(_)((_)_\ | |(_)(_)((_)| |(_)(_))   ((_)
    {Fore.LIGHTCYAN_EX} | (__ | ' \ | '_ \)| ' \ | |(_-<| ' \ / -_) | '_|
    {Fore.LIGHTCYAN_EX}  \___||_||_|| .__/ |_||_||_|/__/|_||_|\___| |_|  
    {Fore.LIGHTCYAN_EX}             |_|                                  {Fore.LIGHTRED_EX}Version: {Fore.LIGHTYELLOW_EX}2
    {Fore.RESET}
    """)
# banner()