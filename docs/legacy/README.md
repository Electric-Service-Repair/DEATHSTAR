# DEATHSTAR CLI

```
                          ..::::::::::..
                      .::'              `::.
                   .::'                    `::.
                 .::'                        `::.
               .::'                            `::.
              ::'                                `::.
            .::'                                    `::.
           .::'                                        `::.
          ::'                                              `::.
         ::'                                                  `::.
        ::'                                                      `::.
       ::'                                                          `::.
      ::'                                                              `::.
     ::'                                                                  `::.
    ::'                                                                      `::.
   ::'                                                                          `::.
  ::'                                                                              `::.
 ::'                                                                                  `::.
::'                                                                                      `::.
::                                                                                        ::
::                                                                                        ::
::'                                                                                      `::.
 ::'                                                                                  `::.
  ::'                                                                              `::.
   ::'                                                                          `::.
    ::'                                                                      `::.
     ::'                                                                  `::.
      ::'                                                              `::.
       ::'                                                          `::.
        ::'                                                      `::.
         ::'                                                  `::.
          ::'                                              `::.
           ::'                                          `::.
            `::.                                      .::'
              `::.                                  .::'
               `::.                              .::'
                 `::.                          .::'
                   `::.                      .::'
                     `:::.                .:::'
                        ``:::::::::::::::''

              ╔═══════════════════════════════════════════╗
              ║     THE DEATH STAR CLI SUITE              ║
              ║   Fully Armed and Operational             ║
              ╚═══════════════════════════════════════════╝
```

A complete Star Wars-themed CLI tools suite for developers. Bring the power of the Empire (and the wisdom of the Jedi) to your development workflow.

## Installation

```bash
# Clone or navigate to the DEATHSTAR directory
cd /data/data/com.termux/files/home/__The_Galaxy__/DEATHSTAR

# Make the main script executable
chmod +x deathstar

# (Optional) Add to your PATH
export PATH="$PATH:/data/data/com.termux/files/home/__The_Galaxy__/DEATHSTAR"

# Or create an alias in your ~/.bashrc or ~/.zshrc
alias deathstar='/data/data/com.termux/files/home/__The_Galaxy__/DEATHSTAR/deathstar'
```

## Quick Start

```bash
# Show help
./deathstar help

# Check system status
./deathstar status

# Get some wisdom
./deathstar yoda wisdom
```

## Commands Overview

### Main Commands

| Command | Description |
|---------|-------------|
| `deathstar status` | Show Death Star ASCII + system health |
| `deathstar launch <project>` | Quick-start new project with template |

### Imperial Subcommands

| Command | Character | Purpose |
|---------|-----------|---------|
| `vader` | Darth Vader | Git enforcer |
| `tarkin` | Grand Moff Tarkin | Deployment weapon |
| `yoda` | Master Yoda | Wise advisor |
| `r2d2` | R2-D2 | System diagnostics |
| `thrawn` | Grand Admiral Thrawn | Analytics |
| `lightsaber` | Jedi/Sith | Glowing editor |
| `hyperdrive` | Navigation | Folder navigation |
| `palpatine` | Emperor | Prompt enhancer |
| `stormtrooper` | Stormtrooper | Fuzzy finder |

---

## Detailed Command Reference

### 🌑 DEATHSTAR (Main Hub)

The central command for accessing all Imperial tools.

```bash
# Show full status with ASCII art
./deathstar status

# Launch a new project
./deathstar launch my-awesome-project

# Access subcommands
./deathstar vader push
./deathstar yoda wisdom
```

---

### ⚔️ VADER (Git Enforcer)

Lord Vader ensures code quality and enforces Imperial Git standards.

```bash
# Force push with branch protection warnings
./deathstar vader push

# Code review - scan for TODOs, console.log, long functions
./deathstar vader review

# Show help
./deathstar vader help
```

**Features:**
- Protected branch warnings (main, master, operational)
- Uncommitted changes detection
- TODO/FIXME scanning
- Debug statement detection
- Long file warnings

**Vader says:** *"I find your lack of commits disturbing."*

---

### 💥 TARKIN (Deployment Weapon)

Grand Moff Tarkin oversees deployments and branch destruction.

```bash
# Simulate atomic deployment
./deathstar tarkin deploy main

