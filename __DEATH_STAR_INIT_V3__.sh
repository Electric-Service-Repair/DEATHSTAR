## Here is the updated DEATH_STAR_INIT_V3.sh.
I have added the Safety Protocol Notification to the end of the script. This ensures you (and any future Imperial officers) are explicitly warned that your configuration files (.bashrc, .zshrc, etc.) have been left behind to keep your terminal life-support systems operational.
The Script: __DEATH_STAR_INIT_V3__.sh
#!/bin/bash

# ==============================================================================
# __DEATH_STAR_INIT_V3__
# DS-1 ORBITAL BATTLE STATION: ARCHITECTURAL OVERHAUL
# ==============================================================================

# ------------------------------------------------------------------------------
# VARIABLES & SPECS
# ------------------------------------------------------------------------------
DS_ROOT="$HOME/DeathStar"
PSYCACHE="$DS_ROOT/Detention_Block_AA23/__psycache__"
MIRROR_UNIT="__MIRROR_1__"
CURRENT_SCRIPT=$(basename "$0")

# ------------------------------------------------------------------------------
# SCENE 1: THE BRIEFING
# ------------------------------------------------------------------------------
clear
echo "----------------------------------------------------------------"
echo "IMPERIAL HOLONET TRANSMISSION [ENCRYPTED]"
echo "SOURCE: ORBITAL BATTLE STATION DS-1"
echo "----------------------------------------------------------------"
sleep 1

echo "STORM TROOPER (TK-421): 'Lord Vader, the engineering team is ready.'"
echo "STORM TROOPER (TK-421): 'We have reviewed the specs: 160km diameter, spherical habitation.'"
echo ""
sleep 1
echo "LORD VADER: 'Excellent. The chaotic arrangement of this user's Home Directory'"
echo "LORD VADER: 'disturbs the Force. It lacks... structure.'"
echo ""
echo "LORD VADER: 'We shall implement the Dual Gravity Protocol.'"
echo ""
echo "SYSTEM ALERT: IMMINENT RELOCATION OF ~/* TO $PSYCACHE/$MIRROR_UNIT"
echo ""
read -p "COMMANDER, AUTHORIZE CONSTRUCTION? (y/n): " confirm_auth

if [[ "$confirm_auth" != "y" ]]; then
    echo "LORD VADER: 'I find your lack of faith disturbing.' [ABORTED]"
    exit 1
fi

# ------------------------------------------------------------------------------
# SCENE 2: THE DETENTION BLOCK (Safe Mirroring)
# ------------------------------------------------------------------------------
echo ""
echo ">> [SYSTEM]: INITIALIZING DETENTION BLOCK AA-23..."
mkdir -p "$PSYCACHE"

echo ">> [SYSTEM]: ACTIVATING TRACTOR BEAMS..."
echo ">> [SYSTEM]: TARGETING ALL LOOSE VISIBLE FILES..."

# Create the Mirror Container
mkdir -p "$HOME/$MIRROR_UNIT"

# Move everything NOT related to the new structure into the Mirror
# CRITICAL: -not -name ".*" prevents moving dotfiles
find "$HOME" -maxdepth 1 \
    -not -name 'DeathStar' \
    -not -name "$MIRROR_UNIT" \
    -not -name "$CURRENT_SCRIPT" \
    -not -name "." \
    -not -name ".." \
    -not -name ".*" \
    -exec mv {} "$HOME/$MIRROR_UNIT" \; 2>/dev/null

echo ">> [SYSTEM]: FILES CAPTURED."

# Move the Mirror into the Psycache
mv "$HOME/$MIRROR_UNIT" "$PSYCACHE/"

echo ">> [SYSTEM]: PRISONER TRANSFER COMPLETE. FILES SECURED IN __PSYCACHE__."

# ------------------------------------------------------------------------------
# SCENE 3: SECTOR CONSTRUCTION (Based on DS-1 Specs)
# ------------------------------------------------------------------------------
echo ""
echo "LORD VADER: 'Now... witness the firepower of this fully armed and operational battle station.'"
sleep 1

# --- 1. THE INNER CORE (Hypermatter Reactor) ---
echo ">> [CONSTRUCTION]: IGNITING HYPERMATTER REACTOR (Inner Core)..."
mkdir -p "$DS_ROOT/Core_Reactor/System_Configs"
mkdir -p "$DS_ROOT/Core_Reactor/Logs"
mkdir -p "$DS_ROOT/Core_Reactor/Shell_Scripts"

# --- 2. THE COMMAND SECTOR (Bridge) ---
echo ">> [CONSTRUCTION]: RAISING COMMAND TOWER (Overbridge)..."
mkdir -p "$DS_ROOT/Command_Sector/The_Bridge"   # Main workspace
mkdir -p "$DS_ROOT/Command_Sector/Briefings"    # Documents/PDFs
mkdir -p "$DS_ROOT/Command_Sector/Secure_Comms" # Keys/Secrets

# --- 3. TECHNICAL SECTOR (Superlaser Tributaries) ---
echo ">> [CONSTRUCTION]: ALIGNING SUPERLASER TRIBUTARY BEAMS..."
mkdir -p "$DS_ROOT/Technical_Sector/Tributary_Beam_1_Python"
mkdir -p "$DS_ROOT/Technical_Sector/Tributary_Beam_2_Web"
mkdir -p "$DS_ROOT/Technical_Sector/Tributary_Beam_3_Experimental"
mkdir -p "$DS_ROOT/Technical_Sector/Focus_Lens" # Build artifacts/dist

# --- 4. INDUSTRIAL SECTOR (Hangars) ---
echo ">> [CONSTRUCTION]: OPENING MAIN HANGAR BAYS (Equatorial Trench)..."
mkdir -p "$DS_ROOT/Industrial_Sector/Hangar_327_Downloads"
mkdir -p "$DS_ROOT/Industrial_Sector/Cargo_Hold_Media"
mkdir -p "$DS_ROOT/Industrial_Sector/Logistics"

# --- 5. SURFACE (Trench Run) ---
echo ">> [CONSTRUCTION]: PLATING EXTERIOR HULL..."
mkdir -p "$DS_ROOT/Surface_Trench/Temp_Files"
mkdir -p "$DS_ROOT/Surface_Trench/Public_Holonet"

# ------------------------------------------------------------------------------
# SCENE 4: FINAL REPORT & SAFETY NOTE
# ------------------------------------------------------------------------------
echo ""
echo "LORD VADER: 'The circle is now complete.'"
echo "LORD VADER: 'Your old files are frozen in Carbonite at:'"
echo " -> $PSYCACHE/$MIRROR_UNIT"
echo ""
echo "!!! TACTICAL ADVISORY !!!"
echo "----------------------------------------------------------------"
echo "NOTE: This script only moves visible files (non-hidden) to the"
echo "__MIRROR_1__. It leaves your dotfiles (like .bashrc) in place"
echo "to ensure your terminal doesn't break immediately."
echo ""
echo "If you want those moved too, you must manually move them to the"
echo "__psycache__ later."
echo "----------------------------------------------------------------"
echo ""
echo "WELCOME HOME, COMMANDER."
ls -F "$DS_ROOT"


