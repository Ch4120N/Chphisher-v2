import os


PROJECT_NAME = "ChPhisher"
VERSION_INFO = 2.5
DEFAULT_PORT = 3000
IS_WINDOWS = True if os.name == 'nt' else False
SERVER_CONFIG_FILE = os.path.realpath('./data/server_config.json')
ASCII_TEXT = (
    "{ART_COLOR}    ___  _   _  ____  _   _  ____  ___  _   _  ____  ____  \n"
    "{ART_COLOR}   / __)( )_( )(  _ \\( )_( )(_  _)/ __)( )_( )( ___)(  _ \\ \n"
    "{ART_COLOR}  ( (__  ) _ (  )___/ ) _ (  _)(_ \\__ \\ ) _ (  )__)  )   / \n"
    "{ART_COLOR}   \\___)(_) (_)(__)  (_) (_)(____)(___/(_) (_)(____)(_)\\_) \n\n"
    "{ART_COLOR}                       {WBRACKET_COLOR}[{PROJECT_COLOR}{PROJECT_NAME} {VERSION_COLOR}v{VERSION_INFO}{WBRACKET_COLOR}]\n"
    "{ART_COLOR}                 {ARROW_COLOR}---> {TEXT_COLOR}Owned By {BRACKET_COLOR}[{OWNER_COLOR}Ch4120N{BRACKET_COLOR}]{ARROW_COLOR} <---\n\n"
    )