# Destroy a branch (force delete)
./deathstar tarkin planet feature/old-thing

# Show help
./deathstar tarkin help
```

**Features:**
- Deployment simulation with progress
- Branch protection for main/master
- Dramatic superlaser animation
- Tarkin voice lines

**Tarkin says:** *"Fear will keep the users in line."*

---

### 🧙 YODA (Wise Advisor)

Master Yoda provides commit message wisdom and developer tips.

```bash
# Auto-generate commit message from git diff
./deathstar yoda commit

# Get random developer wisdom
./deathstar yoda wisdom

# Show help
./deathstar yoda help
```

**Features:**
- Yoda-style commit message generation
- Developer tips in Yoda speak
- Change analysis (lines added/removed)

**Yoda says:** *"Do or do not, there is no try."*

---

### 🤖 R2-D2 (System Diagnostics)

Your loyal astromech droid for system checks.

```bash
# Full system scan (disk, memory, git status)
./deathstar r2d2 scan

# Play Star Wars beeps
./deathstar r2d2 beep

# Show help
./deathstar r2d2 help
```

**Features:**
- Disk usage with visual bar
- Memory usage analysis
- Git status summary
- System information
- Authentic R2-D2 sounds

**R2-D2 says:** *beep boop whistle*

---

### 📊 THRAWN (Analytics)

Grand Admiral Thrawn analyzes your repository with tactical precision.

```bash
# Full repository analysis
./deathstar thrawn repo

# Show help
./deathstar thrawn help
```

**Features:**
- Commit activity by day of week
- Top contributors analysis
- File type breakdown
- Technical debt detection
- Velocity prediction
- Health score assessment

**Thrawn says:** *"Every artist reveals something unique about themselves in their work."*

---

### ⚔️ LIGHTSABER (Glowing Editor)

Open files with a Jedi lightsaber effect.

```bash
# Open file with green lightsaber (default)
./deathstar lightsaber edit myfile.sh

# Choose lightsaber color
./deathstar lightsaber edit config.json --color=blue
./deathstar lightsaber edit main.py --color=red

# Show available colors
./deathstar lightsaber colors

# Show help
./deathstar lightsaber help
```

**Available Colors:**
- `green` - Jedi Classic (Luke/Yoda)
- `blue` - Jedi Guardian (Obi-Wan/Anakin)
- `red` - Sith Lord (Vader/Sidious)
- `purple` - Mace Windu Special
- `yellow` - Temple Guard
- `cyan` - Ahsoka's White

---

### 🚀 HYPERDRIVE (Navigation)

Navigate to folders with a hyperspace jump animation.

```bash
# Jump to a folder with animation
./deathstar hyperdrive jump src/

# Show current location and nearby directories
./deathstar hyperdrive coords

# Show help
./deathstar hyperdrive help
```

**Features:**
- Hyperspace jump animation
- Starfield effect
- Directory preview
- Navigation coordinates

---

### 👑 PALPATINE (Prompt Enhancer)

Emperor Palpatine enhances your prompts with unlimited power.

```bash
# Enhance a prompt (default: power template)
./deathstar palpatine "Write a sorting algorithm"

# Use specific template
./deathstar palpatine "Explain quantum computing" --template=explain
./deathstar palpatine "Design a logo" --template=creative
./deathstar palpatine "Fix this bug" --template=code

# Show available templates
./deathstar palpatine templates

# Show help
./deathstar palpatine help
```

**Templates:**
- `power` - General purpose with power words
- `detailed` - Comprehensive analysis
- `creative` - Innovative responses
- `code` - Production-ready code
- `explain` - Clear explanations

**Palpatine says:** *"Unlimited power!"*

---

### 🎯 STORMTROOPER (Fuzzy Finder)

Find files with Imperial precision (or miss like a Stormtrooper).

```bash
# Fuzzy search for files
./deathstar stormtrooper find "*.sh"
./deathstar stormtrooper find "config"

