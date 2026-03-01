# CLAUDE.md — Death Star CLI Suite

This file provides guidance for AI assistants (Claude and others) working on this codebase.

---

## Project Overview

**DEATHSTAR** is a Star Wars-themed CLI tools suite written entirely in Bash. It provides developer quality-of-life utilities (git helpers, system diagnostics, analytics, file search, etc.) wrapped in an Imperial/Rebel aesthetic with character-voiced outputs, ASCII art, and dramatic animations.

**Version:** 1.0.0
**Language:** Bash (4.0+)
**Target platform:** Linux/macOS/Termux (Android)

---

## Repository Structure

```
DEATHSTAR/
├── deathstar                    # Main entry point — routes all subcommands
├── commands/                    # One .sh file per subcommand
│   ├── vader.sh                 # Git enforcer (push, review)
│   ├── tarkin.sh                # Deployment (deploy, planet/branch-delete)
│   ├── yoda.sh                  # Commit messages & dev wisdom
│   ├── r2d2.sh                  # System diagnostics (scan, beep)
│   ├── thrawn.sh                # Repository analytics (repo)
│   ├── lightsaber.sh            # Animated file editor wrapper
│   ├── hyperdrive.sh            # Directory navigation with animation
│   ├── palpatine.sh             # Prompt enhancer/templates
│   ├── stormtrooper.sh          # Fuzzy file finder (find, aim)
│   └── status.sh                # Death Star ASCII + system health
├── assets/
│   └── ascii/                   # ASCII art text files for each character
│       ├── deathstar.txt
│       ├── vader.txt
│       ├── r2d2.txt
│       ├── yoda.txt
│       └── stormtrooper.txt
├── Imperial_git_aliases.sh      # Git config aliases with Imperial naming
├── __DEATH_STAR_INIT__.sh       # v1 home directory reorganization script
├── __DEATH_STAR_INIT_V2__.sh    # v2 init script
├── __DEATH_STAR_INIT_V3__.sh    # v3 init script
├── __dir__.md / __dir__.txt     # Directory structure notes
├── __dir__explained.md          # XDG directory philosophy docs
├── README.md                    # Full user-facing documentation
└── CLAUDE.md                    # This file
```

---

## Architecture & Conventions

### Command Routing Pattern

All subcommands follow an identical pattern:

1. **Entry point** (`deathstar` script) receives `<command> [subcommand] [args]`
2. It routes to `commands/<command>.sh` via `bash "$COMMANDS_DIR/${cmd}.sh" "$@"`
3. Each command script has its own `case` statement for subcommand dispatch
4. Default case for unknown subcommands shows help and exits with code `1`
5. Default when no subcommand given is `help`

```bash
# Routing in each command file
case "${1:-help}" in
    subcommand1) cmd_subcommand1 "$@" ;;
    subcommand2) cmd_subcommand2 "$@" ;;
    help|--help|-h) show_help ;;
    *) echo "Unknown command"; show_help; exit 1 ;;
esac
```

### Color System

Every script defines its own ANSI color variables (not imported from a shared file):

```bash
RED='\033[0;31m'
BOLD_RED='\033[1;31m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
WHITE='\033[1;37m'
BOLD_WHITE='\033[1;37m'
NC='\033[0m'  # Reset / No Color
```

Always wrap colored strings with `echo -e` and end with `${NC}`.

### Path Resolution

Each command script resolves its own paths:

```bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ASSETS_DIR="$(dirname "$SCRIPT_DIR")/assets/ascii"
```

This makes scripts relocatable and safe to call from any working directory.

### Character Quote Arrays

Each command defines an array of in-character quotes and a helper function:

```bash
VADER_QUOTES=("Quote one." "Quote two.")
random_vader_quote() {
    echo "${VADER_QUOTES[$RANDOM % ${#VADER_QUOTES[@]}]}"
}
```

### Visual Style

