#!/bin/bash
# ==============================================================================
# TARKIN - The Deployment Weapon
# ==============================================================================
# Grand Moff Tarkin oversees deployments and branch destruction.
# ==============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ASSETS_DIR="$(dirname "$SCRIPT_DIR")/assets/ascii"

# Colors
RED='\033[0;31m'
BOLD_RED='\033[1;31m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Tarkin quotes
TARKIN_QUOTES=(
    "Fear will keep the users in line."
    "I am altering the deal. Pray I do not alter it further."
    "This station is now the ultimate power in the universe."
    "The Empire has no need of traitors."
    "When I assumed command of this station, I promised results."
    "You may fire when ready."
    "This will be a day long remembered."
)

random_tarkin_quote() {
    echo "${TARKIN_QUOTES[$RANDOM % ${#TARKIN_QUOTES[@]}]}"
}

show_help() {
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${BOLD_RED}                    GRAND MOFF TARKIN                ${NC}"
    echo -e "${CYAN}                    Deployment Commander               ${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo ""
    echo -e "${YELLOW}Usage:${NC} tarkin <command> [options]"
    echo ""
    echo -e "${YELLOW}Commands:${NC}"
    echo "  deploy <branch>   Atomic deployment simulation"
    echo "  planet <branch>   Destroy a branch (force delete)"
    echo "  help              Show this help message"
    echo ""
    echo -e "${RED}\"${BOLD_RED}$(random_tarkin_quote)${RED}\"${NC}"
}

cmd_deploy() {
    local branch="${1:-}"
    
    if [ -z "$branch" ]; then
        echo -e "${RED}TARKIN: You must specify a branch to deploy.${NC}"
        echo -e "${RED}\"$(random_tarkin_quote)\"${NC}"
        echo ""
        echo -e "${YELLOW}Usage: tarkin deploy <branch>${NC}"
        exit 1
    fi
    
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${BOLD_RED}              DEATH STAR DEPLOYMENT SEQUENCE         ${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo ""
    
    if [ ! -d ".git" ]; then
        echo -e "${RED}TARKIN: This is not a git repository. Incompetence!${NC}"
        exit 1
    fi
    
    # Check if branch exists
    if ! git rev-parse --verify "$branch" >/dev/null 2>&1; then
        echo -e "${RED}TARKIN: Branch '$branch' does not exist.${NC}"
        echo -e "${RED}\"$(random_tarkin_quote)\"${NC}"
        exit 1
    fi
    
    echo -e "${CYAN}   Target: ${YELLOW}$branch${NC}"
    echo -e "${CYAN}   Initiating deployment sequence...${NC}"
    echo ""
    
    # Deployment simulation
    local steps=(
        "Checking out branch '$branch'..."
        "Running pre-deployment tests..."
        "Building assets..."
        "Compressing resources..."
        "Uploading to production servers..."
        "Clearing cache..."
        "Restarting services..."
        "Verifying deployment..."
    )
    
    for step in "${steps[@]}"; do
        echo -e "   ${CYAN}[DEPLOY]${NC} $step"
        sleep 0.3
    done
    
    echo ""
    echo -e "${GREEN}   ✓ Deployment simulation complete!${NC}"
    echo ""
    echo -e "${RED}╔═══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${RED}║${NC}  ${BOLD_RED}⚡ DEPLOYMENT READY ⚡${NC}"
    echo -e "${RED}║${NC}"
    echo -e "${RED}║${NC}  ${YELLOW}\"$(random_tarkin_quote)\"${NC}"
    echo -e "${RED}║${NC}"
    echo -e "${RED}║${NC}  ${CYAN}To execute actual deployment:${NC}"
    echo -e "${RED}║${NC}  ${YELLOW}git checkout $branch && git pull origin $branch${NC}"
    echo -e "${RED}╚═══════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

cmd_planet() {
    local branch="${1:-}"
    
    if [ -z "$branch" ]; then
        echo -e "${RED}TARKIN: You must specify a branch to destroy.${NC}"
        echo -e "${RED}\"I am altering the deal. Pray I do not alter it further.\"${NC}"
        echo ""
        echo -e "${YELLOW}Usage: tarkin planet <branch>${NC}"
        exit 1
    fi
    
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${BOLD_RED}              SUPERLASER TARGETING SYSTEM            ${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo ""
    
    if [ ! -d ".git" ]; then
        echo -e "${RED}TARKIN: This is not a git repository.${NC}"
        exit 1
    fi
    
    # Check if branch exists
    if ! git rev-parse --verify "$branch" >/dev/null 2>&1; then
        echo -e "${RED}TARKIN: Branch '$branch' does not exist. Already destroyed?${NC}"
        exit 1
    fi
    
    # Protect main branches
    local protected_branches=("main" "master" "operational" "production")
    for protected in "${protected_branches[@]}"; do
        if [ "$branch" == "$protected" ]; then
            echo -e "${RED}⚠️  WARNING: '$branch' is a protected branch!${NC}"
            echo -e "${RED}   Even the Death Star has limitations.${NC}"
            echo ""
            read -p "   Are you ABSOLUTELY sure? Type 'deathstar' to confirm: " confirm
            if [ "$confirm" != "deathstar" ]; then
                echo -e "${CYAN}   Targeting aborted.${NC}"
                exit 0
            fi
        fi
    done
    
    echo -e "${RED}   Target locked: ${YELLOW}$branch${NC}"
    echo ""
    echo -e "${CYAN}   Charging superlaser...${NC}"
    sleep 0.5
    echo -e "${CYAN}   [=====>          ] 25%${NC}"
    sleep 0.3
    echo -e "${CYAN}   [==========>     ] 50%${NC}"
    sleep 0.3
    echo -e "${CYAN}   [===============>] 75%${NC}"
    sleep 0.3
    echo -e "${CYAN}   [================] 100%${NC}"
    sleep 0.5
    echo ""
    echo -e "${BOLD_RED}   🔥 SUPERLASER FIRED! 🔥${NC}"
    echo ""
    
    # Actually delete the branch
    git branch -D "$branch" 2>/dev/null
    local result=$?
    
    if [ $result -eq 0 ]; then
        echo -e "${GREEN}   ✓ Branch '$branch' has been destroyed!${NC}"
        echo ""
        echo -e "${RED}╔═══════════════════════════════════════════════════════════╗${NC}"
        echo -e "${RED}║${NC}  ${BOLD_RED}💥 PLANET DESTROYED 💥${NC}"
        echo -e "${RED}║${NC}"
        echo -e "${RED}║${NC}  ${YELLOW}\"I am altering the deal. Pray I do not alter it further.\"${NC}"
        echo -e "${RED}║${NC}"
        echo -e "${RED}║${NC}  ${CYAN}Branch '$branch' is now space dust.${NC}"
        echo -e "${RED}╚═══════════════════════════════════════════════════════════╝${NC}"
    else
        echo -e "${RED}   Failed to delete branch. It may be your current branch.${NC}"
        echo -e "${YELLOW}   Switch branches first: git checkout main${NC}"
    fi
    echo ""
}

# Main command router
case "${1:-help}" in
    deploy)
        cmd_deploy "$2"
        ;;
    planet)
        cmd_planet "$2"
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        echo -e "${RED}TARKIN: Unknown command '$1'${NC}"
        echo -e "${RED}$(random_tarkin_quote)${NC}"
        echo ""
        show_help
        exit 1
        ;;
esac
