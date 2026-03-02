#!/bin/bash
# ==============================================================================
# STATUS - Death Star System Status
# ==============================================================================
# Show Death Star ASCII art and system health information.
# ==============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ASSETS_DIR="$(dirname "$SCRIPT_DIR")/assets/ascii"

# Colors
RED='\033[0;31m'
BOLD_RED='\033[1;31m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

show_help() {
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${BOLD_RED}                    DEATH STAR                       ${NC}"
    echo -e "${CYAN}                    System Status                      ${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo ""
    echo -e "${YELLOW}Usage:${NC} status [options]"
    echo ""
    echo -e "${YELLOW}Options:${NC}"
    echo "  (none)            Show full status with ASCII art"
    echo "  --brief           Show brief status without ASCII"
    echo "  --help            Show this help message"
    echo ""
    echo -e "${RED}Fully Armed and Operational.${NC}"
}

show_deathstar_ascii() {
    if [ -f "$ASSETS_DIR/deathstar.txt" ]; then
        echo -e "${CYAN}"
        cat "$ASSETS_DIR/deathstar.txt"
        echo -e "${NC}"
    else
        # Fallback ASCII art
        echo -e "${CYAN}"
        echo "                          ..::::::::::.."
        echo "                      .::'              \`::."
        echo "                   .::'                    \`::."
        echo "                 .::'                        \`::."
        echo "               .::'                            \`::."
        echo "              ::'                                \`::."
        echo "            .::'                                    \`::."
        echo "           .::'                                        \`::."
        echo "          ::'                                              \`::."
        echo "         ::'                                                  \`::."
        echo "        ::'                                                      \`::."
        echo "       ::'                                                          \`::."
        echo "      ::'                                                              \`::."
        echo "     ::'                                                                  \`::."
        echo "    ::'                                                                      \`::."
        echo "   ::'                                                                          \`::."
        echo "  ::'                                                                              \`::."
        echo " ::'                                                                                  \`::."
        echo "::'                                                                                      \`::."
        echo "::                                                                                        ::"
        echo "::                                                                                        ::"
        echo "::'                                                                                      \`::."
        echo " ::'                                                                                  \`::."
        echo "  ::'                                                                              \`::."
        echo "   ::'                                                                          \`::."
        echo "    ::'                                                                      \`::."
        echo "     ::'                                                                  \`::."
        echo "      ::'                                                              \`::."
        echo "       ::'                                                          \`::."
        echo "        ::'                                                      \`::."
        echo "         ::'                                                  \`::."
        echo "          ::'                                              \`::."
        echo "           ::'                                          \`::."
        echo "            \`::.                                      .::'"
        echo "              \`::.                                  .::'"
        echo "               \`::.                              .::'"
        echo "                 \`::.                          .::'"
        echo "                   \`::.                      .::'"
        echo "                     \`:::.                .:::'"
        echo "                        \`\`:::::::::::::::''"
        echo -e "${NC}"
        echo ""
        echo -e "${RED}                    ~ THE DEATH STAR ~${NC}"
        echo -e "${YELLOW}              Fully Armed and Operational${NC}"
        echo ""
    fi
}

