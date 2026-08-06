#!/usr/bin/env bash
# ───────────────────────────────────────────────────────────────
# ChPhisher Dependencies Installer – Enhanced Edition (no ngrok)
# Version: 2.1
# Author: Ch4120N (improved by AI)
# Repo: https://github.com/Ch4120N/ChPhisher
# ───────────────────────────────────────────────────────────────

set -euo pipefail

# ─── Colours & Styles ─────────────────────────────────────────
reset="\e[0m"
bold="\e[1m"
dim="\e[2m"
italic="\e[3m"
underline="\e[4m"

black="\e[30m"
red="\e[31m"
green="\e[32m"
yellow="\e[33m"
blue="\e[34m"
magenta="\e[35m"
cyan="\e[36m"
white="\e[37m"
grey="\e[90m"

bg_red="\e[41m"
bg_green="\e[42m"
bg_yellow="\e[43m"
bg_blue="\e[44m"
bg_magenta="\e[45m"
bg_cyan="\e[46m"

# ─── Helpers ──────────────────────────────────────────────────
print_info()  { echo -e "${blue}[ℹ]${reset} $*"; }
print_ok()    { echo -e "${green}[✓]${reset} $*"; }
print_warn()  { echo -e "${yellow}[⚠]${reset} $*"; }
print_error() { echo -e "${red}[✗]${reset} $*"; }
print_step()  { echo -e "${cyan}[➜]${reset} $*"; }
print_bold()  { echo -e "${bold}$*${reset}"; }

