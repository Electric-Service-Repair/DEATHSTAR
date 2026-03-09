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

## 1. Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/Electric-Service-Repair/DEATHSTAR.git
   cd DEATHSTAR
   ```

2. **Make the main script executable**:
   ```bash
   chmod +x deathstar
   chmod +x commands/*.sh
   ```

3. **(Recommended) Add it to your PATH**:
   
   - **Temporary (current session)**:
     ```bash
     export PATH="$PATH:$(pwd)"
     ```

   - **Permanent**: Add to your `~/.bashrc`, `~/.zshrc`, or equivalent shell config file:
     ```bash
     export PATH="$PATH:/path/to/DEATHSTAR"   # replace with your actual full path
     ```

     Or use convenient aliases:
     ```bash
     alias ds='deathstar'
     alias dv='deathstar vader'
     alias dy='deathstar yoda'
     alias dr='deathstar r2d2'
     alias dt='deathstar tarkin'
     # ... add more as desired
     ```

   After editing, reload your shell:
   ```bash
   source ~/.bashrc   # or ~/.zshrc
   ```

**Requirements**: Bash 4.0+, Git (for Git commands), standard Unix tools. Optional: `nano`/`vim`, `df`/`free`, `bc`, etc., for full features.

## 2. Quick Start

Run these to get going right away:

```bash
deathstar help          # Shows main help and command overview
deathstar status        # Displays epic Death Star ASCII + system/fleet status
deathstar yoda wisdom   # Get random developer wisdom in Yoda-speak
```

## 3. Main Commands & Subcommands

Everything routes through `deathstar <subcommand> [options] [args]`.

### 🌑 **Status**
- `deathstar status` — Shows Death Star art + quick system health overview.

### ⚔️ **Vader (Git Enforcer)**
- `deathstar vader push` — Protected push with warnings.
- `deathstar vader review` — Scans for TODOs, debug logs, long functions, etc.
- `deathstar vader help`

### 💥 **Tarkin (Deployment Orchestrator)**
- `deathstar tarkin deploy main` — Simulated deployment with superlaser animation.
- `deathstar tarkin planet old-branch` — Force-deletes a branch dramatically.
- `deathstar tarkin help`

### 🧙 **Yoda (Wise Advisor)**
- `deathstar yoda commit` — Auto-generates Yoda-style commit message from diff.
- `deathstar yoda wisdom` — Random dev tips/quotes.
- `deathstar yoda help`

### 🤖 **R2-D2 (System Diagnostics)**
- `deathstar r2d2 scan` — Disk, memory, Git status summary + visuals.
- `deathstar r2d2 beep` — Plays Star Wars R2-D2 beeps.
- `deathstar r2d2 help`

### 📊 **Thrawn (Repo Analytics)**
- `deathstar thrawn repo` — Commit stats, contributors, file types, health score.
- `deathstar thrawn help`

### ⚔️ **Lightsaber (Editor Launcher)**
- `deathstar lightsaber edit script.sh` — Opens file with lightsaber effect (default green).
- `deathstar lightsaber colors` — List options (green, blue, red, purple, yellow, cyan).
- `deathstar lightsaber help`

### 🚀 **Hyperdrive (Fast Navigation)**
- `deathstar hyperdrive jump src/` — Jumps to folder with hyperspace animation.
- `deathstar hyperdrive coords` — Shows current dir + nearby folders.
- `deathstar hyperdrive help`

### 👑 **Palpatine (Prompt Enhancer)**
- `deathstar palpatine "Explain async/await"` — Enhances your prompt text.
- `deathstar palpatine templates` — Lists styles (power, detailed, creative, code, explain).
- `deathstar palpatine help`

### 🎯 **Stormtrooper (Fuzzy File Finder)**
- `deathstar stormtrooper find "*.py"` — Fuzzy search files.
- `deathstar stormtrooper aim "exact-file.txt"` — Precise match.
- `deathstar stormtrooper help`

## 4. Example Daily Workflow
```bash
deathstar status                # Check the fleet
deathstar vader review          # Scan code before commit
deathstar yoda commit           # Generate message
git commit                      # Use the suggested message
deathstar vader push            # Push safely
deathstar tarkin deploy main    # "Deploy" with drama
deathstar yoda wisdom           # End with inspiration
```

## Directory Structure

```
DEATHSTAR/
├── deathstar              # Main executable router
├── commands/              # Character-themed subcommands
├── assets/                # ASCII art and static resources
├── docs/                  # Documentation, logs, and agent guide
├── bash/                  # Alias arsenals
├── LICENSE                # MIT License
└── README.md              # This file
```

## License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

*"The Force will be with you. Always."*

---

**Death Star CLI v1.1.0** - Refined, Cleaned, and Operational.
