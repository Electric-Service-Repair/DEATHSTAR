#!/bin/bash
# ==============================================================================
# THRAWN - The Analytics Commander
# ==============================================================================
# Grand Admiral Thrawn analyzes your repository with tactical precision.
# ==============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ASSETS_DIR="$(dirname "$SCRIPT_DIR")/assets/ascii"

# Colors
PURPLE='\033[0;35m'
BOLD_PURPLE='\033[1;35m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Thrawn quotes
THRAWN_QUOTES=(
    "Every artist reveals something unique about themselves in their work."
    "To understand your enemy, you must first understand their art."
    "Victory is achieved through knowledge, not brute force."
    "I have studied the tactics of many species. All are predictable."
    "The best strategy is one that your enemy does not anticipate."
    "A true commander knows his enemy better than they know themselves."
    "Chaos is merely a pattern we have yet to understand."
)

random_thrawn_quote() {
    echo "${THRAWN_QUOTES[$RANDOM % ${#THRAWN_QUOTES[@]}]}"
}

show_help() {
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${BOLD_PURPLE}                GRAND ADMIRAL THRAWN               ${NC}"
    echo -e "${CYAN}                    Analytics Commander                  ${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo ""
    echo -e "${YELLOW}Usage:${NC} thrawn <command> [options]"
    echo ""
    echo -e "${YELLOW}Commands:${NC}"
    echo "  repo              Analyze Git history and repository health"
    echo "  help              Show this help message"
    echo ""
    echo -e "${PURPLE}\"${BOLD_PURPLE}$(random_thrawn_quote)${PURPLE}\"${NC}"
}