cmd_status() {
    local brief="${1:-false}"
    
    if [ "$brief" != "--brief" ]; then
        show_deathstar_ascii
    fi
    
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${BOLD_RED}              DEATH STAR SYSTEM STATUS               ${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo ""
    
    # System Health
    echo -e "${YELLOW}[1] SYSTEM HEALTH${NC}"
    
    # CPU (if available)
    if [ -f /proc/stat ]; then
        local cpu_usage=$(top -bn1 2>/dev/null | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
        if [ -z "$cpu_usage" ]; then
            cpu_usage="N/A"
        fi
        echo -e "   ${CYAN}CPU Usage:${NC}    $cpu_usage"
    elif command -v uptime &> /dev/null; then
        local load=$(uptime | awk -F'load average:' '{print $2}' | awk -F',' '{print $1}' | tr -d ' ')
        echo -e "   ${CYAN}Load Average:${NC} $load"
    else
        echo -e "   ${CYAN}CPU:${NC}        N/A"
    fi
    
    # Memory
    if [ -f /proc/meminfo ]; then
        local total_mem=$(grep MemTotal /proc/meminfo | awk '{print $2}')
        local free_mem=$(grep MemAvailable /proc/meminfo | awk '{print $2}')
        if [ -z "$free_mem" ]; then
            free_mem=$(grep MemFree /proc/meminfo | awk '{print $2}')
        fi
        local used_mem=$((total_mem - free_mem))
        local mem_percent=$((used_mem * 100 / total_mem))
        local total_mb=$((total_mem / 1024))
        local used_mb=$((used_mem / 1024))
        
        echo -e "   ${CYAN}Memory:${NC}     ${used_mb}MB / ${total_mb}MB (${mem_percent}%)"
        
        # Memory bar
        local bar_len=20
        local filled=$((mem_percent * bar_len / 100))
        printf "   ${CYAN}Status:${NC}   ["
        for ((i=0; i<filled; i++)); do
            if [ $mem_percent -gt 80 ]; then
                printf "${RED}█${NC}"
            elif [ $mem_percent -gt 50 ]; then
                printf "${YELLOW}█${NC}"
            else
                printf "${GREEN}█${NC}"
            fi
        done
        for ((i=filled; i<bar_len; i++)); do printf "░"; done
        printf "]\n"
    else
        echo -e "   ${CYAN}Memory:${NC}    N/A"
    fi
    
    # Disk
    if command -v df &> /dev/null; then
        local disk_info=$(df -h / 2>/dev/null | tail -1)
        local disk_percent=$(echo "$disk_info" | awk '{print $5}' | tr -d '%')
        local disk_avail=$(echo "$disk_info" | awk '{print $4}')
        echo -e "   ${CYAN}Disk Space:${NC} ${disk_avail} available (${disk_percent}% used)"
    fi
    echo ""
    
    # Git Status
    echo -e "${YELLOW}[2] GIT STATUS${NC}"
    if [ -d ".git" ]; then
        local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
        local status=$(git status --porcelain 2>/dev/null)
        local commits=$(git rev-list --count HEAD 2>/dev/null || echo "0")
        
        echo -e "   ${CYAN}Branch:${NC}      $branch"
        echo -e "   ${CYAN}Commits:${NC}     $commits"
        
        if [ -n "$status" ]; then
            local changed=$(echo "$status" | wc -l)
            echo -e "   ${CYAN}Changes:${NC}     ${YELLOW}$changed file(s) modified${NC}"
        else
            echo -e "   ${CYAN}Changes:${NC}     ${GREEN}✓ Working tree clean${NC}"
        fi
        
        # Check for remote
        local remote=$(git remote -v 2>/dev/null | head -1 | awk '{print $2}')
        if [ -n "$remote" ]; then
            echo -e "   ${CYAN}Remote:${NC}      Configured"
        fi
    else
        echo -e "   ${YELLOW}Not a git repository${NC}"
    fi
    echo ""
    
    # Rebel Activity Detection
    echo -e "${YELLOW}[3] SECURITY STATUS${NC}"
    
    # Check for TODOs and FIXMEs as "rebel activity"
    local rebel_count=$(grep -rn "TODO\|FIXME\|XXX\|HACK\|BUG" --include="*.sh" --include="*.js" --include="*.py" --include="*.ts" . 2>/dev/null | grep -v ".git" | wc -l)
    
    if [ "$rebel_count" -gt 0 ]; then
        echo -e "   ${RED}⚠️  REBEL ACTIVITY DETECTED!${NC}"
        echo -e "      Found $rebel_count suspicious code markers"
        echo -e "      ${YELLOW}Recommendation: Deploy Vader for code review${NC}"
    else
        echo -e "   ${GREEN}✓ No rebel activity detected${NC}"
        echo -e "      All systems secure"
    fi
    echo ""
    
    # Recent Activity
    echo -e "${YELLOW}[4] RECENT ACTIVITY${NC}"
    if [ -d ".git" ]; then
        git log --oneline -5 2>/dev/null | while read -r line; do
            echo -e "   ${CYAN}•${NC} $line"
        done
    else
        echo -e "   ${YELLOW}No git history available${NC}"
    fi
    echo ""
    
    # Summary
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${BOLD_RED}   DEATH STAR STATUS: OPERATIONAL${NC}"
    echo -e "${RED}   The Empire's ultimate weapon is ready.${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo ""
}

# Main command router
case "${1:-}" in
    --brief)
        cmd_status "--brief"
        ;;
    --help|-h)
        show_help
        ;;
    *)
        cmd_status
        ;;
esac
