# CLAUDE.md — DEATHSTAR CLI Suite

AI assistant guidance for the DEATHSTAR repository.

## Project Overview

DEATHSTAR is a **Star Wars-themed developer CLI toolkit** written entirely in Bash. It wraps common developer workflows (git, system diagnostics, file management, deployments) in character-themed interfaces with ASCII art and ANSI color output.

- **Language:** Bash (100%)
- **Version:** 1.0.0
- **Entry point:** `./deathstar` (executable, in repo root)
- **Architecture:** Router pattern — main script dispatches to per-character subcommands in `commands/`

---

## Repository Structure

```
DEATHSTAR/
├── deathstar                    # Main CLI router (executable)
├── commands/                    # One script per character/command
│   ├── vader.sh                 # Git enforcer (push, review)
│   ├── tarkin.sh                # Deployment tool (deploy, planet)
│   ├── yoda.sh                  # Commit advisor (commit, wisdom)
│   ├── r2d2.sh                  # System diagnostics (scan, beep)
│   ├── thrawn.sh                # Repo analytics (repo)
│   ├── lightsaber.sh            # Editor wrapper (edit)
│   ├── hyperdrive.sh            # Directory navigation (jump, coords)
│   ├── palpatine.sh             # Prompt enhancer / AI templates
│   ├── stormtrooper.sh          # Fuzzy file finder (find, aim)
│   └── status.sh                # System status + Death Star ASCII
├── assets/
│   └── ascii/                   # ASCII art files (.txt)
│       ├── deathstar.txt
│       ├── vader.txt
│       ├── r2d2.txt
│       ├── yoda.txt
│       ├── stormtrooper.txt
│       └── sabre2.txt
├── README.md                    # Main user-facing documentation
├── CLOUD_ARCHITECTURE.md        # Multi-cloud / LiteLLM integration guide
├── HEADLESS_MODE.md             # Headless / CI usage instructions
├── install-pro.sh               # Installer for Gemini Pro CLI integration
├── Imperial_git_aliases.sh      # Custom git aliases
├── __DEATH_STAR_INIT__.sh       # Initialization scripts (v1/v2/v3)
├── __DEATH_STAR_INIT_V2__.sh
├── __DEATH_STAR_INIT_V3__.sh
└── d__dir_structure.sh          # Directory scaffolding helper
```

---

## Commands Reference

Run `./deathstar help` for the full overview. Each subcommand also accepts `help` as its first argument.

| Command | Character | Purpose |
|---|---|---|
| `deathstar status` | — | System health + Death Star ASCII banner |
| `deathstar launch <name>` | — | Scaffold a new project directory |
| `deathstar vader push` | Darth Vader | Protected git push with branch warnings |
| `deathstar vader review` | Darth Vader | Scan for TODOs, console.log, long functions |
| `deathstar yoda commit` | Yoda | Auto-generate commit messages |
| `deathstar yoda wisdom` | Yoda | Developer wisdom quotes |
| `deathstar r2d2 scan` | R2-D2 | Disk/memory/git diagnostics |
| `deathstar r2d2 beep` | R2-D2 | Audio beep (requires speaker-test) |
| `deathstar tarkin deploy <branch>` | Grand Moff Tarkin | Deployment simulation |
| `deathstar tarkin planet` | Grand Moff Tarkin | Planetary target selection |
| `deathstar thrawn repo` | Grand Admiral Thrawn | Full repo analytics + health score |
| `deathstar lightsaber edit <file>` | — | Open file in editor with effects |
| `deathstar hyperdrive jump <dir>` | — | Navigate directories with animation |
| `deathstar hyperdrive coords` | — | Show current location |
| `deathstar palpatine` | Palpatine | AI prompt templates and enhancer |
| `deathstar stormtrooper find <term>` | Stormtrooper | Fuzzy file search |
| `deathstar stormtrooper aim` | Stormtrooper | Interactive file targeting |

---

## Development Conventions

### Bash Code Style

All scripts follow this consistent structure:

1. **Shebang + header block** — 3-line comment block naming the command and its purpose
2. **Path setup** — `SCRIPT_DIR` and `ASSETS_DIR` via `"$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"`
3. **Color constants** — ANSI codes defined at the top of each file
4. **Character quotes array** — `CHARACTER_QUOTES=("..." "..." ...)` + `random_*_quote()` function
5. **`show_help()` function** — Boxed help display using `═` borders
6. **`cmd_*()` functions** — One function per subcommand
7. **Main router** — `case` statement at the bottom dispatching to `cmd_*` functions

