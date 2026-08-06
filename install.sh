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
