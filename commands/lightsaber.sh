#!/bin/bash
# ==============================================================================
# LIGHTSABER - The Glowing Editor
# ==============================================================================
# Open files with a Jedi lightsaber effect.
# ==============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ASSETS_DIR="$(dirname "$SCRIPT_DIR")/assets/ascii"

# Colors
RED='\033[0;31m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
PURPLE='\033[0;35m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD_WHITE='\033[1;37m'
NC='\033[0m' # No Color

show_help() {
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${BOLD_WHITE}                    LIGHTSABER                     ${NC}"
    echo -e "${CYAN}                    Glowing Editor                     ${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo ""
    echo -e "${YELLOW}Usage:${NC} lightsaber <command> [options]"
    echo ""
    echo -e "${YELLOW}Commands:${NC}"
    echo "  edit <file>       Open file with glowing cursor effect"
    echo "  colors            Show available lightsaber colors"
    echo "  help              Show this help message"
    echo ""
    echo -e "${GREEN}May the Force be with your code.${NC}"
}

lightsaber_animation() {
    local color="$1"
    local width=50
    
    echo ""
    echo -e "${BOLD_WHITE}              ╔══════════════════════════════════════╗${NC}"
    echo -e "${BOLD_WHITE}              ║${NC}     ${color}ACTIVATING LIGHTSABER...${NC}     ${BOLD_WHITE}║${NC}"
    echo -e "${BOLD_WHITE}              ╚══════════════════════════════════════╝${NC}"
    echo ""
    
    # Ignition animation
    echo -ne "              ${color}"
    for i in $(seq 1 20); do
        echo -ne "█"
        sleep 0.05
    done
    echo -e " ${NC}✨${color}⚔️${NC}✨"
    sleep 0.3
    
    # Sound effect (text)
    echo -e "              ${color}VMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM${NC}"
    echo -e "              ${color}VMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM${NC}"
    sleep 0.5
    echo ""
}

show_color_options() {
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${BOLD_WHITE}              LIGHTSABER COLOR OPTIONS               ${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo ""
    echo -e "  ${GREEN}green${NC}   - Jedi Classic (Luke/Yoda)"
    echo -e "  ${BLUE}blue${NC}    - Jedi Guardian (Obi-Wan/Anakin)"
    echo -e "  ${RED}red${NC}     - Sith Lord (Vader/Sidious)"
    echo -e "  ${PURPLE}purple${NC}  - Mace Windu Special"
    echo -e "  ${YELLOW}yellow${NC}  - Temple Guard"
    echo -e "  ${CYAN}cyan${NC}     - Ahsoka's White (converted)"
    echo ""
    echo -e "${YELLOW}Usage:${NC} lightsaber edit <file> [--color=<color>]"
    echo ""
}

cmd_edit() {
    local file="${1:-}"
    local color="${GREEN}"  # Default to Jedi green
    
    # Parse color option
    for arg in "$@"; do
        case $arg in
            --color=*)
                color_name="${arg#*=}"
                case $color_name in
                    green)  color="${GREEN}" ;;
                    blue)   color="${BLUE}" ;;
                    red)    color="${RED}" ;;
                    purple) color="${PURPLE}" ;;
                    yellow) color="${YELLOW}" ;;
                    cyan)   color="${CYAN}" ;;
                    white)  color="${BOLD_WHITE}" ;;
                    *)      echo -e "${YELLOW}Unknown color '$color_name'. Using green.${NC}"; color="${GREEN}" ;;
                esac
                ;;
        esac
    done
    
    # Get the actual file (first non-option argument)
    for arg in "$@"; do
        case $arg in
            --color=*) ;;
            *) 
                if [ -z "$file" ] && [ -e "$arg" ] || [[ "$arg" != --* ]]; then
                    file="$arg"
                fi
                ;;
        esac
    done
    
    if [ -z "$file" ]; then
        echo -e "${RED}LIGHTSABER: No file specified.${NC}"
        echo -e "${YELLOW}Usage: lightsaber edit <file> [--color=<color>]${NC}"
        exit 1
    fi
    
    # Check if file exists
    if [ ! -e "$file" ]; then
        echo -e "${YELLOW}File '$file' does not exist. Create it?${NC}"
        read -p "Create file? (y/N): " confirm
        if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
            touch "$file"
            echo -e "${GREEN}File created: $file${NC}"
        else
            echo -e "${RED}Aborted.${NC}"
            exit 1
        fi
    fi
    
    # Show lightsaber animation
    lightsaber_animation "$color"
    
    echo -e "${color}              ═══════════════════════════════════════${NC}"
    echo -e "${color}              Opening: $file${NC}"
    echo -e "${color}              ═══════════════════════════════════════${NC}"
    echo ""
    
    # Detect available editor
    local editor=""
    if [ -n "$EDITOR" ]; then
        editor="$EDITOR"
    elif command -v nano &> /dev/null; then
        editor="nano"
    elif command -v vim &> /dev/null; then
        editor="vim"
    elif command -v vi &> /dev/null; then
        editor="vi"
    else
        echo -e "${RED}No text editor found. Please set EDITOR environment variable.${NC}"
        exit 1
    fi
    
    echo -e "${CYAN}Using editor: $editor${NC}"
    echo -e "${YELLOW}Press Ctrl+X (nano) or :q (vim) to exit${NC}"
    echo ""
    sleep 1
    
    # Open the file
    $editor "$file"
    
    local exit_code=$?
    
    echo ""
    echo -e "${color}              ═══════════════════════════════════════${NC}"
    echo -e "${color}              DEACTIVATING LIGHTSABER...${NC}"
    echo -e "${color}              ═══════════════════════════════════════${NC}"
    
    # Deactivation animation
    sleep 0.2
    echo -ne "${color}"
    for i in $(seq 1 15); do
        echo -ne "█"
        sleep 0.03
    done
    echo -e "${NC} 💨"
    sleep 0.3
    
    echo ""
    if [ $exit_code -eq 0 ]; then
        echo -e "${GREEN}✓ File closed successfully${NC}"
    else
        echo -e "${YELLOW}Editor exited with code: $exit_code${NC}"
    fi
    echo ""
    echo -e "${GREEN}May the Force be with your code.${NC}"
    echo ""
}

cmd_colors() {
    show_color_options
}

# Main command router
case "${1:-help}" in
    edit)
        shift
        cmd_edit "$@"
        ;;
    colors)
        cmd_colors
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        echo -e "${RED}LIGHTSABER: Unknown command '$1'${NC}"
        echo ""
        show_help
        exit 1
        ;;
esac
