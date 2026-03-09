# ⚔️ Vader (Git Enforcer)

Lord Vader ensures the Empire's codebase remains pure and efficient. Use these commands to enforce Imperial standards in your repository.

## Commands

### `push`
**Usage:** `deathstar vader push [remote] [branch]`
Performs a protected push. It checks for common issues and asks for confirmation before sending code to the remote.

### `review`
**Usage:** `deathstar vader review`
Scans the current directory for common development artifacts that shouldn't be in production, such as:
- `TODO` markers
- Debugging logs (e.g., `console.log`, `print`)
- Excessively long functions
- Large files

### `help`
**Usage:** `deathstar vader help`
Displays the help menu for the Vader subcommand.

---
*"I find your lack of faith disturbing."*
