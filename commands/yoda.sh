#!/bin/bash
# ==============================================================================
# YODA - The Wise Advisor
# ==============================================================================
# Master Yoda provides commit message wisdom and developer tips.
# ==============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ASSETS_DIR="$(dirname "$SCRIPT_DIR")/assets/ascii"

# Colors
GREEN='\033[0;32m'
BOLD_GREEN='\033[1;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Yoda wisdom quotes
YODA_WISDOM=(
    "Do or do not, there is no try."
    "In a dark place we find ourselves, and a little more knowledge lights our way."
    "Patience you must have, my young padawan."
    "The greatest teacher, failure is."
    "When nine hundred years old you reach, look as good you will not."
    "Train yourself to let go of everything you fear to lose."
    "Adventure. Heh. Excitement. Heh. A Jedi craves not these things."
    "Size matters not. Look at me. Judge me by my size, do you?"
    "Luminous beings are we, not this crude matter."
    "The Force will be with you. Always."
    "End of the line, have you come to?"
    "Much to learn, you still have."
    "Fear is the path to the dark side. Fear leads to anger, anger leads to hate, hate leads to suffering."
    "Clear your mind must be."
    "Difficult to see. Always in motion is the future."
)

# Yoda-style transformations for commit messages
to_yoda_speak() {
    local text="$1"
    # Simple transformations to make text sound like Yoda
    text=$(echo "$text" | sed 's/^I am /Am I /g')
    text=$(echo "$text" | sed 's/^We are /Are we /g')
    text=$(echo "$text" | sed 's/ is / be /g')
    text=$(echo "$text" | sed 's/ have / has /g')
    text=$(echo "$text" | sed 's/ will / shall /g')
    text=$(echo "$text" | sed 's/ can / could /g')
    echo "$text"
}