- **Headers/footers:** `═══` box-drawing lines in `${CYAN}`
- **Section labels:** Numbered `[1]`, `[2]`... in `${YELLOW}`
- **Success:** `${GREEN}` with `✓` checkmark prefix
- **Warnings:** `${YELLOW}` with `⚠️` prefix
- **Errors:** `${RED}` with descriptive character voice
- **Callout boxes:** `╔═══╗` / `║` / `╚═══╝` in theme color
- **Progress bars:** ASCII `█` filled + `░` empty, built with `printf` loops

---

## Commands Reference

### `deathstar` (Main Router)

| Subcommand | Description |
|---|---|
| `status` | Show ASCII art + system health (delegates to `status.sh`) |
| `launch <project>` | Scaffold new project with `src/`, `tests/`, `docs/`, `assets/`, `README.md`, `.gitignore`, and initial git commit |
| `help` / `--help` / `-h` | Show full command overview |
| `version` / `--version` / `-v` | Print version string |

### `vader` — Git Enforcer

| Subcommand | Behavior |
|---|---|
| `push` | Checks for protected branches (`main`, `master`, `operational`, `production`), lists uncommitted changes, outputs the `git push --force-with-lease` command but does NOT run it |
| `review` | Scans for TODOs, debug statements (`console.log`, `print(`, etc.), and files >100 lines |

### `tarkin` — Deployment Weapon

| Subcommand | Behavior |
|---|---|
| `deploy <branch>` | Simulates a deployment pipeline (animation only); outputs the actual `git checkout && git pull` command |
| `planet <branch>` | **Actually deletes** the branch with `git branch -D`; protects `main`/`master`/`operational`/`production` with confirmation gate |

### `yoda` — Wise Advisor

| Subcommand | Behavior |
|---|---|
| `commit` | Analyzes staged files by extension, generates a Yoda-style commit message suggestion, outputs the `git commit -m` command |
| `wisdom` | Prints a random Yoda quote + a developer tip |

### `r2d2` — System Diagnostics

| Subcommand | Behavior |
|---|---|
| `scan` | Disk usage (`df`), memory (`/proc/meminfo` or `free`), git status, system info (`uname`) — all with visual bars |
| `beep` | Prints a sequence of R2-D2 sound effects; attempts `speaker-test` or terminal bell (`\a`) |

### `thrawn` — Analytics

| Subcommand | Behavior |
|---|---|
| `repo` | Full git repo analysis: commit count, contributor stats, commit-by-weekday bars, file type breakdown, most-modified files, technical debt count, 30-day velocity, and a health score (0–100) |

### `lightsaber` — Animated Editor

| Subcommand | Behavior |
|---|---|
| `edit <file> [--color=<color>]` | Runs an ignition animation, then opens the file in `$EDITOR` / `nano` / `vim` / `vi` |
| `colors` | Lists available lightsaber colors |

Available colors: `green`, `blue`, `red`, `purple`, `yellow`, `cyan`

### `hyperdrive` — Navigation

| Subcommand | Behavior |
|---|---|
| `jump <folder>` | Hyperspace animation, then displays directory contents and outputs `cd <abs_path>` for the user to run (auto-`cd`s if `$HYPERSOURCE` is set) |
| `coords` | Shows `pwd`, parent dir, subdirectories, and recent `cd` commands from bash history |

### `palpatine` — Prompt Enhancer

| Subcommand | Behavior |
|---|---|
| `"<prompt>" [--template=<name>]` | Wraps the prompt in an enhancement template and prints the result |
| `templates` | Lists all available templates |

Available templates: `power` (default), `detailed`, `creative`, `code`, `explain`

### `stormtrooper` — Fuzzy Finder

| Subcommand | Behavior |
|---|---|
| `find <pattern>` | `find . -name "*<pattern>*"` with humor on zero results |
| `aim <pattern>` | Exact match (`find . -name "<pattern>"`), falls back to fuzzy on miss |

