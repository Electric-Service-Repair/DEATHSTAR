#!/bin/bash
# ==============================================================================
# R2-D2 - System Diagnostics Droid
# ==============================================================================
# Your loyal astromech droid for system checks and beeps.
# ==============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ASSETS_DIR="$(dirname "$SCRIPT_DIR")/assets/ascii"

# Colors
BLUE='\033[0;34m'
BOLD_BLUE='\033[1;34m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# R2-D2 sounds
R2_SOUNDS=(
    "*beep*"
    "*boop*"
    "*whistle*"
    "*chirp*"
    "*bloop*"
    "*weeoo*"
    "*beep boop*"
    "*warble*"
)

random_r2_sound() {
    echo "${R2_SOUNDS[$RANDOM % ${#R2_SOUNDS[@]}]}"
}

show_help() {
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${BOLD_BLUE}                      R2-D2                          ${NC}"
    echo -e "${CYAN}                    System Diagnostics                   ${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo ""
    echo -e "${YELLOW}Usage:${NC} r2d2 <command> [options]"
    echo ""
    echo -e "${YELLOW}Commands:${NC}"
    echo "  scan              Full system check (disk, memory, git status)"
    echo "  beep              Play Star Wars beeps"
    echo "  help              Show this help message"
    echo ""
    echo -e "${BLUE}$(random_r2_sound) ${CYAN}$(random_r2_sound)${NC}"
}

cmd_scan() {
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${BOLD_BLUE}              R2-D2 SYSTEM DIAGNOSTICS               ${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo ""
    
    # Display R2-D2 ASCII
    if [ -f "$ASSETS_DIR/r2d2.txt" ]; then
        echo -e "${BLUE}"
        cat "$ASSETS_DIR/r2d2.txt"
        echo -e "${NC}"
        echo ""
    fi
    
    echo -e "${CYAN}   $(random_r2_sound) Starting system scan...${NC}"
    echo ""
    
    # Disk usage
    echo -e "${YELLOW}[1] DISK USAGE${NC}"
    if command -v df &> /dev/null; then
        local disk_info=$(df -h / 2>/dev/null | tail -1)
        local total=$(echo "$disk_info" | awk '{print $2}')
        local used=$(echo "$disk_info" | awk '{print $3}')
        local available=$(echo "$disk_info" | awk '{print $4}')
        local percent=$(echo "$disk_info" | awk '{print $5}')
        
        echo -e "   ${CYAN}Total:${NC}     $total"
        echo -e "   ${CYAN}Used:${NC}      $used"
        echo -e "   ${CYAN}Available:${NC} $available"
        echo -e "   ${CYAN}Usage:${NC}     $percent"
        
        # Visual bar
        local percent_num=${percent%\%}
        local bar_length=20
        local filled=$((percent_num * bar_length / 100))
        local empty=$((bar_length - filled))
        
        printf "   ["
        for ((i=0; i<filled; i++)); do printf "${GREEN}█${NC}"; done
        for ((i=0; i<empty; i++)); do printf "░"; done
        printf "] %s\n" "$percent"
        
        if [ "$percent_num" -gt 80 ]; then
            echo -e "   ${RED}⚠️  Warning: Disk usage is high!${NC}"
        fi
    else
        echo -e "   ${YELLOW}Disk info unavailable${NC}"
    fi
    echo ""
    
    # Memory usage
    echo -e "${YELLOW}[2] MEMORY USAGE${NC}"
    if [ -f /proc/meminfo ]; then
        local total_mem=$(grep MemTotal /proc/meminfo | awk '{print $2}')
        local free_mem=$(grep MemAvailable /proc/meminfo | awk '{print $2}')
        if [ -z "$free_mem" ]; then
            free_mem=$(grep MemFree /proc/meminfo | awk '{print $2}')
        fi
        local used_mem=$((total_mem - free_mem))
        local percent=$((used_mem * 100 / total_mem))
        
        # Convert to MB
        local total_mb=$((total_mem / 1024))
        local used_mb=$((used_mem / 1024))
        local free_mb=$((free_mem / 1024))
        
        echo -e "   ${CYAN}Total:${NC}     ${total_mb} MB"
        echo -e "   ${CYAN}Used:${NC}      ${used_mb} MB"
        echo -e "   ${CYAN}Free:${NC}      ${free_mb} MB"
        echo -e "   ${CYAN}Usage:${NC}     ${percent}%"
        
        # Visual bar
        local bar_length=20
        local filled=$((percent * bar_length / 100))
        local empty=$((bar_length - filled))
        
        printf "   ["
        for ((i=0; i<filled; i++)); do printf "${GREEN}█${NC}"; done
        for ((i=0; i<empty; i++)); do printf "░"; done
        printf "] %s%%\n" "$percent"
    elif command -v free &> /dev/null; then
        free -h | grep Mem | awk '{printf "   Total: %s | Used: %s | Free: %s\n", $2, $3, $4}'
    else
        echo -e "   ${YELLOW}Memory info unavailable${NC}"
    fi
    echo ""
    
    # Git status
    echo -e "${YELLOW}[3] GIT STATUS${NC}"
    if [ -d ".git" ]; then
        local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
        local status=$(git status --porcelain 2>/dev/null)
        local commits_ahead=$(git rev-list --count HEAD "@{u}" 2>/dev/null || echo "0")
        local commits_behind=$(git rev-list --count "@{u}..HEAD" 2>/dev/null || echo "0")
        
        echo -e "   ${CYAN}Branch:${NC}   $branch"
        
        if [ -n "$status" ]; then
            local changed=$(echo "$status" | wc -l)
            echo -e "   ${CYAN}Changes:${NC}  $changed file(s) modified"
            echo -e "   ${YELLOW}⚠️  Uncommitted changes detected${NC}"
        else
            echo -e "   ${GREEN}✓ Working tree clean${NC}"
        fi
        
        if [ "$commits_ahead" != "0" ] || [ "$commits_behind" != "0" ]; then
            echo -e "   ${CYAN}Remote:${NC}   +$commits_ahead / -$commits_behind"
        fi
    else
        echo -e "   ${YELLOW}Not a git repository${NC}"
    fi
    echo ""
    
    # System info
    echo -e "${YELLOW}[4] SYSTEM INFO${NC}"
    if command -v uname &> /dev/null; then
        echo -e "   ${CYAN}OS:${NC}       $(uname -s)"
        echo -e "   ${CYAN}Kernel:${NC}   $(uname -r)"
        echo -e "   ${CYAN}Arch:${NC}     $(uname -m)"
    fi
    
    if command -v uptime &> /dev/null; then
        local uptime_info=$(uptime -p 2>/dev/null || uptime | awk -F'up ' '{print $2}' | awk -F',' '{print $1}')
        echo -e "   ${CYAN}Uptime:${NC}   $uptime_info"
    fi
    echo ""
    
    # Summary
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}   $(random_r2_sound) $(random_r2_sound) Scan complete!${NC}"
    echo -e "${BLUE}   $(random_r2_sound) All systems nominal.${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo ""
}

