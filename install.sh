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
