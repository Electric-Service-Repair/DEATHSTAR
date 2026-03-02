## Key Directories Explained
​1. ~/dev (The Engine Room)
​Instead of dumping everything into one folder, segment by context. This makes context-switching easier and helps with git configurations (e.g., using different emails for dev/work vs dev/personal via .gitconfig conditional includes).
​scratch/: Essential for keeping your main folders clean. If you need to test a library or write a script that you'll delete in an hour, do it here.
​2. ~/.config & ~/.local/bin (The Control Center)
​Adopting the XDG standard is the single best change you can make.
​.config/: Instead of dotfiles cluttering your root (like .gitconfig, .tmux.conf), modern apps look here. If an app tries to put a config in ~, check if it has a flag to move it here.
​.local/bin/: Place your custom shell scripts or compiled binaries here and add export PATH=$HOME/.local/bin:$PATH to your shell profile. It keeps them separate from system binaries.
​3. ~/dl vs ~/tmp
​dl/: For things you just downloaded and haven't sorted yet. Treat this as an inbox; clear it weekly.
​tmp/: For extractions, compilations, or file conversions. This is "working memory."
​Implementation Tips
​Dotfile Management: Use GNU Stow. You can keep all your config files in a git repository (e.g., ~/dev/personal/dotfiles) and symlink them into place.
​Example: ~/dev/personal/dotfiles/nvim -> symlinks to -> ~/.config/nvim.
​Hide the Clutter: If you are on macOS or Linux, you can hide default folders you don't use (like Public or Templates) using chflags hidden (macOS) or simply creating a .hidden file (Linux file managers).
​Automate Cleanup: Set up a cron job or systemd timer to delete files in ~/tmp or ~/dl that are older than 30 days.
​Next Step
​Would you like a snippet for a .bashrc or .zshrc function that automatically creates a project directory and navigates into it, adhering to this structure?
