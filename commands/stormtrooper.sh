#!/bin/bash
# ==============================================================================
# STORMTROOPER - The Fuzzy Finder
# ==============================================================================
# Find files with Imperial precision (or miss like a Stormtrooper).
# ==============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ASSETS_DIR="$(dirname "$SCRIPT_DIR")/assets/ascii"

# Colors
WHITE='\033[1;37m'
BOLD_WHITE='\033[1;37m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Stormtrooper miss quotes
STORMTROOPER_MISSES=(
    "We missed the target... again."
    "Our aim was off by 0.03 percent. Acceptable."
    "The Force was with them, clearly."
    "Blame the new armor specifications."
    "I swear I hit it in simulation!"
    "These rebels are unnaturally lucky."
    "The lighting in here is terrible."
    "My blaster was set to stun... I think."
    "Command said to miss. Psychological warfare."
    "I was distracted by that shiny thing."
)

random_stormtrooper_miss() {
    echo "${STORMTROOPER_MISSES[$RANDOM % ${#STORMTROOPER_MISSES[@]}]}"
}

show_help() {
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${BOLD_WHITE}                    STORMTROOPER                     ${NC}"
    echo -e "${CYAN}                    Fuzzy File Finder                    ${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo ""
    echo -e "${YELLOW}Usage:${NC} stormtrooper <command> [options]"
    echo ""
    echo -e "${YELLOW}Commands:${NC}"
    echo "  find <pattern>    Fuzzy search for files matching pattern"
    echo "  aim               Test your aim (find with strict matching)"
    echo "  help              Show this help message"
    echo ""
    echo -e "${WHITE}\"All according to plan... hopefully.\"${NC}"
}

cmd_find() {
    local pattern="${1:-}"
    
    if [ -z "$pattern" ]; then
        echo -e "${RED}STORMTROOPER: No target pattern specified!${NC}"
        echo -e "${YELLOW}Usage: stormtrooper find <pattern>${NC}"
        echo ""
        echo -e "${CYAN}Example patterns:${NC}"
        echo -e "   ${WHITE}stormtrooper find \"*.sh\"${NC}"
        echo -e "   ${WHITE}stormtrooper find \"readme\"${NC}"
        echo -e "   ${WHITE}stormtrooper find \"config\"${NC}"
        exit 1
    fi
    
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${BOLD_WHITE}              STORMTROOPER SEARCH SQUAD            ${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo ""
    echo -e "${WHITE}   Target pattern: ${YELLOW}$pattern${NC}"
    echo -e "${WHITE}   Engaging search protocols...${NC}"
    echo ""
    
    # Decide if we "miss" (10% chance for fun)
    local miss_chance=$((RANDOM % 10))
    
    # Search for files
    local results=$(find . -type f -name "*$pattern*" 2>/dev/null | grep -v ".git" | head -20)
    local count=$(echo "$results" | grep -c "." 2>/dev/null || echo "0")
    
    if [ -z "$results" ] || [ "$count" -eq 0 ]; then
        # No results - Stormtrooper miss!
        echo -e "${RED}╔═══════════════════════════════════════════════════════════╗${NC}"
        echo -e "${RED}║${NC}  ${BOLD_WHITE}⚠️  TARGET NOT LOCATED ⚠️${NC}"
        echo -e "${RED}║${NC}"
        echo -e "${RED}║${NC}  ${YELLOW}\"$(random_stormtrooper_miss)\"${NC}"
        echo -e "${RED}║${NC}"
        echo -e "${RED}║${NC}  ${CYAN}Suggestions:${NC}"
        echo -e "${RED}║${NC}  • Check your spelling"
        echo -e "${RED}║${NC}  • Try a broader pattern"
        echo -e "${RED}║${NC}  • Verify the file exists"
        echo -e "${RED}╚═══════════════════════════════════════════════════════════╝${NC}"
        echo ""
        exit 0
    fi
    
    echo -e "${GREEN}   ✓ Target acquired!${NC}"
    echo ""
    echo -e "${WHITE}   Found $count file(s):${NC}"
    echo ""
    
    # Display results with numbering
    local num=1
    echo "$results" | while read -r file; do
        if [ -n "$file" ]; then
            # Get file size
            local size=$(ls -lh "$file" 2>/dev/null | awk '{print $5}')
            printf "   ${CYAN}[%2d]${NC} ${YELLOW}%s${NC} ${WHITE}(%s)${NC}\n" "$num" "$file" "$size"
            ((num++))
        fi
    done
    echo ""
    
    if [ "$count" -gt 20 ]; then
        echo -e "${YELLOW}   ... and more. Refine your search for additional results.${NC}"
    fi
    
    echo ""
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${WHITE}   Search complete. The Empire is pleased.${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo ""
}

cmd_aim() {
    local pattern="${1:-}"
    
    if [ -z "$pattern" ]; then
        echo -e "${RED}STORMTROOPER: No target specified for aim training!${NC}"
        echo -e "${YELLOW}Usage: stormtrooper aim <pattern>${NC}"
        exit 1
    fi
    
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${BOLD_WHITE}              STORMTROOPER AIM TRAINING            ${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo ""
    echo -e "${WHITE}   Target pattern: ${YELLOW}$pattern${NC}"
    echo -e "${WHITE}   Mode: ${GREEN}PRECISION${NC} (exact matching)${NC}"
    echo ""
    
    # Strict/exact matching
    local results=$(find . -type f -name "$pattern" 2>/dev/null | grep -v ".git" | head -20)
    local count=$(echo "$results" | grep -c "." 2>/dev/null || echo "0")
    
    if [ -z "$results" ] || [ "$count" -eq 0 ]; then
        echo -e "${RED}   No exact matches found.${NC}"
        echo -e "${YELLOW}   Your aim is true, but the target does not exist.${NC}"
        echo ""
        echo -e "${CYAN}   Trying fuzzy match instead...${NC}"
        echo ""
        
        results=$(find . -type f -name "*$pattern*" 2>/dev/null | grep -v ".git" | head -10)
        if [ -n "$results" ]; then
            echo -e "${YELLOW}   Close matches found:${NC}"
            echo "$results" | while read -r file; do
                if [ -n "$file" ]; then
                    echo -e "      ${CYAN}• $file${NC}"
                fi
            done
        fi
        exit 0
    fi
    
    echo -e "${GREEN}   ✓ BULLSEYE! Perfect aim!${NC}"
    echo ""
    echo -e "${WHITE}   Exact matches:${NC}"
    echo ""
    
    local num=1
    echo "$results" | while read -r file; do
        if [ -n "$file" ]; then
            local size=$(ls -lh "$file" 2>/dev/null | awk '{print $5}')
            printf "   ${GREEN}[%2d]${NC} ${YELLOW}%s${NC} ${WHITE}(%s)${NC}\n" "$num" "$file" "$size"
            ((num++))
        fi
    done
    echo ""
    
    echo -e "${GREEN}╔═══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║${NC}  ${BOLD_WHITE}🎯 PERFECT AIM! 🎯${NC}"
    echo -e "${GREEN}║${NC}"
    echo -e "${GREEN}║${NC}  ${WHITE}\"Outstanding! You're a credit to the Empire!\"${NC}"
    echo -e "${GREEN}╚═══════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

# Main command router
case "${1:-help}" in
    find)
        cmd_find "$2"
        ;;
    aim)
        cmd_aim "$2"
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        echo -e "${RED}STORMTROOPER: Unknown command '$1'${NC}"
        echo -e "${RED}$(random_stormtrooper_miss)${NC}"
        echo ""
        show_help
        exit 1
        ;;
esac
