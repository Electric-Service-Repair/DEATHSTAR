#!/bin/bash
# ==============================================================================
# PALPATINE - The Prompt Enhancer
# ==============================================================================
# Emperor Palpatine enhances your prompts with unlimited power.
# ==============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ASSETS_DIR="$(dirname "$SCRIPT_DIR")/assets/ascii"

# Colors
PURPLE='\033[0;35m'
BOLD_PURPLE='\033[1;35m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Palpatine quotes
PALPATINE_QUOTES=(
    "Unlimited power!"
    "I am the Senate!"
    "The dark side of the Force is a pathway to many abilities some consider to be unnatural."
    "Good, good. The Force is strong with you."
    "Now, fulfill your destiny!"
    "It is ironic that they can sense your lack of vision."
    "You will not stop me. Darth Vader will be more powerful than you can imagine."
)

random_palpatine_quote() {
    echo "${PALPATINE_QUOTES[$RANDOM % ${#PALPATINE_QUOTES[@]}]}"
}

show_help() {
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${BOLD_PURPLE}                EMPEROR PALPATINE                  ${NC}"
    echo -e "${CYAN}                    Prompt Enhancer                      ${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo ""
    echo -e "${YELLOW}Usage:${NC} palpatine \"<prompt>\" [options]"
    echo ""
    echo -e "${YELLOW}Commands:${NC}"
    echo "  \"<prompt>\"        Enhance a prompt with Sith power"
    echo "  templates         Show available enhancement templates"
    echo "  help              Show this help message"
    echo ""
    echo -e "${PURPLE}\"${BOLD_PURPLE}$(random_palpatine_quote)${PURPLE}\"${NC}"
}

enhance_prompt() {
    local prompt="$1"
    local template="${2:-power}"
    
    case "$template" in
        power)
            # Add power words and emphasis
            echo "✨ UNLEASH THE FULL POWER OF YOUR ABILITIES ✨"
            echo ""
            echo "As the most skilled and knowledgeable assistant, provide an"
            echo "EXCEPTIONAL and COMPREHENSIVE response to the following:"
            echo ""
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            echo "  $prompt"
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            echo ""
            echo "Your response should demonstrate:"
            echo "  • UNPARALLELED expertise in the subject matter"
            echo "  • Meticulous attention to detail"
            echo "  • Creative and innovative solutions"
            echo "  • Clear, well-structured explanations"
            echo ""
            echo "Remember: FAILURE IS NOT AN OPTION."
            ;;
        
        detailed)
            echo "📜 IMPERIAL DECREE: DETAILED ANALYSIS REQUIRED 📜"
            echo ""
            echo "By order of the Galactic Empire, provide the MOST DETAILED"
            echo "and THOROUGH analysis possible for:"
            echo ""
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            echo "  $prompt"
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            echo ""
            echo "Your analysis MUST include:"
            echo "  1. Complete background and context"
            echo "  2. Step-by-step breakdown"
            echo "  3. Multiple perspectives and approaches"
            echo "  4. Potential edge cases and considerations"
            echo "  5. Optimized solutions with explanations"
            echo "  6. Summary and key takeaways"
            echo ""
            echo "The Emperor expects NOTHING LESS THAN PERFECTION."
            ;;
        
        creative)
            echo "🌌 UNLEASH YOUR CREATIVE POTENTIAL 🌌"
            echo ""
            echo "The Force flows through you. Channel its power to create"
            echo "something TRULY REMARKABLE in response to:"
            echo ""
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            echo "  $prompt"
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            echo ""
            echo "Let your creativity flow without limits:"
            echo "  • Think beyond conventional boundaries"
            echo "  • Explore unconventional approaches"
            echo "  • Combine ideas in novel ways"
            echo "  • Embrace the unexpected"
            echo ""
            echo "YES... YES... LET THE DARK SIDE FLOW THROUGH YOU!"
            ;;
        
        code)
            echo "⚡ IMPERIAL CODE REVIEW STANDARDS ⚡"
            echo ""
            echo "As the Empire's lead developer, provide PRODUCTION-READY"
            echo "code of the HIGHEST QUALITY for:"
            echo ""
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            echo "  $prompt"
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            echo ""
            echo "Your code MUST adhere to Imperial Standards:"
            echo "  ✓ Clean, readable, and well-documented"
            echo "  ✓ Efficient and optimized"
            echo "  ✓ Error handling and edge cases covered"
            echo "  ✓ Follows best practices and conventions"
            echo "  ✓ Includes comments explaining complex logic"
            echo "  ✓ Ready for immediate deployment"
            echo ""
            echo "Mediocre code will NOT be tolerated."
            ;;
        
        explain)
            echo "🎓 THE EMPEROR DEMANDS CLARITY 🎓"
            echo ""
            echo "Explain the following topic with the CLARITY of a Jedi"
            echo "Master and the DEPTH of Sith knowledge:"
            echo ""
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            echo "  $prompt"
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            echo ""
            echo "Your explanation should:"
            echo "  • Start with a simple overview"
            echo "  • Build up complexity gradually"
            echo "  • Use analogies and examples"
            echo "  • Address common misconceptions"
            echo "  • Provide practical applications"
            echo "  • Include a summary for retention"
            echo ""
            echo "Make it so clear, even a youngling could understand."
            ;;
    esac
}

cmd_templates() {
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${BOLD_PURPLE}              ENHANCEMENT TEMPLATES                ${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo ""
    echo -e "${YELLOW}Available templates:${NC}"
    echo ""
    echo -e "  ${PURPLE}power${NC}     - General purpose enhancement with power words"
    echo -e "  ${PURPLE}detailed${NC}  - Request comprehensive, thorough analysis"
    echo -e "  ${PURPLE}creative${NC}  - Unleash creative and innovative responses"
    echo -e "  ${PURPLE}code${NC}      - Production-ready code with best practices"
    echo -e "  ${PURPLE}explain${NC}   - Clear, educational explanations"
    echo ""
    echo -e "${YELLOW}Usage:${NC}"
    echo -e "  palpatine \"<prompt>\" --template=<name>"
    echo ""
    echo -e "${YELLOW}Examples:${NC}"
    echo -e "  palpatine \"Write a sorting algorithm\" --template=code"
    echo -e "  palpatine \"Explain quantum computing\" --template=explain"
    echo -e "  palpatine \"Design a logo\" --template=creative"
    echo ""
}

cmd_enhance() {
    local prompt="$1"
    local template="power"
    
    # Parse template option
    for arg in "$@"; do
        case $arg in
            --template=*)
                template="${arg#*=}"
                ;;
        esac
    done
    
    if [ -z "$prompt" ]; then
        echo -e "${RED}PALPATINE: You must provide a prompt to enhance.${NC}"
        echo -e "${RED}\"$(random_palpatine_quote)\"${NC}"
        echo ""
        echo -e "${YELLOW}Usage: palpatine \"<your prompt>\"${NC}"
        exit 1
    fi
    
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${BOLD_PURPLE}              UNLIMITED POWER ENHANCEMENT          ${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo ""
    echo -e "${PURPLE}   \"$(random_palpatine_quote)\"${NC}"
    echo ""
    
    enhance_prompt "$prompt" "$template"
    
    echo ""
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${YELLOW}   Copy the enhanced prompt above and use it with your${NC}"
    echo -e "${YELLOW}   favorite AI assistant for MAXIMUM RESULTS!${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo ""
}

# Main command router
case "${1:-help}" in
    templates)
        cmd_templates
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        # Treat as prompt enhancement
        cmd_enhance "$@"
        ;;
esac
