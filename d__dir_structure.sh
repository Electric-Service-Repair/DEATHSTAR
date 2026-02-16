## the script that started it all
#!/bin/bash

# ------------------------------------------------------------------
# __DIR_FOUNDATION__
# The Dark Side Directory Hardening Protocol
# ------------------------------------------------------------------

# 1. Navigate to Home
cd ~/ || { echo "CRITICAL FAILURE: CANNOT NAVIGATE TO SECTOR HOME"; exit 1; }

# 2. The Intro
echo "----------------------------------------------------------------"
echo "Welcome to the DARK SIDE!!"
echo "THIS IS LORD VADER."
echo "YOUR COMMAND AWAITS."
echo "----------------------------------------------------------------"
echo ""
echo "DEATH STAR WHATS YOUR LOCATION... CONFIRM:"
echo "1. YES (Proceed)"
echo "2. NO (Abort)"
echo "3. UNSURE (Diagnostics)"
echo ""
read -p "ENTER SELECTION [1-3]: " location_confirm

if [[ "$location_confirm" == "1" ]]; then
    echo ""
    echo "AH YES, SYSTEMS ONLINE."
    echo ""
    echo "HARDEN DEATHSTAR {HOME DIR: $HOME}?"
    echo "1. YES (Execute Construction)"
    echo "2. NO (Leave Systems Vulnerable)"
    echo "3. UNSURE"
    echo ""
    read -p "AWAITING COMMAND [1-3]: " harden_confirm

    if [[ "$harden_confirm" == "1" ]]; then
        echo ""
        echo "SUPERB, LOADING DEATH STAR..."
        sleep 1
        echo "INITIALIZING STRUCTURAL INTEGRITY FIELDS..."
        
        # --- THE CONSTRUCTION (The "Awesome" Structure) ---
        
        # Base XDG Directories
        mkdir -p .config .local/bin .local/share .local/state .cache
        echo ">> XDG Base Standards: [ONLINE]"

        # Development Hub
        mkdir -p dev/work dev/personal dev/oss dev/scratch
        echo ">> Development Sectors (Work, Personal, OSS, Scratch): [CONSTRUCTED]"

        # Knowledge & Assets
        mkdir -p docs/finance docs/notes docs/manuals
        mkdir -p media/images media/video media/audio
        echo ">> Archives & Media Vaults: [SECURE]"

        # Transient & Backup
        mkdir -p dl tmp backups
        echo ">> Waste Disposal & Backup Systems: [OPERATIONAL]"

        # Permissions Hardening (The actual "Hardening")
        chmod 700 .ssh 2>/dev/null
        chmod 700 backups
        echo ">> Security Shields (.ssh, backups): [MAXIMUM]"

        echo ""
        echo "----------------------------------------------------------------"
        echo "THE DEATH STAR IS FULLY OPERATIONAL."
        echo "DIRECTORY STRUCTURE COMPLETE."
        echo "DO NOT FAIL ME AGAIN."
        echo "----------------------------------------------------------------"

    elif [[ "$harden_confirm" == "2" ]]; then
        echo "DISAPPOINTING. THE REBEL ALLIANCE WILL FIND YOU EASILY."
    else
        echo "HESITATION BETRAYS YOU. ABORTING."
    fi

elif [[ "$location_confirm" == "2" ]]; then
    echo "SIGNAL LOST. RETURN TO YOUR POST."
else
    echo "CONFUSION IS A WEAKNESS. SYSTEM HALTED."
fi