box_message() {
    local msg="$1"
    local len=$(( ${#msg} + 4 ))
    local bar=$(printf '%*s' "$len" | tr ' ' '─')
    echo -e "${cyan}╭${bar}╮${reset}"
    echo -e "${cyan}│ ${white}${msg}${cyan} │${reset}"
    echo -e "${cyan}╰${bar}╯${reset}"
}

# ─── Spinner ──────────────────────────────────────────────────
spinner() {
    local pid=$1
    local delay=0.1
    local spinstr='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
    tput civis  # hide cursor
    while kill -0 "$pid" 2>/dev/null; do
        for (( i=0; i<${#spinstr}; i++ )); do
            echo -ne "${grey}${spinstr:$i:1}${reset} \r"
            sleep "$delay"
        done
    done
    tput cnorm  # show cursor
    echo -ne "\r\033[K"
}

run_with_spinner() {
    local desc="$1"
    shift
    print_step "$desc"
    (
        "$@" > /tmp/spinner_out 2>&1
    ) &
    local pid=$!
    spinner "$pid"
    wait "$pid"
    local exit_code=$?
    if [[ $exit_code -eq 0 ]]; then
        print_ok "$desc – done"
    else
        print_error "$desc – failed (see /tmp/spinner_out)"
        exit "$exit_code"
    fi
}

# ─── Banner ────────────────────────────────────────────────────
banner() {
    echo -e "${cyan}"
    cat << "EOF"
                            ,--.
                           {    }
                           K,   }
                          /  ~Y`
                     ,   /   /
                    {_'-K.__/
                      `/-.__L._
                      /  ' /\`_}
                     /  ' /
             ____   /  ' /               --> ChPhisher Dependencies Installer <--
      ,-'~~~~    ~~/  ' /_             Github: https://github.com/Ch4120N/ChPhisher
    ,'             ``~~~  ',
   (                        Y
  {                         I
 {      -                    `,
 |       ',                   )
 |        |   ,..__      __. Y
 |    .,_./  Y ' / ^Y   J   )|
 |           |' /   |   |   ||
  \          L_/    . _ (_,.'(
   \,   ,      ^^""' / |      )
     \_  \          /,L]     /
       '-_~-,       ` `   ./`
          `'{_            )
              ^^\..___,.--`
EOF
    echo -e "${reset}\n"
}

# ─── OS / Package Manager Detection ──────────────────────────
detect_os() {
    OS_KERNEL=$(uname -s | tr '[:upper:]' '[:lower:]')
    OS_ARCH=$(uname -m | tr '[:upper:]' '[:lower:]')

    if [[ -n "${PREFIX:-}" && "$PREFIX" == *"com.termux"* ]]; then
        OS_NAME="termux"
        PKG_MANAGER="pkg"
        PKG_UPDATE="pkg update"
        PKG_INSTALL="pkg install -y"
        PYTHON_PKG="python"
        PIP_PKG="python-pip"
        PHP_PKG="php"
        return
    fi

    # Linux with /etc/os-release
    if [[ -f /etc/os-release ]]; then
        source /etc/os-release
        OS_NAME="${ID:-unknown}"
        OS_VERSION="${VERSION_ID:-}"
        case "$OS_NAME" in
            debian|ubuntu|kali|linuxmint|parrot|pop|elementary|zorin|raspbian)
                PKG_MANAGER="apt"
                PKG_UPDATE="apt-get update -qq"
                PKG_INSTALL="apt-get install -y"
                PYTHON_PKG="python3 python3-pip"
                PHP_PKG="php"
                ;;
            arch|manjaro|arcolinux|garuda|endeavouros|artix)
                PKG_MANAGER="pacman"
                PKG_UPDATE="pacman -Sy --noconfirm"
                PKG_INSTALL="pacman -S --noconfirm"
                PYTHON_PKG="python python-pip"
                PHP_PKG="php"
                ;;
            fedora|rhel|centos|rocky|almalinux)
                if command -v dnf &>/dev/null; then
                    PKG_MANAGER="dnf"
                    PKG_UPDATE="dnf check-update -q"
                    PKG_INSTALL="dnf install -y"
                else
                    PKG_MANAGER="yum"
                    PKG_UPDATE="yum check-update -q"
                    PKG_INSTALL="yum install -y"
                fi
                PYTHON_PKG="python3 python3-pip"
                PHP_PKG="php"
                ;;
            opensuse*|suse)
                PKG_MANAGER="zypper"
                PKG_UPDATE="zypper refresh"
                PKG_INSTALL="zypper install -y"
                PYTHON_PKG="python3 python3-pip"
                PHP_PKG="php"
                ;;
            alpine)
                PKG_MANAGER="apk"
                PKG_UPDATE="apk update"
                PKG_INSTALL="apk add"
                PYTHON_PKG="python3 py3-pip"
                PHP_PKG="php"
                ;;
            gentoo)
                PKG_MANAGER="emerge"
                PKG_UPDATE="emerge --sync -q"
                PKG_INSTALL="emerge -av"
                PYTHON_PKG="dev-python/pip"
                PHP_PKG="dev-lang/php"
                ;;
            *)
                # Fallback: try to detect package manager
                if command -v apt-get &>/dev/null; then
                    PKG_MANAGER="apt"
                    PKG_UPDATE="apt-get update -qq"
                    PKG_INSTALL="apt-get install -y"
                    PYTHON_PKG="python3 python3-pip"
                    PHP_PKG="php"
                elif command -v pacman &>/dev/null; then
                    PKG_MANAGER="pacman"
                    PKG_UPDATE="pacman -Sy --noconfirm"
                    PKG_INSTALL="pacman -S --noconfirm"
                    PYTHON_PKG="python python-pip"
                    PHP_PKG="php"
                elif command -v dnf &>/dev/null; then
                    PKG_MANAGER="dnf"
                    PKG_UPDATE="dnf check-update -q"
                    PKG_INSTALL="dnf install -y"
                    PYTHON_PKG="python3 python3-pip"
                    PHP_PKG="php"
                elif command -v yum &>/dev/null; then
                    PKG_MANAGER="yum"
                    PKG_UPDATE="yum check-update -q"
                    PKG_INSTALL="yum install -y"
                    PYTHON_PKG="python3 python3-pip"
                    PHP_PKG="php"
                elif command -v zypper &>/dev/null; then
                    PKG_MANAGER="zypper"
                    PKG_UPDATE="zypper refresh"
                    PKG_INSTALL="zypper install -y"
                    PYTHON_PKG="python3 python3-pip"
                    PHP_PKG="php"
                elif command -v apk &>/dev/null; then
                    PKG_MANAGER="apk"
                    PKG_UPDATE="apk update"
                    PKG_INSTALL="apk add"
                    PYTHON_PKG="python3 py3-pip"
                    PHP_PKG="php"
                elif command -v emerge &>/dev/null; then
                    PKG_MANAGER="emerge"
                    PKG_UPDATE="emerge --sync -q"
                    PKG_INSTALL="emerge -av"
                    PYTHON_PKG="dev-python/pip"
                    PHP_PKG="dev-lang/php"
                else
                    print_error "No supported package manager found. Please install python3, pip, and php manually."
                    exit 1
                fi
                ;;
        esac
        return
    fi

    # BSD / macOS
    case "$OS_KERNEL" in
        freebsd)
            OS_NAME="freebsd"
            PKG_MANAGER="pkg"
            PKG_UPDATE="pkg update -q"
            PKG_INSTALL="pkg install -y"
            PYTHON_PKG="python310 py310-pip"
            PHP_PKG="php"
            ;;
        openbsd)
            OS_NAME="openbsd"
            PKG_MANAGER="pkg_add"
            PKG_UPDATE="true"   # pkg_add doesn't have update
            PKG_INSTALL="pkg_add -I"
            PYTHON_PKG="python3 py3-pip"
            PHP_PKG="php"
            ;;
        darwin)
            OS_NAME="macos"
            if command -v brew &>/dev/null; then
                PKG_MANAGER="brew"
                PKG_UPDATE="brew update"
                PKG_INSTALL="brew install"
                PYTHON_PKG="python php"
                PIP_PKG=""   # pip comes with python on brew
            elif command -v port &>/dev/null; then
                PKG_MANAGER="port"
                PKG_UPDATE="port selfupdate"
                PKG_INSTALL="port install"
                PYTHON_PKG="python38 py38-pip"
                PHP_PKG="php"
            else
                print_error "macOS detected but neither Homebrew nor MacPorts found."
                print_info "Please install one of them or install python3 and php manually."
                exit 1
            fi
            ;;
        *)
            print_error "Unsupported OS: $OS_KERNEL"
            exit 1
            ;;
    esac
}

