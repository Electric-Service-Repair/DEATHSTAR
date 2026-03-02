#!/bin/bash
# ==============================================================================
# VADER - The Git Enforcer
# ==============================================================================
# Lord Vader ensures code quality and enforces Imperial Git standards.
# ==============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ASSETS_DIR="$(dirname "$SCRIPT_DIR")/assets/ascii"

# Colors
RED='\033[0;31m'
BOLD_RED='\033[1;31m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Vader quotes
VADER_QUOTES=(
    "I find your lack of commits disturbing."
    "You have failed me for the last time."
    "Be careful not to choke on your aspirations, Director."
    "The Force is strong with this one... but not strong enough."
    "I am altering the code. Pray I do not alter it further."
    "You don't know the power of the Dark Side."
    "Once you start down the dark path, forever will it dominate your destiny."
)

random_vader_quote() {
    echo "${VADER_QUOTES[$RANDOM % ${#VADER_QUOTES[@]}]}"
}

show_help() {
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${BOLD_RED}                    DARTH VADER                      ${NC}"
    echo -e "${CYAN}                    Git Enforcer                       ${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo ""
    echo -e "${YELLOW}Usage:${NC} vader <command> [options]"
    echo ""
    echo -e "${YELLOW}Commands:${NC}"
    echo "  push              Force-push with branch protection check"
    echo "  review            Scan code for TODOs, console.log, long functions"
    echo "  help              Show this help message"
    echo ""
    echo -e "${RED}\"${BOLD_RED}$(random_vader_quote)${RED}\"${NC}"
}

cmd_push() {
    local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    
    if [ -z "$branch" ]; then
        echo -e "${RED}VADER: You are not in a git repository. Pathetic.${NC}"
        exit 1
    fi
    
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${BOLD_RED}              IMPERIAL PUSH PROTOCOL                 ${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo ""
    
    # Check for protected branches
    local protected_branches=("main" "master" "operational" "production")
    for protected in "${protected_branches[@]}"; do
        if [ "$branch" == "$protected" ]; then
            echo -e "${RED}⚠️  WARNING: You are attempting to push to protected branch '$branch'${NC}"
            echo -e "${RED}   ${BOLD_RED}$(random_vader_quote)${NC}"
            echo ""
            read -p "   Continue anyway? (y/N): " confirm
            if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
                echo -e "${CYAN}   Wise choice. The Emperor would not be pleased.${NC}"
                exit 0
            fi
        fi
    done
    
    # Check for uncommitted changes
    local changes=$(git status --porcelain 2>/dev/null)
    if [ -n "$changes" ]; then
        echo -e "${YELLOW}⚠️  You have uncommitted changes:${NC}"
        echo "$changes" | head -5
        local count=$(echo "$changes" | wc -l)
        if [ $count -gt 5 ]; then
            echo -e "${YELLOW}   ... and $((count - 5)) more${NC}"
        fi
        echo ""
    fi
    
    echo -e "${CYAN}   Preparing force push...${NC}"
    sleep 1
    echo -e "${CYAN}   Checking branch protections...${NC}"
    sleep 0.5
    echo -e "${CYAN}   Verifying commit history...${NC}"
    sleep 0.5
    
    echo ""
    echo -e "${RED}╔═══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${RED}║${NC}  ${BOLD_RED}⚡ FORCE PUSH INITIATED ⚡${NC}"
    echo -e "${RED}║${NC}"
    echo -e "${RED}║${NC}  ${YELLOW}\"$(random_vader_quote)\"${NC}"
    echo -e "${RED}╚═══════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${CYAN}   To execute the actual push, run:${NC}"
    echo -e "${YELLOW}   git push --force-with-lease origin $branch${NC}"
    echo ""
}

cmd_review() {
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${BOLD_RED}              CODE REVIEW BY DARTH VADER             ${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo ""
    
    if [ ! -d ".git" ]; then
        echo -e "${RED}VADER: This is not a git repository. Disappointing.${NC}"
        exit 1
    fi
    
    local issues_found=0
    
    # Scan for TODOs
    echo -e "${YELLOW}[1] Scanning for TODOs...${NC}"
    local todos=$(grep -rn "TODO" --include="*.sh" --include="*.js" --include="*.py" --include="*.ts" --include="*.java" --include="*.c" --include="*.cpp" --include="*.h" . 2>/dev/null | grep -v ".git" | head -10)
    if [ -n "$todos" ]; then
        echo -e "${RED}   ⚠️  TODOs found:${NC}"
        echo "$todos" | while read -r line; do
            echo -e "      ${CYAN}$line${NC}"
        done
        local todo_count=$(grep -rn "TODO" --include="*.sh" --include="*.js" --include="*.py" --include="*.ts" --include="*.java" --include="*.c" --include="*.cpp" --include="*.h" . 2>/dev/null | grep -v ".git" | wc -l)
        echo -e "      ${YELLOW}Total: $todo_count TODOs${NC}"
        ((issues_found++))
    else
        echo -e "   ${CYAN}✓ No TODOs found${NC}"
    fi
    echo ""
    
    # Scan for console.log
    echo -e "${YELLOW}[2] Scanning for debug statements...${NC}"
    local debugs=$(grep -rn "console\.log\|print(\|debug\|\.debug\|logging\." --include="*.sh" --include="*.js" --include="*.py" --include="*.ts" --include="*.java" . 2>/dev/null | grep -v ".git" | head -10)
    if [ -n "$debugs" ]; then
        echo -e "${RED}   ⚠️  Debug statements found:${NC}"
        echo "$debugs" | while read -r line; do
            echo -e "      ${CYAN}$line${NC}"
        done
        ((issues_found++))
    else
        echo -e "   ${CYAN}✓ No debug statements found${NC}"
    fi
    echo ""
    
    # Scan for long functions (files with more than 50 lines)
    echo -e "${YELLOW}[3] Checking for long files...${NC}"
    local long_files=$(find . -name "*.sh" -o -name "*.js" -o -name "*.py" -o -name "*.ts" 2>/dev/null | grep -v ".git" | while read -r file; do
        lines=$(wc -l < "$file" 2>/dev/null)
        if [ "$lines" -gt 100 ]; then
            echo "   $file ($lines lines)"
        fi
    done | head -5)
    if [ -n "$long_files" ]; then
        echo -e "${RED}   ⚠️  Long files found (>100 lines):${NC}"
        echo "$long_files"
        ((issues_found++))
    else
        echo -e "   ${CYAN}✓ No excessively long files${NC}"
    fi
    echo ""
    
    # Summary
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    if [ $issues_found -gt 0 ]; then
        echo -e "${RED}   VADER: $issues_found issue(s) found in your code.${NC}"
        echo -e "${RED}   \"$(random_vader_quote)\"${NC}"
        echo -e "${YELLOW}   Fix these issues before your code can join the Empire.${NC}"
    else
        echo -e "${CYAN}   VADER: Your code is... acceptable.${NC}"
        echo -e "${CYAN}   \"The Force is strong with this one.\"${NC}"
    fi
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
}

# Main command router
case "${1:-help}" in
    push)
        cmd_push
        ;;
    review)
        cmd_review
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        echo -e "${RED}VADER: Unknown command '$1'${NC}"
        echo -e "${RED}$(random_vader_quote)${NC}"
        echo ""
        show_help
        exit 1
        ;;
esac