cmd_beep() {
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${BOLD_BLUE}              R2-D2 SOUND SEQUENCE                   ${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo ""
    
    # Star Wars beep sequence
    local beeps=(
        "*BEEP*"
        "*boop*"
        "*WHEE-ooo*"
        "*bloop-bloop*"
        "*WHA-whistle*"
        "*beep-boop-beep*"
        "*warble-warble*"
        "*BEEP-BEEP*"
        "*chirp-chirp*"
        "*WHEE-ooo-whee*"
    )
    
    for beep in "${beeps[@]}"; do
        echo -e "   ${BLUE}$beep${NC}"
        
        # Try to make actual sound
        if command -v speaker-test &> /dev/null; then
            speaker-test -t sine -f 800 -l 1 -D plughw:0,0 2>/dev/null &
            sleep 0.1
            kill $! 2>/dev/null
        elif [ -e /dev/tty ]; then
            printf '\a'  # Terminal bell
        fi
        
        sleep 0.2
    done
    
    echo ""
    echo -e "${BLUE}   *R2-D2 whistles happily*${NC}"
    echo ""
    echo -e "${CYAN}   Translation: \"All systems operational, sir!\"${NC}"
    echo ""
}

# Main command router
case "${1:-help}" in
    scan)
        cmd_scan
        ;;
    beep)
        cmd_beep
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        echo -e "${BLUE}R2-D2: $(random_r2_sound) $(random_r2_sound)${NC}"
        echo -e "${YELLOW}Unknown command '$1'. Try 'r2d2 help'.${NC}"
        echo ""
        show_help
        exit 1
        ;;
esac