# ─── Install Packages ─────────────────────────────────────────
install_packages() {
    if [[ -n "${PIP_PKG:-}" ]]; then
        run_with_spinner "Updating package lists" sh -c "$PKG_UPDATE"
        run_with_spinner "Installing Python, PHP, and pip" sh -c "$PKG_INSTALL $PYTHON_PKG $PHP_PKG $PIP_PKG"
    else
        run_with_spinner "Updating package lists" sh -c "$PKG_UPDATE"
        run_with_spinner "Installing Python and PHP" sh -c "$PKG_INSTALL $PYTHON_PKG $PHP_PKG"
    fi
}

# ─── Install Python Dependencies ─────────────────────────────
install_python_deps() {
    if [[ ! -f requirements.txt ]]; then
        print_warn "requirements.txt not found in current directory. Skipping pip install."
        return
    fi

    if ! command -v pip3 &>/dev/null && ! command -v pip &>/dev/null; then
        print_error "pip not found. Please install pip manually."
        exit 1
    fi

    local pip_cmd
    if command -v pip3 &>/dev/null; then
        pip_cmd="pip3"
    else
        pip_cmd="pip"
    fi

    # Check Python version for --break-system-packages
    local py_version
    py_version=$(python3 -c 'import sys; print(sys.version_info[:2] >= (3,11))' 2>/dev/null || echo "False")
    local pip_flags=""
    if [[ "$py_version" == "True" ]] && [[ "$PKG_MANAGER" != "apk" && "$PKG_MANAGER" != "emerge" ]]; then
        # On some systems (Debian/Ubuntu with Python 3.11+), we need the flag
        if [[ "$PKG_MANAGER" == "apt" ]] || [[ "$PKG_MANAGER" == "dnf" ]] || [[ "$PKG_MANAGER" == "yum" ]]; then
            pip_flags="--break-system-packages"
        fi
    fi

    run_with_spinner "Installing Python dependencies" sh -c "$pip_cmd install -r requirements.txt $pip_flags"
}

# ─── Main ──────────────────────────────────────────────────────
main() {
    trap 'rm -f /tmp/spinner_out; exit' INT TERM EXIT

    banner

    # Check root (except Termux)
    if [[ "$OS_NAME" != "termux" ]] && [[ "$(id -u)" -ne 0 ]]; then
        print_error "This script must be run as root (or with sudo) to install system packages."
        exit 1
    fi

    box_message "Detecting your system..."
    detect_os
    print_info "OS: $OS_NAME ($OS_KERNEL $OS_ARCH)"
    print_info "Package Manager: $PKG_MANAGER"

    # Ask for confirmation
    read -rp "$(echo -e "${yellow}Proceed with installation? [Y/n] ${reset}")" confirm
    if [[ "$confirm" =~ ^[Nn]$ ]]; then