cmd_repo() {
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${BOLD_PURPLE}              THRAWN'S TACTICAL ANALYSIS           ${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo ""
    
    if [ ! -d ".git" ]; then
        echo -e "${RED}THRAWN: This is not a git repository.${NC}"
        echo -e "${RED}        How can I analyze what does not exist?${NC}"
        exit 1
    fi
    
    echo -e "${PURPLE}   \"$(random_thrawn_quote)\"${NC}"
    echo ""
    
    # Repository基本信息
    echo -e "${YELLOW}[1] REPOSITORY OVERVIEW${NC}"
    local repo_name=$(basename "$(pwd)")
    local total_commits=$(git rev-list --count HEAD 2>/dev/null || echo "0")
    local first_commit=$(git log --reverse --format="%ci" 2>/dev/null | head -1)
    local last_commit=$(git log -1 --format="%ci" 2>/dev/null)
    local branches=$(git branch | wc -l)
    local contributors=$(git log --format="%aN" 2>/dev/null | sort -u | wc -l)
    
    echo -e "   ${CYAN}Repository:${NC}   $repo_name"
    echo -e "   ${CYAN}Total Commits:${NC} $total_commits"
    echo -e "   ${CYAN}Branches:${NC}     $branches"
    echo -e "   ${CYAN}Contributors:${NC} $contributors"
    echo -e "   ${CYAN}First Commit:${NC} ${first_commit:-N/A}"
    echo -e "   ${CYAN}Last Commit:${NC}  $last_commit"
    echo ""
    
    # Commit activity
    echo -e "${YELLOW}[2] COMMIT ACTIVITY${NC}"

    # Commits by day of week
    echo -e "   ${CYAN}Commits by Day:${NC}"
    local days=("Monday" "Tuesday" "Wednesday" "Thursday" "Friday" "Saturday" "Sunday")
    local day_commits=()

    for i in {1..7}; do
        local count=$(git log --all --format="%ad" --date=format-w:"%u" 2>/dev/null | grep -c "^$i$" 2>/dev/null || echo "0")
        count=$(echo "$count" | tr -d '[:space:]')
        if [ -z "$count" ] || ! [[ "$count" =~ ^[0-9]+$ ]]; then
            count=0
        fi
        day_commits+=("$count")
    done

    local max_commits=0
    for count in "${day_commits[@]}"; do
        count=$(echo "$count" | tr -d '[:space:]')
        if [ -n "$count" ] && [ "$count" -gt "$max_commits" ] 2>/dev/null; then
            max_commits=$count
        fi
    done

    for i in {0..6}; do
        local count=${day_commits[$i]}
        count=$(echo "$count" | tr -d '[:space:]')
        if [ -z "$count" ] || ! [[ "$count" =~ ^[0-9]+$ ]]; then
            count=0
        fi
        local bar_len=0
        if [ "$max_commits" -gt 0 ] 2>/dev/null; then
            bar_len=$((count * 20 / max_commits))
        fi

        printf "   ${CYAN}%s:${NC} " "${days[$i]:0:3}"
        for ((j=0; j<bar_len; j++)); do
            printf "${PURPLE}█${NC}"
        done
        printf " (%d)\n" "$count"
    done
    echo ""
    
    # Top contributors
    echo -e "${YELLOW}[3] TOP CONTRIBUTORS${NC}"
    git log --format="%aN" 2>/dev/null | sort | uniq -c | sort -rn | head -5 | while read -r count name; do
        local percent=0
        if [ "$total_commits" -gt 0 ]; then
            percent=$((count * 100 / total_commits))
        fi
        printf "   ${CYAN}%-25s${NC} %4d commits (%d%%)\n" "$name" "$count" "$percent"
    done
    echo ""
    
    # File analysis
    echo -e "${YELLOW}[4] FILE ANALYSIS${NC}"
    local total_files=$(git ls-files 2>/dev/null | wc -l)
    local total_lines=$(git ls-files 2>/dev/null | xargs wc -l 2>/dev/null | tail -1 | awk '{print $1}')
    
    echo -e "   ${CYAN}Tracked Files:${NC} $total_files"
    echo -e "   ${CYAN}Total Lines:${NC}   ${total_lines:-0}"
    echo ""
    
    # File types breakdown
    echo -e "   ${CYAN}File Types:${NC}"
    git ls-files 2>/dev/null | sed 's/.*\.//' | sort | uniq -c | sort -rn | head -5 | while read -r count ext; do
        printf "   ${PURPLE}%-15s${NC} %d files\n" ".$ext" "$count"
    done
    echo ""
    
    # Weak spots analysis
    echo -e "${YELLOW}[5] WEAK SPOTS ANALYSIS${NC}"
    
    # Files with most changes
    echo -e "   ${CYAN}Most Modified Files:${NC}"
    git log --all --pretty=format: --name-only 2>/dev/null | sort | uniq -c | sort -rn | head -5 | while read -r count file; do
        if [ -n "$file" ]; then
            printf "   ${RED}%-40s${NC} %d commits\n" "$file" "$count"
        fi
    done
    echo ""
    
    # TODOs and FIXMEs
    local todos=$(grep -rn "TODO\|FIXME\|XXX\|HACK" --include="*.sh" --include="*.js" --include="*.py" --include="*.ts" --include="*.java" --include="*.c" --include="*.cpp" . 2>/dev/null | grep -v ".git" | wc -l)
    if [ "$todos" -gt 0 ]; then
        echo -e "   ${RED}⚠️  Technical Debt:${NC}"
        echo -e "      Found $todos TODO/FIXME/XXX/HACK comments"
        echo -e "      ${YELLOW}Recommendation: Address these before deployment${NC}"
    else
        echo -e "   ${GREEN}✓ No obvious technical debt markers found${NC}"
    fi
    echo ""
    
    # Velocity prediction
    echo -e "${YELLOW}[6] VELOCITY PREDICTION${NC}"
    
    # Calculate average commits per day over last 30 days
    local recent_commits=$(git log --since="30 days ago" --format="%ci" 2>/dev/null | wc -l)
    local daily_avg=0
    if [ "$recent_commits" -gt 0 ]; then
        daily_avg=$((recent_commits * 10 / 30))
        daily_avg_float=$(echo "scale=1; $recent_commits / 30" | bc 2>/dev/null || echo "$((recent_commits / 30))")
    fi
    
    echo -e "   ${CYAN}Commits (last 30 days):${NC} $recent_commits"
    echo -e "   ${CYAN}Daily Average:${NC}         ~$daily_avg_float commits/day"
    
    if [ "$recent_commits" -gt 50 ]; then
        echo -e "   ${GREEN}✓ High velocity - Team is very active${NC}"
    elif [ "$recent_commits" -gt 20 ]; then
        echo -e "   ${CYAN}✓ Moderate velocity - Steady progress${NC}"
    elif [ "$recent_commits" -gt 0 ]; then
        echo -e "   ${YELLOW}⚠️  Low velocity - Consider increasing activity${NC}"
    else
        echo -e "   ${RED}⚠️  No recent activity - Project may be stalled${NC}"
    fi
    echo ""
    
    # Summary
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${PURPLE}   THRAWN'S ASSESSMENT:${NC}"
    echo ""
    
    # Generate assessment based on findings
    local health_score=100
    
    if [ "$todos" -gt 10 ]; then
        health_score=$((health_score - 20))
    fi
    
    if [ "$recent_commits" -eq 0 ]; then
        health_score=$((health_score - 30))
    fi
    
    if [ "$total_commits" -lt 10 ]; then
        health_score=$((health_score - 10))
    fi
    
    if [ "$health_score" -ge 80 ]; then
        echo -e "   ${GREEN}Repository Health: EXCELLENT ($health_score/100)${NC}"
        echo -e "   ${GREEN}\"Your team's tactics are impressive.\"${NC}"
    elif [ "$health_score" -ge 60 ]; then
        echo -e "   ${CYAN}Repository Health: GOOD ($health_score/100)${NC}"
        echo -e "   ${CYAN}\"Acceptable, but there is room for improvement.\"${NC}"
    elif [ "$health_score" -ge 40 ]; then
        echo -e "   ${YELLOW}Repository Health: FAIR ($health_score/100)${NC}"
        echo -e "   ${YELLOW}\"I recommend addressing the weak points.\"${NC}"
    else
        echo -e "   ${RED}Repository Health: POOR ($health_score/100)${NC}"
        echo -e "   ${RED}\"This repository requires immediate attention.\"${NC}"
    fi
    
    echo ""
    echo -e "${PURPLE}   \"$(random_thrawn_quote)\"${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo ""
}

# Main command router
case "${1:-help}" in
    repo)
        cmd_repo
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        echo -e "${PURPLE}THRAWN: Unknown command '$1'${NC}"
        echo -e "${PURPLE}$(random_thrawn_quote)${NC}"
        echo ""
        show_help
        exit 1
        ;;
esac