**Naming conventions:**
- Functions: `snake_case` (e.g., `cmd_push`, `show_help`, `random_vader_quote`)
- Constants/colors: `UPPER_CASE` (e.g., `RED`, `BOLD_RED`, `SCRIPT_DIR`)
- Runtime variables: `lowercase` (e.g., `branch`, `project_name`)
- Script files: `lowercase.sh`

**Indentation:** 4 spaces (no tabs)

**Color scheme per character:**
| Color | Used by |
|---|---|
| `BOLD_RED` / `RED` | Vader, Tarkin (danger, authority) |
| `GREEN` | Yoda (wisdom, success) |
| `BLUE` | R2-D2 (info, diagnostics) |
| `PURPLE` | Thrawn, Palpatine (analysis, power) |
| `CYAN` | General UI, headers, structure |
| `YELLOW` | Warnings, emphasis, usage lines |

### Adding a New Command

1. Create `commands/<name>.sh` following the established template (see `commands/vader.sh` as reference)
2. Make it executable: `chmod +x commands/<name>.sh`
3. Add a routing case in `deathstar` main router (`route_to_command` will auto-handle it if the filename matches)
4. Update the `show_help()` function in `deathstar` to list the new command
5. Add ASCII art to `assets/ascii/<name>.txt` if needed

### Routing

The main `deathstar` script uses two mechanisms:
- **Direct commands:** `status` and `launch` are handled inline in `main()`
- **Subcommands:** All character commands are routed via `route_to_command()` which calls `bash "$COMMANDS_DIR/${cmd}.sh" "$@"`

---

## Running & Testing

There is **no automated test framework**. Testing is manual:

```bash
# Make executable (first time)
chmod +x deathstar commands/*.sh

# Verify routing works
./deathstar help
./deathstar status
./deathstar version

# Test a specific command
./deathstar vader --help
./deathstar yoda wisdom
./deathstar r2d2 scan

# Test project scaffolding (creates a directory)
./deathstar launch my-test-project
```

Run each command with `help` after changes to confirm the help text still renders correctly.

---

## Installation

```bash
# Basic install — add to PATH
export PATH="$PATH:/path/to/DEATHSTAR"

# Optional: Gemini Pro integration
bash install-pro.sh
# This installs Node.js, @google/generative-ai SDK,
# and creates a global `gemini-pro` CLI command + `ask` alias

# Optional: Custom git aliases
bash Imperial_git_aliases.sh
# Adds: git rebellion, git ignite, git clone-trooper, git blame-admiral
```

---

## Git Workflow

The repository uses a **PR-merge pattern**. Feature work goes on named branches and is merged via pull requests. There is no CI/CD pipeline; merging is manual.

**Custom git aliases** (from `Imperial_git_aliases.sh`):
- `git rebellion` → `fetch --all --prune`
- `git ignite` → `push origin HEAD`
- `git clone-trooper` → `checkout -b`
- `git blame-admiral` → `blame`

**Commit signing** is configured in `.git/config` (SSH key signing, GPG format).

**Development branch for this session:** `claude/deathstar-setup-SPncZ`

---

## External Integrations

| Integration | Purpose | Required |
|---|---|---|
| Google Gemini API | AI prompt enhancement (palpatine), Gemini Pro CLI | Optional |
| AWS | Backup/failover compute | Optional |
| xAI Grok | Edge computing | Optional |
| LiteLLM | Multi-provider AI abstraction | Optional |
| Terraform | Infrastructure as code | Optional |
| Docker | Containerized deployments | Optional |

See `CLOUD_ARCHITECTURE.md` for multi-cloud setup and `HEADLESS_MODE.md` for CI/headless usage patterns.

---

## Key Files for AI Assistants

| File | Why It Matters |
|---|---|
| `deathstar` | Entry point; understand routing before adding commands |
| `commands/vader.sh` | Canonical template for new command scripts |
| `README.md` | Full user-facing docs; keep in sync with any command changes |
| `CLOUD_ARCHITECTURE.md` | Cloud/AI integration architecture |
| `HEADLESS_MODE.md` | How to use in non-interactive/CI contexts |
| `install-pro.sh` | Gemini Pro installer; modifies system PATH |

---

## Things to Avoid

- Do not add external package managers (npm, pip, etc.) as hard dependencies — the project is intentionally pure Bash
- Do not break the consistent color/character theming when adding new commands
- Do not use `#!/bin/sh` — scripts rely on Bash-specific features (`[[ ]]`, arrays, `BASH_SOURCE`)
- Do not use `cd` without returning to the original directory (`pushd`/`popd` or subshells) except in `cmd_launch` where directory change is intentional
- Avoid interactive prompts that block headless/CI use; check `HEADLESS_MODE.md` for guidance