# Precision search (exact matching)
./deathstar stormtrooper aim "README.md"

# Show help
./deathstar stormtrooper help
```

**Features:**
- Fuzzy file search
- Exact match mode
- Stormtrooper miss jokes
- File size display

**Stormtrooper says:** *"We missed the target... again."*

---

## Directory Structure

```
DEATHSTAR/
├── deathstar              # Main executable router
├── commands/
│   ├── vader.sh           # Git enforcer
│   ├── tarkin.sh          # Deployment weapon
│   ├── yoda.sh            # Wise advisor
│   ├── r2d2.sh            # System diagnostics
│   ├── thrawn.sh          # Analytics
│   ├── lightsaber.sh      # Glowing editor
│   ├── hyperdrive.sh      # Navigation
│   ├── palpatine.sh       # Prompt enhancer
│   ├── stormtrooper.sh    # Fuzzy finder
│   └── status.sh          # Status display
├── assets/
│   └── ascii/
│       ├── deathstar.txt  # Death Star ASCII
│       ├── vader.txt      # Darth Vader ASCII
│       ├── r2d2.txt       # R2-D2 ASCII
│       ├── yoda.txt       # Yoda ASCII
│       └── stormtrooper.txt # Stormtrooper ASCII
└── README.md              # This file
```

---

## Usage Examples

### Daily Development Workflow

```bash
# Start your day - check system status
./deathstar status

# Review your code before committing
./deathstar vader review

# Generate a commit message
./deathstar yoda commit

# Actually commit (using the suggested message)
git commit -m "Code modified, Much code written"

# Push to remote (with Vader's blessing)
./deathstar vader push

# Deploy to staging
./deathstar tarkin deploy simulation
```

### Project Setup

```bash
# Create a new project
./deathstar launch my-new-app

# Navigate to it
cd my-new-app

# Check analytics
./deathstar thrawn repo
```

### Code Review Session

```bash
# Find all JavaScript files
./deathstar stormtrooper find "*.js"

# Review the codebase
./deathstar vader review

# Get wisdom for refactoring
./deathstar yoda wisdom
```

---

## Customization

### Adding to PATH

Add this to your `~/.bashrc`, `~/.zshrc`, or shell config:

```bash
export DEATHSTAR_PATH="/data/data/com.termux/files/home/__The_Galaxy__/DEATHSTAR"
export PATH="$PATH:$DEATHSTAR_PATH"

# Optional: Create convenient aliases
alias ds='deathstar'
alias dv='deathstar vader'
alias dy='deathstar yoda'
alias dr='deathstar r2d2'
alias dt='deathstar tarkin'
```

### Custom Colors

The CLI uses ANSI color codes. You can modify the color variables in each script:

```bash
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
```

---

## Requirements

- Bash 4.0+
- Git (for git-related commands)
- Standard Unix utilities (grep, find, awk, sed)

### Optional Dependencies

- `nano` or `vim` - For lightsaber edit command
- `df`, `free` - For system diagnostics
- `bc` - For calculations in thrawn

---

## Troubleshooting

### Command not found
```bash
# Make sure scripts are executable
chmod +x deathstar
chmod +x commands/*.sh

# Or use full path
/data/data/com.termux/files/home/__The_Galaxy__/DEATHSTAR/deathstar help
```

### Git commands not working
```bash
# Ensure you're in a git repository
git init
```

### Colors not displaying
```bash
# Ensure your terminal supports ANSI colors
# Try: echo -e "\033[31mRed Text\033[0m"
```

---

## Contributing

The Empire always welcomes new recruits! To contribute:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/NewCommand`)
3. Commit your changes (`deathstar yoda commit`)
4. Push to the branch (`deathstar vader push`)
5. Open a Pull Request

---

## License

This project is licensed under the Imperial License - see the LICENSE file for details.

*"The Force will be with you. Always."*

---

## Version

**Death Star CLI v1.0.0** - Fully Armed and Operational

---

## Acknowledgments

- Star Wars universe created by George Lucas
- Built with ❤️ by the Imperial Engineering Corps
- May the Force be with your code