---

## Development Guidelines

### Adding a New Command

1. Create `commands/<name>.sh` following the existing template:
   - Shebang: `#!/bin/bash`
   - Header comment block
   - `SCRIPT_DIR` / `ASSETS_DIR` resolution
   - Color variable definitions
   - Character quote array + `random_<name>_quote()` function
   - `show_help()` function
   - `cmd_<subcommand>()` functions
   - `case "${1:-help}" in ...` router at the bottom

2. Register the new command name in `deathstar`'s main `case` statement:
   ```bash
   vader|tarkin|yoda|r2d2|thrawn|lightsaber|hyperdrive|palpatine|stormtrooper|<newname>)
       route_to_command "$command" "$@"
       ;;
   ```

3. Add an entry to `show_help()` in the main `deathstar` script.

4. Create an ASCII art file at `assets/ascii/<name>.txt` if the command displays character art.

### Script Conventions

- All scripts must be executable (`chmod +x`)
- Use `local` for function-scoped variables
- Quote all variable expansions: `"$variable"` not `$variable`
- Use `2>/dev/null` when calling `git` commands that may fail outside a repo
- Guard git operations with `[ -d ".git" ]` checks
- Use `sleep` sparingly — only for animation effect, not as a retry mechanism
- `exit 0` for user-cancelled operations; `exit 1` for errors
- Never actually run `git push` for the user — display the command to run instead (vader pattern)
- `tarkin planet` is the only command that performs a destructive git operation directly

### Git Operations Safety

- **vader push**: Displays the push command only — does not execute it
- **tarkin deploy**: Simulation only — does not execute git commands
- **tarkin planet**: Actually runs `git branch -D` — protected branches require typing `deathstar` to confirm
- The repo has protected branches: `main`, `master`, `operational`, `production`

### Testing Manually

There is no automated test suite. Test commands manually:

```bash
# Make executable
chmod +x deathstar commands/*.sh

# Test main routing
./deathstar help
./deathstar version
./deathstar status --brief

# Test subcommands (run from inside a git repo)
./deathstar vader review
./deathstar yoda wisdom
./deathstar r2d2 scan
./deathstar thrawn repo
./deathstar stormtrooper find "*.sh"

# Test project creation
./deathstar launch test-project
rm -rf test-project  # cleanup
```

### Imperial Git Aliases

`Imperial_git_aliases.sh` contains git config aliases to add to `~/.gitconfig`:

| Alias | Git Command | Description |
|---|---|---|
| `rebellion` | `fetch --all --prune` | Sync and prune dead branches |
| `ignite` | `push origin HEAD` | Push current branch |
| `clone-trooper` | `checkout -b` | Create a new branch |
| `blame-admiral` | `blame` | Annotated blame |

Add with: `git config --global alias.<name> "<command>"`

---

## Requirements

- **Bash 4.0+** — required for associative arrays and `[[ ]]`
- **Git** — required for all `vader`, `tarkin`, `yoda`, `thrawn`, and `status` git features
- **Standard Unix tools:** `grep`, `find`, `awk`, `sed`, `wc`, `sort`, `uniq`, `df`, `uname`
- **Optional:** `nano`/`vim`/`vi` (lightsaber edit), `free`/`/proc/meminfo` (r2d2 scan memory), `bc` (thrawn velocity calculation), `speaker-test` (r2d2 beep audio)

---

## Key Things to Avoid

- Do not introduce shared state between command scripts — each is standalone
- Do not use `pipefail` or `errexit` (`set -e`) globally — existing scripts handle errors locally
- Do not add interactive prompts (`read`) except where they already exist (branch protection gates)
- Do not add `sleep` calls beyond the existing animation sequences
- Do not rename or restructure the `commands/` directory — the router relies on `commands/${cmd}.sh` naming
- Do not add external dependencies (npm, python packages, etc.) — this suite must work with standard Unix tools only
