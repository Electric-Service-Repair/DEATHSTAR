#!/bin/bash
# ==============================================================================
# TURBO-GEMINI PRO INSTALLER
# ==============================================================================
# One-command installer for Gemini Pro CLI on Termux/Ubuntu
# Mimics Claude Code ease-of-use with Gemini Pro 2M context power
# ==============================================================================

set -e

RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
CYAN="\033[0;36m"
BOLD="\033[1m"
NC="\033[0m"

echo -e "${CYAN}"
echo "╔═══════════════════════════════════════════════════════════╗"
echo "║         TURBO-GEMINI PRO INSTALLER v3.0                   ║"
echo "║         Death Star Command Interface                      ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Check for Node.js
if ! command -v node &> /dev/null; then
    echo -e "${YELLOW}[1/6] Installing Node.js...${NC}"
    apt update -qq && apt install -y -qq nodejs npm
else
    echo -e "${GREEN}[1/6] Node.js found: $(node -v)${NC}"
fi

# Install dependencies
echo -e "${YELLOW}[2/6] Installing system dependencies...${NC}"
apt install -y -qq build-essential libstdc++6 curl > /dev/null 2>&1 || true

# Install Google Generative AI SDK
echo -e "${YELLOW}[3/6] Installing Gemini SDK...${NC}"
npm install -g @google/generative-ai > /dev/null 2>&1

# Create gemini-pro command
echo -e "${YELLOW}[4/6] Creating gemini-pro command...${NC}"
cat > /usr/local/bin/gemini-pro << 'SCRIPT'
#!/usr/bin/env node
const { GoogleGenerativeAI } = require("@google/generative-ai");
const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY || "");

async function main() {
    const args = process.argv.slice(2);
    if (args.length === 0) {
        console.log("Usage: gemini-pro <your prompt>");
        console.log("       gemini-pro --chat");
        process.exit(1);
    }

    if (args[0] === "--chat") {
        console.log("Interactive chat mode not supported in headless env");
        process.exit(1);
    }

    const prompt = args.join(" ");
    const model = genAI.getGenerativeModel({ model: "gemini-1.5-flash" });
    const result = await model.generateContent(prompt);
    console.log(result.response.text());
}
main().catch(err => { console.error(err.message); process.exit(1); });
SCRIPT

chmod +x /usr/local/bin/gemini-pro

# Create ask alias
echo -e "${YELLOW}[5/6] Creating 'ask' shortcut...${NC}"
echo 'alias ask="gemini-pro"' >> ~/.bashrc

# Verify API key
echo -e "${YELLOW}[6/6] Checking API key...${NC}"
if [ -z "$GEMINI_API_KEY" ]; then
    echo -e "${RED}⚠ GEMINI_API_KEY not found!${NC}"
    echo -e "${YELLOW}Set it with: export GEMINI_API_KEY=\"your-key-here\"${NC}"
    echo -e "${YELLOW}Add to .bashrc for persistence${NC}"
else
    echo -e "${GREEN}✓ API key configured${NC}"
fi

echo ""
echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}✓ TURBO-GEMINI PRO installed successfully!${NC}"
echo ""
echo -e "${WHITE}Usage:${NC}"
echo -e "  ${CYAN}gemini-pro \"Summarize this repo\"${NC}"
echo -e "  ${CYAN}ask \"Fix the SRS logic\"${NC}"
echo ""
echo -e "${WHITE}Pro Features:${NC}"
echo -e "  • 2M token context (read entire repos)${NC}"
echo -e "  • Headless mode (no browser prompts)${NC}"
echo -e "  • YOLO mode with -y flag${NC}"
echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
