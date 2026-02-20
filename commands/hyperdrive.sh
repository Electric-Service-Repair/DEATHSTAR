#!/bin/bash
# ==============================================================================
# HYPERDRIVE - The Navigation System
# ==============================================================================
# Navigate to folders with a hyperspace jump animation.
# ==============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ASSETS_DIR="$(dirname "$SCRIPT_DIR")/assets/ascii"

# Colors
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

show_help() {
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${WHITE}                      HYPERDRIVE                       ${NC}"
    echo -e "${CYAN}                    Navigation System                  ${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo ""
    echo -e "${YELLOW}Usage:${NC} hyperdrive <command> [options]"
    echo ""
    echo -e "${YELLOW}Commands:${NC}"
    echo "  jump <folder>     Navigate to folder with hyperspace animation"
    echo "  coords            Show current location and recent directories"
    echo "  help              Show this help message"
    echo ""
    echo -e "${BLUE}Engage!${NC}"
}

hyperspace_animation() {
    local target="$1"
    
    echo ""
    echo -e "${WHITE}╔═══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${WHITE}║${NC}              ${BLUE}HYPERDRIVE NAVIGATION SYSTEM${NC}              ${WHITE}║${NC}"
    echo -e "${WHITE}╚═══════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${CYAN}   Calculating hyperspace route to: ${YELLOW}$target${NC}"
    echo ""
    
    sleep 0.5
    
    # Starfield animation
    echo -e "   ${WHITE}Preparing hyperdrive...${NC}"
    sleep 0.3
    
    echo -ne "   ${CYAN}"
    for i in $(seq 1 10); do
        echo -ne "█"
        sleep 0.05
    done
    echo -e "${NC} 10%"
    sleep 0.1
    
    echo -ne "   ${CYAN}"
    for i in $(seq 1 20); do
        echo -ne "█"
        sleep 0.03
    done
    echo -e "${NC} 50%"
    sleep 0.1
    
    echo -ne "   ${CYAN}"
    for i in $(seq 1 30); do
        echo -ne "█"
        sleep 0.02
    done
    echo -e "${NC} 100%"
    echo ""
    
    echo -e "   ${YELLOW}⚡ HYPERDRIVE ENGAGED! ⚡${NC}"
    echo ""
    
    # Hyperspace effect
    local stars=("*" "·" "•" "⁕" "⁂" "✦" "✧" "★" "☆")
    
    for frame in 1 2 3 4 5; do
        echo -ne "   ${WHITE}"
        for i in $(seq 1 40); do
            local star_idx=$((RANDOM % ${#stars[@]}))
            echo -ne "${stars[$star_idx]}"
        done
        echo -e "${NC}"
        sleep 0.08
    done
    
    # Stretch effect
    echo -e "   ${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    sleep 0.1
    echo -e "   ${CYAN}════════════════════════════════════════${NC}"
    sleep 0.1
    echo -e "   ${YELLOW}▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓${NC}"
    sleep 0.1
    echo -e "   ${WHITE}████████████████████████████████████████${NC}"
    sleep 0.2
    
    echo ""
    echo -e "   ${GREEN}✨ ARRIVED AT DESTINATION ✨${NC}"
    echo ""
}

cmd_jump() {
    local target="${1:-}"
    
    if [ -z "$target" ]; then
        echo -e "${RED}HYPERDRIVE: No destination specified.${NC}"
        echo -e "${YELLOW}Usage: hyperdrive jump <folder>${NC}"
        echo ""
        echo -e "${CYAN}Available directories:${NC}"
        ls -d */ 2>/dev/null | head -10 | while read -r dir; do
            echo -e "   ${YELLOW}• $dir${NC}"
        done
        exit 1
    fi
    
    # Check if target exists
    if [ ! -d "$target" ]; then
        echo -e "${RED}HYPERDRIVE: Destination '$target' does not exist.${NC}"
        echo -e "${YELLOW}Check your coordinates and try again.${NC}"
        exit 1
    fi
    
    # Get absolute path
    local abs_path=$(cd "$target" && pwd)
    
    # Run animation
    hyperspace_animation "$abs_path"
    
    echo -e "${CYAN}   Current location: ${YELLOW}$abs_path${NC}"
    echo ""
    echo -e "${WHITE}   Directory contents:${NC}"
    ls -la "$target" | head -15
    echo ""
    
    # Generate cd command for user
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${YELLOW}   To navigate there, run:${NC}"
    echo -e "${WHITE}   cd $abs_path${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo ""
    
    # Option to auto-cd (for sourcing)
    if [ -n "$HYPERSOURCE" ]; then
        cd "$target"
        echo -e "${GREEN}   ✓ Automatically changed directory${NC}"
    fi
}

cmd_coords() {
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${WHITE}                 NAVIGATION COORDINATES                  ${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo ""
    
    echo -e "${CYAN}   Current Location:${NC}"
    echo -e "   ${YELLOW}$(pwd)${NC}"
    echo ""
    
    echo -e "${CYAN}   Parent Directory:${NC}"
    echo -e "   ${YELLOW}$(dirname "$(pwd)")${NC}"
    echo ""
    
    echo -e "${CYAN}   Nearby Sectors (subdirectories):${NC}"
    local dirs=$(ls -d */ 2>/dev/null)
    if [ -n "$dirs" ]; then
        echo "$dirs" | while read -r dir; do
            echo -e "   ${YELLOW}• $dir${NC}"
        done
    else
        echo -e "   ${YELLOW}No subdirectories found${NC}"
    fi
    echo ""
    
    echo -e "${CYAN}   Recent Directories (from history):${NC}"
    if [ -f ~/.bash_history ]; then
        grep "^cd " ~/.bash_history 2>/dev/null | tail -5 | sed 's/cd /   → /' | while read -r line; do
            echo -e "   ${YELLOW}$line${NC}"
        done
    else
        echo -e "   ${YELLOW}History unavailable${NC}"
    fi
    echo ""
}

# Main command router
case "${1:-help}" in
    jump)
        cmd_jump "$2"
        ;;
    coords)
        cmd_coords
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        echo -e "${RED}HYPERDRIVE: Unknown command '$1'${NC}"
        echo ""
        show_help
        exit 1
        ;;
esac