show_help() {
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${BOLD_GREEN}                    MASTER YODA                    ${NC}"
    echo -e "${CYAN}                    Wise Advisor                       ${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo ""
    echo -e "${YELLOW}Usage:${NC} yoda <command> [options]"
    echo ""
    echo -e "${YELLOW}Commands:${NC}"
    echo "  commit            Auto-generate commit message from git diff"
    echo "  wisdom            Random useful dev tip in Yoda speak"
    echo "  help              Show this help message"
    echo ""
    echo -e "${GREEN}\"${BOLD_GREEN}$(echo "${YODA_WISDOM[$RANDOM % ${#YODA_WISDOM[@]}]}")${GREEN}\"${NC}"
}

cmd_commit() {
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${BOLD_GREEN}              YODA'S COMMIT WISDOM                 ${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo ""
    
    if [ ! -d ".git" ]; then
        echo -e "${YELLOW}YODA: Not a git repository, this is.${NC}"
        echo -e "${YELLOW}      Initialize one, you must.${NC}"
        exit 1
    fi
    
    # Get staged changes
    local staged=$(git diff --cached --name-only 2>/dev/null)
    
    if [ -z "$staged" ]; then
        echo -e "${YELLOW}YODA: No staged changes, I sense.${NC}"
        echo -e "${YELLOW}      Stage files first, you must:${NC}"
        echo -e "${CYAN}      git add <files>${NC}"
        exit 1
    fi
    
    echo -e "${GREEN}   Files staged for commit:${NC}"
    echo "$staged" | while read -r file; do
        echo -e "      ${CYAN}• $file${NC}"
    done
    echo ""
    
    # Analyze changes
    local added=$(git diff --cached --numstat 2>/dev/null | awk '{added+=$1} END {print added}')
    local removed=$(git diff --cached --numstat 2>/dev/null | awk '{removed+=$2} END {print removed}')
    
    echo -e "${GREEN}   Changes detected:${NC}"
    echo -e "      ${CYAN}+ $added lines added${NC}"
    echo -e "      ${YELLOW}- $removed lines removed${NC}"
    echo ""
    
    # Generate commit message based on changed files
    local commit_msg=""
    local file_types=$(echo "$staged" | sed 's/.*\.//' | sort | uniq)
    
    for ext in $file_types; do
        case "$ext" in
            sh)
                commit_msg="$commit_msg Script updated, "
                ;;
            js|ts)
                commit_msg="$commit_msg Code modified, "
                ;;
            py)
                commit_msg="$commit_msg Python changed, "
                ;;
            md|txt)
                commit_msg="$commit_msg Documentation written, "
                ;;
            css|scss)
                commit_msg="$commit_msg Styles adjusted, "
                ;;
            html)
                commit_msg="$commit_msg Structure altered, "
                ;;
            json|yaml|yml)
                commit_msg="$commit_msg Configuration updated, "
                ;;
            *)
                commit_msg="$commit_msg Files changed, "
                ;;
        esac
    done
    
    # Remove trailing comma and space
    commit_msg=$(echo "$commit_msg" | sed 's/, $//')
    
    # Convert to Yoda speak
    commit_msg=$(to_yoda_speak "$commit_msg")
    
    # Add context
    if [ "$added" -gt 100 ]; then
        commit_msg="$commit_msg - Much code written"
    elif [ "$removed" -gt 50 ]; then
        commit_msg="$commit_msg - Cleanup performed"
    fi
    
    echo -e "${GREEN}╔═══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║${NC}  ${BOLD_GREEN}YODA'S SUGGESTED COMMIT MESSAGE:${NC}"
    echo -e "${GREEN}║${NC}"
    echo -e "${GREEN}║${NC}  ${YELLOW}\"$commit_msg\"${NC}"
    echo -e "${GREEN}║${NC}"
    echo -e "${GREEN}║${NC}  ${CYAN}To commit with this message:${NC}"
    echo -e "${GREEN}║${NC}  ${YELLOW}git commit -m \"$commit_msg\"${NC}"
    echo -e "${GREEN}╚═══════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${GREEN}YODA: \"$(echo "${YODA_WISDOM[$RANDOM % ${#YODA_WISDOM[@]}]}")\"${NC}"
    echo ""
}

cmd_wisdom() {
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${BOLD_GREEN}              YODA'S DEVELOPER WISDOM              ${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo ""
    
    # Select random wisdom
    local wisdom_idx=$((RANDOM % ${#YODA_WISDOM[@]}))
    local wisdom="${YODA_WISDOM[$wisdom_idx]}"
    
    # Developer-specific tips
    local dev_tips=(
        "Commit often, you should. Small commits, easier to revert."
        "Test before deploy, you must. Production broken, nobody happy."
        "Read the error message, you should. The answer, it contains."
        "Version control everything, hmm. Backup your work, you must."
        "Clean code, clean mind. Refactor regularly, you should."
        "Documentation write, future-you will thank you."
        "One thing at a time, focus. Multitasking, the path to bugs is."
        "Ask for help when stuck, you should. Pride, a Jedi trait is not."
        "Learn from mistakes, you must. Failure, the best teacher is."
        "Simple solutions, the best solutions. Over-engineering, avoid."
        "Comments in code, leave them. Future developers, confused will be."
        "Git branch before big changes, you should. Safety net, it provides."
        "Code review accept with open mind. Improve your skills, it will."
        "Automate repetitive tasks, you should. Time, valuable is."
        "Understand the problem before solving, hmm. Rush, do not."
    )
    
    local tip_idx=$((RANDOM % ${#dev_tips[@]}))
    local dev_tip="${dev_tips[$tip_idx]}"
    
    echo -e "${GREEN}   ╭─────────────────────────────────────────────────────────╮${NC}"
    echo -e "${GREEN}   │${NC}  ${YELLOW}YODA SAYS:${NC}"
    echo -e "${GREEN}   │${NC}"
    echo -e "${GREEN}   │${NC}  ${BOLD_GREEN}\"$wisdom\"${NC}"
    echo -e "${GREEN}   │${NC}"
    echo -e "${GREEN}   │${NC}  ${CYAN}Developer Tip:${NC}"
    echo -e "${GREEN}   │${NC}  $dev_tip"
    echo -e "${GREEN}   │${NC}"
    echo -e "${GREEN}   ╰─────────────────────────────────────────────────────────╯${NC}"
    echo ""
}

# Main command router
case "${1:-help}" in
    commit)
        cmd_commit
        ;;
    wisdom)
        cmd_wisdom
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        echo -e "${YELLOW}YODA: Unknown command '$1', hmm.${NC}"
        echo -e "${YELLOW}$(echo "${YODA_WISDOM[$RANDOM % ${#YODA_WISDOM[@]}]}")${NC}"
        echo ""
        show_help
        exit 1
        ;;
esac
